#include "fight_data.h"

#include <pthread.h>
#include <unistd.h>

#include <iostream>

std::ofstream output_file_stream;

Fight::Fight(Monk* m1, Monk* m2) : monk1(m1), monk2(m2) {
  fight_time = calculate_fight_time(m1, m2);
}

long long Fight::calculate_fight_time(Monk* monk1, Monk* monk2,
                                      int coefficient) {
  double ratio = (monk1->qi_energy > monk2->qi_energy)
                     ? static_cast<double>(monk2->qi_energy) / monk1->qi_energy
                     : static_cast<double>(monk1->qi_energy) / monk2->qi_energy;

  return static_cast<long long>(ratio * coefficient);
}

void Fight::fight() {
  usleep(fight_time * 1000);  // По ТЗ для иммитации времени поединка.

  pthread_mutex_lock(&monk1->monk_mutex);
  pthread_mutex_lock(&monk2->monk_mutex);

  if (monk1->qi_energy > monk2->qi_energy) {
    monk1->qi_energy += monk2->qi_energy;
    std::cout << "Monk " << monk1->id << " wins over Monk " << monk2->id
              << " with fight time " << fight_time << " ms" << "| Monk "
              << monk1->id << " Qi Energy: " << monk1->qi_energy << "\n";

    if (output_file_stream.is_open()) {
      output_file_stream << "Monk " << monk1->id << " wins over Monk "
                         << monk2->id << " with fight time " << fight_time
                         << " ms" << "| Monk " << monk1->id
                         << " Qi Energy: " << monk1->qi_energy << "\n";
    }

    monk2->qi_energy = 0;
  } else {
    monk2->qi_energy += monk1->qi_energy;
    std::cout << "Monk " << monk2->id << " wins over Monk " << monk1->id
              << " with fight time " << fight_time << " ms" << "| Monk "
              << monk2->id << " Qi Energy: " << monk2->qi_energy << "\n";

    if (output_file_stream.is_open()) {
      output_file_stream << "Monk " << monk2->id << " wins over Monk "
                         << monk1->id << " with fight time " << fight_time
                         << " ms" << "| Monk " << monk2->id
                         << " Qi Energy: " << monk2->qi_energy << "\n";
    }

    monk1->qi_energy = 0;
  }

  pthread_mutex_unlock(&monk2->monk_mutex);
  pthread_mutex_unlock(&monk1->monk_mutex);
}