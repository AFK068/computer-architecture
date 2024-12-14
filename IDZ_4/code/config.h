#ifndef CONFIG_H
#define CONFIG_H

#include <iostream>
#include <string>
#include <vector>

struct Config {
  Config(bool generate_data, long long left_bound, long long right_bound,
         long long number_monks, const std::string& input_file,
         const std::string& output_file, const std::vector<int>& direct_data)
      : generate_data(generate_data),
        left_bound(left_bound),
        right_bound(right_bound),
        number_monks(number_monks),
        input_file(input_file),
        output_file(output_file),
        direct_data(direct_data) {}

  // Автоген данных.
  bool generate_data = false;

  // Левая граница для автогенерации данных.
  long long left_bound = 0;

  // Правая граница для автогенерации данных.
  long long right_bound = 0;

  // Количество монахов.
  long long number_monks = 0;

  // Имя файла с входными данными.
  std::string input_file;

  // Имя файла с выходными данными.
  std::string output_file;

  // Данные вводимые через консоль.
  std::vector<int> direct_data;
};

#endif