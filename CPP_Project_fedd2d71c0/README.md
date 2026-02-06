### README.md

#### Resumen
Este proyecto implementa un programa en C++ que busca palabras en archivos de texto basándose en subcadenas proporcionadas por el usuario. El programa utiliza estructuras lineales para almacenar y procesar las líneas del archivo, así como para realizar la búsqueda de palabras.

#### Arquitectura

- **main.cpp**: Maneja la entrada/salida estándar, lectura del archivo y llamadas a funciones para buscar palabras.
- **utils.h/cpp**: Contiene funciones auxiliares para procesamiento de cadenas y estructuras de datos necesarias.
- **buscador_palabras.h/cpp**: Implementa el TAD que realiza la búsqueda de palabras en función de subcadenas.

#### Flujo del Programa

1. El programa recibe un archivo de texto y una subcadena como argumentos desde la línea de comandos.
2. Se lee el archivo línea por línea, almacenando cada línea en una estructura lineal.
3. Se crean instancias de las funciones auxiliares y se realiza la búsqueda de palabras que:
   - Comienzan con la subcadena dada.
   - Contienen la subcadena dada (en cualquier posición).
   - Contienen la subcadena invertida.

#### Validaciones/Casos Bordes

- Se validan los argumentos proporcionados por el usuario para asegurar que se ha proporcionado un archivo y una subcadena válidos.
- Se manejan excepciones en caso de que el archivo no exista o esté vacío.

#### Cómo Validé
Para validar la implementación, se realizaron pruebas básicas (smoke tests) ejecutando el programa con diferentes archivos de texto y subcadenas. Estos tests incluyen:
- Verificar la correcta lectura del archivo.
- Probar la búsqueda de palabras que comienzan por la subcadena dada.
- Probar la búsqueda de palabras que contienen la subcadena en cualquier posición.
- Probar la búsqueda de palabras que contienen la subcadena invertida.

Estas pruebas aseguran que el programa funcione correctamente y maneje adecuadamente los casos borde.