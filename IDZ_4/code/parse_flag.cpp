#include "config.h"
#include "input_parser.h"

// Получить границу для генерации данных.
long long get_bound(InputParser *input_parser, const std::string &option) {
  if (input_parser->cmdOptionExists(option)) {
    try {
      return std::stoll(input_parser->getCmdOption(option));
    } catch (const std::invalid_argument &e) {
      throw std::invalid_argument("Invalid number in " + option + " option");
    }
  } else {
    throw std::invalid_argument("No " + option + " bound for generate data");
  }
}

// Получить опцию (имена файлов).
std::string get_option(InputParser *input_parser, const std::string &option) {
  if (input_parser->cmdOptionExists(option)) {
    return input_parser->getCmdOption(option);
  }

  return "";
}

// Получить данные вводимые через консоль.
std::vector<int> get_direct_data(InputParser *input_parser) {
  std::vector<int> direct_data;

  if (input_parser->cmdOptionExists("-direct")) {
    std::string direct_data_str = input_parser->getCmdOption("-direct");

    std::string delimiter = ",";
    size_t pos = 0;
    std::string token;

    while ((pos = direct_data_str.find(delimiter)) != std::string::npos) {
      token = direct_data_str.substr(0, pos);

      try {
        direct_data.push_back(std::stoi(token));
      } catch (const std::invalid_argument &e) {
        throw std::invalid_argument("Invalid number in -direct option: " +
                                    token);
      }

      direct_data_str.erase(0, pos + delimiter.length());
    }

    direct_data.push_back(std::stoi(direct_data_str));
  }

  return direct_data;
}

Config parse_flag_to_config(InputParser *input_parser) {
  // Флаг на необходимость генерации данных.
  bool generate_data = false;
  long long left_bound = 0;
  long long right_bound = 0;
  long long number_monks = 0;

  if (input_parser->cmdOptionExists("-generate")) {
    generate_data = true;

    left_bound = get_bound(input_parser, "-left");
    right_bound = get_bound(input_parser, "-right");
    number_monks = get_bound(input_parser, "-monks");

    if (left_bound > right_bound) {
      throw std::invalid_argument("Left bound is greater than right bound");
    }

    if (number_monks <= 0) {
      throw std::invalid_argument("Number of monks must be greater than 0");
    }
  }

  // Имя файла с выходными данными.
  std::string output_file = get_option(input_parser, "-output");

  // Имя файла с входными данными.
  std::string input_file = get_option(input_parser, "-input");

  if (generate_data) {
    return Config(generate_data, left_bound, right_bound, number_monks,
                  input_file, output_file, {});
  }

  // Данные вводимые через консоль.
  std::vector<int> direct_data = get_direct_data(input_parser);

  if (direct_data.empty() && input_file.empty()) {
    throw std::invalid_argument("No data for monks");
  }

  return Config(generate_data, left_bound, right_bound, number_monks,
                input_file, output_file, direct_data);
}