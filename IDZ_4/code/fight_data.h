#ifndef FIGHTDATA_H
#define FIGHTDATA_H

#include <unistd.h>  // Для sleep.

#include <iostream>

#include "monk.cpp"

struct Fight {
  Fight(Monk* m1, Monk* m2);

  long long calculate_fight_time(Monk* monk1, Monk* monk2,
                                 int coefficient = 1000);

  void fight();

  Monk* monk1;
  Monk* monk2;
  long long fight_time;
};

#endif