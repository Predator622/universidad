#include <iostream>
#include "utils.h"
#include "buscador_palabras.h"

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Uso: ./mi_programa archivo.txt subcadena" << std::endl;
        return -1;
    }

    std::string filename = argv[1];
    std::string substring = argv[2];

    // Leer el archivo y procesar las líneas
    auto lines = read_file(filename);

    BuscadorPalabras buscador(substring);
    
    // Búsqueda de palabras que comienzan con la subcadena
    auto resultados_inicio = buscador.buscarPorInicio(lines);
    imprimirResultados(resultados_inicio, "Comienzan por");

    // Búsqueda de palabras que contienen la subcadena
    auto resultados_contienen = buscador.buscarContiene(substring, lines);
    imprimirResultados(resultados_contienen, "Contienen");

    // Búsqueda de palabras que contienen la subcadena invertida
    std::string substring_invertido = invertirCadena(substring);
    auto resultados_invertidos = buscador.buscarInverso(substring_invertido, lines);
    imprimirResultados(resultados_invertidos, "Contienen Invertido");

    return 0;
}