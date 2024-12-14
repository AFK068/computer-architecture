#include <pthread.h>

#include "fight_data.cpp"

std::vector<Monk*> monks_pool;
pthread_mutex_t pool_mutex =
    PTHREAD_MUTEX_INITIALIZER;  // POSIX мьютекс для пула монахов
const int NUM_MONKS = 5;

// Функция для потоков
void* battle_thread(void* args) {
  while (true) {
    Monk* monk1 = nullptr;
    Monk* monk2 = nullptr;

    // Извлечение пары монахов
    pthread_mutex_lock(&pool_mutex);
    if (monks_pool.size() < 2) {
      pthread_mutex_unlock(&pool_mutex);
      break;  // Недостаточно монахов для боя
    }

    monk1 = monks_pool.back();
    monks_pool.pop_back();

    monk2 = monks_pool.back();
    monks_pool.pop_back();

    pthread_mutex_unlock(&pool_mutex);

    // Проведение боя
    Fight fight(monk1, monk2);
    fight.fight();

    // Возвращение победителя в пул
    pthread_mutex_lock(&pool_mutex);
    if (monk1->qi_energy > 0) {
      monks_pool.push_back(monk1);
    } else if (monk2->qi_energy > 0) {
      monks_pool.push_back(monk2);
    }
    pthread_mutex_unlock(&pool_mutex);
  }
  return nullptr;
}