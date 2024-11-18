// SADSystem.cpp
#include "SADSystem.h"

void SADSystem::execute() {
    PreencherBloco();
    calculate();
    logData();
}

int main() {
    SADSystem SAD;
    SAD.execute();
    return 0;
}