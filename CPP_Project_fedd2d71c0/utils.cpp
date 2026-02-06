#include "utils.h"
#include <fstream>
#include <sstream>
#include <algorithm> // Para std::reverse
#include <iostream>  // Para std::cout

std::vector<std::pair<int, std::string>> read_file(const std::string& filename) {
    std::ifstream file(filename);
    if (!file.is_open()) {
        throw std::runtime_error("No se pudo abrir el archivo");
    }

    std::vector<std::pair<int, std::string>> lines;
    int line_number = 1;
    std::string line;
    while (std::getline(file, line)) {
        lines.push_back({line_number, line});
        ++line_number;
    }
    return lines;
}

std::string invertirCadena(const std::string& cadena) {
    std::string reversed = cadena;
    std::reverse(reversed.begin(), reversed.end());
    return reversed;
}

void imprimirResultados(const std::vector<std::pair<int, std::string>>& resultados, const std::string& mensaje) {
    std::cout << "Palabras que " << mensaje << ": " << resultados.size() << std::endl;
    for (const auto& resultado : resultados) {
        std::cout << "Línea " << resultado.first << ": " << resultado.second << std::endl;
    }
}