#include <pthread.h>
#include <unistd.h>

#include <iostream>
#include <queue>
#include <vector>

#include "parse_flag.cpp"
#include "worker.cpp"

int main(int argc, char **argv) {
  // Инициализация конфига
  InputParser input_parser(argc, argv);
  Config config = parse_flag_to_config(&input_parser);
  monks_pool = *create_monks(config);

  if (!config.output_file.empty()) {
    output_file_stream.open(config.output_file);

    if (!output_file_stream.is_open()) {
      std::cerr << "Error: Unable to open output file: " << config.output_file
                << "\n";
      return 1;
    }
  }

  pthread_t threads[NUM_MONKS];
  for (int i = 0; i < NUM_MONKS; ++i) {
    pthread_create(&threads[i], nullptr, battle_thread, nullptr);
  }

  // Ожидание завершения всех боев
  while (true) {
    pthread_mutex_lock(&pool_mutex);
    if (monks_pool.size() < 2) {
      stop_flag = true;  // Устанавливаем флаг завершения, если боев больше нет
      pthread_cond_broadcast(&pool_cond);
      pthread_mutex_unlock(&pool_mutex);
      break;
    }
    pthread_mutex_unlock(&pool_mutex);
  }

  // Ожидание завершения потоков
  for (int i = 0; i < NUM_MONKS; ++i) {
    pthread_join(threads[i], nullptr);
  }

  // Вывод победителя
  pthread_mutex_lock(&pool_mutex);
  if (!monks_pool.empty()) {
    std::cout << "Final Winner: Monk " << monks_pool[0]->id
              << " with Qi Energy: " << monks_pool[0]->qi_energy << "\n";

    if (output_file_stream.is_open()) {
      output_file_stream << "Final Winner: Monk " << monks_pool[0]->id
                         << " with Qi Energy: " << monks_pool[0]->qi_energy
                         << "\n";
    }
  } else {
    std::cout << "No winner, all monks defeated!\n";

    if (output_file_stream.is_open()) {
      output_file_stream << "No winner, all monks defeated!\n";
    }
  }
  pthread_mutex_unlock(&pool_mutex);

  for (auto monk : monks_pool) {
    delete monk;
  }

  pthread_mutex_destroy(&pool_mutex);
  pthread_cond_destroy(&pool_cond);

  return 0;
}