#ifndef DIJKSTRA_ALGORITHM_H
#define DIJKSTRA_ALGORITHM_H

#include <vector>
#include "graph.h"

std::vector<int> find_shortest_path(const Graph& graph, int start_index, int end_index);

#endif // DIJKSTRA_ALGORITHM_H