#include <iostream>
#include <fstream>
#include <vector>
#include "graph.h"
#include "dijkstra_algorithm.h"

std::pair<std::vector<std::vector<double>>, std::vector<std::pair<int, int>>> read_mesh(const std::string& file_name) {
    std::ifstream file(file_name);
    int N, E;
    file >> N;

    std::vector<std::vector<double>> points(N, std::vector<double>(3));
    for (int i = 0; i < N; ++i) {
        file >> points[i][0] >> points[i][1] >> points[i][2];
    }

    file >> E;
    std::vector<std::pair<int, int>> edges(E);
    for (int i = 0; i < E; ++i) {
        file >> edges[i].first >> edges[i].second;
    }

    return {points, edges};
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        std::cerr << "Usage: ./program <file_name> <start_index> <end_index>" << std::endl;
        return 1;
    }

    const std::string file_name = argv[1];
    int start_index = std::stoi(argv[2]);
    int end_index = std::stoi(argv[3]);

    auto [points, edges] = read_mesh(file_name);
    Graph graph(points, edges);

    auto path_indices = find_shortest_path(graph, start_index, end_index);

    for (int index : path_indices) {
        std::cout << "Point " << index << ": (" 
                  << points[index][0] << ", " 
                  << points[index][1] << ", " 
                  << points[index][2] << ")" << std::endl;
    }

    return 0;
}