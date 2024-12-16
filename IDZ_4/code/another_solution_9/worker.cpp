#include <pthread.h>

#include "fight_data.cpp"

std::vector<Monk*> monks_pool;
pthread_mutex_t pool_mutex =
    PTHREAD_MUTEX_INITIALIZER;                        // Мьютекс для защиты пула
pthread_cond_t pool_cond = PTHREAD_COND_INITIALIZER;  // Условная переменная
bool stop_flag = false;  // Флаг для завершения потоков
const int NUM_MONKS = 5;

void* battle_thread(void* args) {
  while (true) {
    Monk* monk1 = nullptr;
    Monk* monk2 = nullptr;

    // Ожидание монахов в пуле
    pthread_mutex_lock(&pool_mutex);
    while (monks_pool.size() < 2 && !stop_flag) {
      pthread_cond_wait(&pool_cond, &pool_mutex);
    }

    // Проверяем завершение работы
    if (stop_flag && monks_pool.size() < 2) {
      pthread_mutex_unlock(&pool_mutex);
      break;
    }

    // Извлекаем пару монахов
    monk1 = monks_pool.back();
    monks_pool.pop_back();
    
    monk2 = monks_pool.back();
    monks_pool.pop_back();
    pthread_mutex_unlock(&pool_mutex);

    // Проводим бой
    Fight fight(monk1, monk2);
    fight.fight();

    // Возвращаем победителя в пул
    pthread_mutex_lock(&pool_mutex);
    if (monk1->qi_energy > 0) {
      monks_pool.push_back(monk1);
    } else if (monk2->qi_energy > 0) {
      monks_pool.push_back(monk2);
    }

    pthread_cond_broadcast(&pool_cond);
    pthread_mutex_unlock(&pool_mutex);
  }

  return nullptr;
}
