#ifndef BUSCADOR_PALABRAS_H
#define BUSCADOR_PALABRAS_H

#include <string>
#include <vector>

class BuscadorPalabras {
public:
    BuscadorPalabras(const std::string& subcadena);
    
    std::vector<std::pair<int, std::string>> buscarPorInicio(const std::vector<std::pair<int, std::string>>& lines) const;
    std::vector<std::pair<int, std::string>> buscarContiene(const std::string& substring, const std::vector<std::pair<int, std::string>>& lines) const;
    std::vector<std::pair<int, std::string>> buscarInverso(const std::string& substring_invertida, const std::vector<std::pair<int, std::string>>& lines) const;

private:
    std::string subcadena_;
};

#endif // BUSCADOR_PALABRAS_H