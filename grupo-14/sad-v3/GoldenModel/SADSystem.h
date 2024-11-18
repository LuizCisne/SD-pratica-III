#ifndef SADSYSTEM_H
#define SADSYSTEM_H

#include "DataLogger.h"
#include "GeradorSinaisIN.h"
#include "SadCalculator.h"

class SADSystem : public DataLogger{
public:
    void execute();
};

#endif // SADSYSTEM_H