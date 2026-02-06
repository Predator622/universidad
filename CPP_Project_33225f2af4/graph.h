#ifndef GRAPH_H
#define GRAPH_H

#include <vector>
#include <utility>

class Graph {
public:
    Graph(const std::vector<std::vector<double>>& points, const std::vector<std::pair<int, int>>& edges);
    std::vector<std::pair<int, double>> get_neighbors(int vertex) const;
    // Agregamos una función pública para obtener los puntos
    const std::vector<std::vector<double>>& get_points() const;

private:
    std::vector<std::vector<double>> points;
    std::vector<std::vector<std::pair<int, double>>> adjacency_list;
};

#endif // GRAPH_H

#### 