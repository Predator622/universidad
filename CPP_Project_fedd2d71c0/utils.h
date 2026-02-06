#ifndef UTILS_H
#define UTILS_H

#include <vector>
#include <string>

std::vector<std::pair<int, std::string>> read_file(const std::string& filename);
std::string invertirCadena(const std::string& cadena);
void imprimirResultados(const std::vector<std::pair<int, std::string>>& resultados, const std::string& mensaje);

#endif // UTILS_H