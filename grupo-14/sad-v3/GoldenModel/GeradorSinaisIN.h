// GeradorSinaisIN.h
#ifndef GERADORSINAISIN_H
#define GERADORSINAISIN_H

#include <vector>
#include <random>
#include <array>
#include <iostream>

static const int NumAmostras = 64;

class GeradorSinaisIN { 
protected:

    // Cada bloco sera um array de inteiros, e teremos 50 blocos A e B
    std::vector<std::array<int, 8>> blocosA;
    std::vector<std::array<int, 8>> blocosB;

public:
    GeradorSinaisIN();
    void PreencherBloco();
    // Getters para acessar os blocos
    const std::vector<std::array<int, 8>>& getBlocosA() const;
    const std::vector<std::array<int, 8>>& getBlocosB() const;
};

#endif // GERADORSINAISIN_H

