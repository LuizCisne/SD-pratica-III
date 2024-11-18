// GeradorSinaisIN.cpp
#include "GeradorSinaisIN.h"

GeradorSinaisIN::GeradorSinaisIN() 
    : blocosA(50), blocosB(50) // Inicializa com 50 arrays
{ }

void GeradorSinaisIN::PreencherBloco() {
    
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> distrib(0, 255);

    for (int i = 0; i < 50; ++i) {
        for (int j = 0; j < 8; ++j) {
            blocosA.at(i).at(j) = distrib(gen);
            blocosB.at(i).at(j) = distrib(gen);
        }
    }
}
    /*    // C�digo tempor�rio para depura��o
    std::cout << "Bloco A:" << std::endl;
    for (int i = 0; i < NumAmostras; ++i) {
        std::cout << blocoA[i] << " ";
    }
    std::cout << "\nBloco B:" << std::endl;
    for (int i = 0; i < NumAmostras; ++i) {
        std::cout << blocoB[i] << " ";
    }
    std::cout << std::endl; */

const std::vector<std::array<int, 8>>& GeradorSinaisIN::getBlocosA() const {
    return blocosA;
}

const std::vector<std::array<int, 8>>& GeradorSinaisIN::getBlocosB() const {
    return blocosB;
}
