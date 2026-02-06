#include "dijkstra_algorithm.h"
#include <queue>
#include <limits>
#include <algorithm> // Para std::reverse

std::vector<int> find_shortest_path(const Graph& graph, int start_index, int end_index) {
    const auto& points = graph.get_points(); // Usamos la función pública para obtener los puntos
    std::vector<double> distances(points.size(), std::numeric_limits<double>::infinity());
    std::vector<int> previous_vertices(points.size(), -1);
    std::priority_queue<std::pair<double, int>, std::vector<std::pair<double, int>>, std::greater<>> vertices_queue;

    distances[start_index] = 0;
    vertices_queue.emplace(0, start_index);

    while (!vertices_queue.empty()) {
        double current_distance = vertices_queue.top().first;
        int current_vertex = vertices_queue.top().second;
        vertices_queue.pop();

        if (current_distance > distances[current_vertex]) {
            continue;
        }

        for (const auto& neighbor : graph.get_neighbors(current_vertex)) {
            int next_vertex = neighbor.first;
            double edge_weight = neighbor.second;

            double distance_through_current = current_distance + edge_weight;
            if (distance_through_current < distances[next_vertex]) {
                distances[next_vertex] = distance_through_current;
                previous_vertices[next_vertex] = current_vertex;
                vertices_queue.emplace(distance_through_current, next_vertex);
            }
        }
    }

    std::vector<int> path_indices;
    for (int at = end_index; at != -1; at = previous_vertices[at]) {
        path_indices.push_back(at);
    }
    std::reverse(path_indices.begin(), path_indices.end());

    return path_indices;
}

### Resumen de Cambios:
- **graph.h**: Agregamos una función pública `get_points()` para acceder a los puntos.
- **graph.cpp**: Implementamos la función `get_points()`.
- **dijkstra_algorithm.cpp**: Incluimos `<algorithm>` y usamos `graph.get_points()` para obtener los puntos.

Estas correcciones deberían resolver los errores identificados en tu código C++.