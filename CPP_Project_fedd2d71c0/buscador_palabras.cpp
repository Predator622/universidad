#include "buscador_palabras.h"
#include <algorithm>

BuscadorPalabras::BuscadorPalabras(const std::string& subcadena) : subcadena_(subcadena) {}

std::vector<std::pair<int, std::string>> BuscadorPalabras::buscarPorInicio(const std::vector<std::pair<int, std::string>>& lines) const {
    std::vector<std::pair<int, std::string>> resultados;
    for (const auto& line : lines) {
        if (line.second.find(subcadena_) == 0) { // Comienza con la subcadena
            resultados.push_back(line);
        }
    }
    return resultados;
}

std::vector<std::pair<int, std::string>> BuscadorPalabras::buscarContiene(const std::string& substring, const std::vector<std::pair<int, std::string>>& lines) const {
    std::vector<std::pair<int, std::string>> resultados;
    for (const auto& line : lines) {
        if (line.second.find(substring) != std::string::npos) { // Contiene la subcadena
            resultados.push_back(line);
        }
    }
    return resultados;
}

std::vector<std::pair<int, std::string>> BuscadorPalabras::buscarInverso(const std::string& substring_invertida, const std::vector<std::pair<int, std::string>>& lines) const {
    std::vector<std::pair<int, std::string>> resultados;
    for (const auto& line : lines) {
        if (line.second.find(substring_invertida) != std::string::npos) { // Contiene la subcadena invertida
            resultados.push_back(line);
        }
    }
    return resultados;
}