#include "graph.h"
#include <cmath>

Graph::Graph(const std::vector<std::vector<double>>& points, const std::vector<std::pair<int, int>>& edges)
    : points(points), adjacency_list(points.size()) {
    
    for (const auto& edge : edges) {
        int start = edge.first;
        int end = edge.second;
        double cost = calculate_distance(points[start], points[end]);
        
        adjacency_list[start].emplace_back(end, cost);
        adjacency_list[end].emplace_back(start, cost);
    }
}

std::vector<std::pair<int, double>> Graph::get_neighbors(int vertex) const {
    return adjacency_list[vertex];
}

const std::vector<std::vector<double>>& Graph::get_points() const {
    return points;
}

double calculate_distance(const std::vector<double>& point1, const std::vector<double>& point2) {
    double distance = 0.0;
    for (size_t i = 0; i < point1.size(); ++i) {
        distance += (point1[i] - point2[i]) * (point1[i] - point2[i]);
    }
    return std::sqrt(distance);
}

#### 