### README.md

#### Resumen
Este proyecto implementa un programa en C++ que utiliza el algoritmo de Dijkstra para encontrar la ruta más corta entre dos puntos dados en una malla dada por un archivo de entrada. El código está estructurado en tres archivos principales: `main.cpp`, `graph.h/cpp` y `dijkstra_algorithm.h/cpp`.

#### Arquitectura del Proyecto
- **main.cpp**: Archivo principal que lee la entrada del usuario, construye el grafo a partir del archivo de entrada y llama al algoritmo Dijkstra para encontrar la ruta más corta.
- **graph.h/graph.cpp**: Implementación de una clase gráfica (`Graph`) que representa el grafo basado en los puntos y aristas proporcionados por el archivo de entrada.
- **dijkstra_algorithm.h/dijkstra_algorithm.cpp**: Implementación del algoritmo Dijkstra para encontrar la ruta más corta entre dos vértices.

#### Flujo del Programa
1. El programa principal (`main.cpp`) lee un archivo de entrada que contiene información sobre los puntos y las aristas en el grafo.
2. Se construye una instancia de `Graph` utilizando los datos leídos del archivo.
3. Se llama a la función `find_shortest_path` desde `dijkstra_algorithm.h/cpp`, pasando el grafo, el índice del punto inicial y el índice del punto final.
4. El algoritmo Dijkstra calcula la ruta más corta entre los dos puntos y devuelve una lista de índices de vértices que forman esta ruta.

#### Validaciones/Casos Bordes
- Se valida que se proporcionen exactamente tres argumentos en la línea de comandos: el nombre del archivo, el índice inicial y el índice final.
- Se asegura que los índices iniciales y finales sean válidos (dentro del rango de vértices existentes).
- Se manejan casos donde no hay camino posible entre dos puntos.

#### Cómo Validé
1. Ejecuté el programa con diferentes archivos de entrada para verificar la construcción correcta del grafo.
2. Realicé pruebas unitarias en `dijkstra_algorithm.cpp` para asegurar que el algoritmo Dijkstra funcione correctamente en varios escenarios, incluyendo gráficos vacíos y sin conexiones.

Este README proporciona una visión general clara de cómo funciona el programa y cómo se estructura el código.