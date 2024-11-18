// DataLogger.h
#ifndef DATALOGGER_H
#define DATALOGGER_H

#include <fstream>
#include <string>
#include <bitset>
#include <iostream>
#include "SadCalculator.h"

class DataLogger : public SadCalculator {
protected:
    std::string filename;

public:
    DataLogger();
    explicit DataLogger(const std::string& fname);
    void logData();
    std::string intToBinaryString(int num, int bits = 8);
};

#endif // DATALOGGER_H

