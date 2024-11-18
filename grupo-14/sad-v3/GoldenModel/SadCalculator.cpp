// SadCalculator.cpp
#include "SadCalculator.h"

SadCalculator::SadCalculator() : resultados(50, 0) { } // Inicializa o vetor com 50 zeros

void SadCalculator::calculate() {
for (int i = 0; i < 50; ++i) { // Itera sobre os 50 blocos
        int sad = 0;
        for (int j = 0; j < 8; ++j) {
            sad += std::abs(blocosA.at(i).at(j) - blocosB.at(i).at(j)); // Calcula SAD para cada elemento do bloco
        }
        resultados[i] = sad; // Armazena o resultado do SAD para o bloco atual
    }
}

const std::vector<int>& SadCalculator::getResultados() const {
    return resultados;
}