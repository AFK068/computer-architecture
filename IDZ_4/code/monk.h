#ifndef MONK_H
#define MONK_H

#include <fstream>
#include <random>
#include <vector>

#include "config.h"

struct Monk {
  Monk(int id, int qi_energy);
  ~Monk();

  int id;
  int qi_energy;
  pthread_mutex_t
      monk_mutex;  // Мьютекс для синхронизации доступа к энергии монаха.
};

std::vector<Monk*>* load_monks_from_file(const std::string& filename);
std::vector<Monk*>* create_monks_from_data(const std::vector<int>& data);
std::vector<Monk*>* create_monks(Config& config);

#endif