#include "monk.h"

Monk::Monk(int id, int qi_energy) : id(id), qi_energy(qi_energy) {
  pthread_mutex_init(&monk_mutex, nullptr);
}

Monk::~Monk() { pthread_mutex_destroy(&monk_mutex); }

std::vector<Monk*>* load_monks_from_file(const std::string& filename) {
  auto* monks = new std::vector<Monk*>();
  std::ifstream file(filename);

  if (!file.is_open()) {
    throw std::runtime_error("Error: Unable to open input file.");
  }

  int id = 1;
  long long qi;

  while (file >> qi) {
    monks->push_back(new Monk(id++, qi));
  }

  return monks;
}

std::vector<Monk*>* create_monks_from_data(const std::vector<int>& data) {
  auto* monks = new std::vector<Monk*>();

  for (size_t i = 0; i < data.size(); ++i) {
    monks->push_back(new Monk(i + 1, data[i]));
  }

  return monks;
}

std::vector<Monk*>* create_monks(Config& config) {
  auto* monks = new std::vector<Monk*>();

  // Если данные необходимо сгенерировать.
  if (config.generate_data) {
    std::mt19937 gen(time(nullptr));
    std::uniform_int_distribution<int> dist(config.left_bound,
                                            config.right_bound);

    for (int i = 0; i < config.number_monks; ++i) {
      monks->push_back(new Monk(i + 1, dist(gen)));
    }

    return monks;
  }

  // Если данные необходимо загрузить из файла.
  if (!config.input_file.empty() && !config.generate_data) {
    auto* file_monks = load_monks_from_file(config.input_file);

    monks->insert(monks->end(), file_monks->begin(), file_monks->end());

    delete file_monks;

    return monks;
  }

  // Если данные введены через консоль.
  if (!config.direct_data.empty() && !config.generate_data &&
      config.input_file.empty()) {
    auto* data_monks = create_monks_from_data(config.direct_data);

    monks->insert(monks->end(), data_monks->begin(), data_monks->end());

    delete data_monks;

    return monks;
  }

  return monks;
}