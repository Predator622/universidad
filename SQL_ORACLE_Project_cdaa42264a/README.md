# README

## Resumen

Este repositorio contiene el trabajo realizado para un taller de consultas SQL utilizando Oracle SQL Developer y la base de datos DB_world. Se incluyen scripts SQL, resultados en pantalla y respuestas a preguntas en formato PDF.

## Arquitectura del Proyecto

### Archivos Incluidos
- `taller_sql.pdf`: Documento con respuestas a las preguntas, código SQL y resultados.
- `script.sql`: Script SQL que contiene todas las consultas realizadas para el taller.
- `01-DDL.sql`: DDL (Data Definition Language) para crear la estructura de base de datos.
- `02-Data_Insert.sql`: Data Insert para poblar la base de datos con datos iniciales.

## Flujo del Trabajo

### Paso 1: Configuración Inicial
- Se bajan los archivos `01-DDL.sql` y `02-Data_Insert.sql`.
- Se cargan estos archivos en Oracle SQL Developer.
- Se verifica que los datos hayan sido correctamente insertados ejecutando consultas como `DESCRIBE country;`, `SELECT * FROM country;`, etc.

### Paso 2: Ejecución de Consultas
- Se realizan las consultas requeridas y se documenta el proceso en `script.sql`.
- Para cada consulta relevante, se incluyen pantallazos que muestran los resultados obtenidos.
- Las respuestas a las preguntas del taller se registran en `taller_sql.pdf`.

### Paso 3: Validación
- Se ejecutan pruebas básicas (smoke tests) para verificar la integridad de los datos y el funcionamiento correcto de las consultas.

## Checklist REQ_XX

| Requisito | Descripción | Archivo/Función |
|-----------|-------------|-----------------|
| REQ_01    | Taller 2 - Consultas SQL | taller_sql.pdf, script.sql |
| REQ_02    | Documento en formato pdf con la respuesta a cada pregunta | taller_sql.pdf |
| REQ_03    | Código de consulta y resultado en pantalla | taller_sql.pdf |
| REQ_04    | Todas las consultas deberán ser entregadas en un script .sql | script.sql |
| REQ_05    | Consultas SQL: Cada consulta que se explique debe tener un pantallazo del resultado | taller_sql.pdf, script.sql |
| REQ_06    | Pantallazos de resultados para cada consulta relevante | taller_sql.pdf |
| REQ_07    | Usar Base de Datos del Grupo | 01-DDL.sql, 02-Data_Insert.sql, script.sql |
| REQ_08    | Cargar el archivo DB_world.sql | 01-DDL.sql, 02-Data_Insert.sql |
| REQ_09    | Bajar archivos 01-DDL.sql y 02-Data_Insert.sql | 01-DDL.sql, 02-Data_Insert.sql |
| REQ_10    | Verificar si los datos fueron cargados | script.sql |
| REQ_11    | DESCRIBE country; | script.sql |
| REQ_12    | Verificar si tienen datos | script.sql |
| REQ_13    | SELECT * FROM country; | script.sql |
| REQ_14    | SELECT * FROM city; | script.sql |
| REQ_15    | SELECT * FROM countrylanguage; | script.sql |
| REQ_16    | Explique las tablas y que relación existen entre ellas. | taller_sql.pdf, script.sql |
| REQ_17    | Búsqueda básica: Ejecutar consultas básicas de búsqueda | script.sql |
| REQ_18-21