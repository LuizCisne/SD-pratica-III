// SadCalculator.h
#ifndef SADCALCULATOR_H
#define SADCALCULATOR_H

#include "GeradorSinaisIN.h"
#include <cmath>
#include <array>

class SadCalculator : public GeradorSinaisIN {
protected:
    std::vector<int> resultados; // Vetor para armazenar 50 resultados de SAD

public:
    SadCalculator();
    void calculate();
    const std::vector<int>& getResultados() const; // Getter para acessar os resultados
};

#endif // SADCALCULATOR_H

