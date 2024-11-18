// DataLogger.cpp
#include "DataLogger.h"

DataLogger::DataLogger() : filename("dados.dat") {}

DataLogger::DataLogger(const std::string& fname) : filename(fname) {}

std::string DataLogger::intToBinaryString(int num, int bits) {
    return std::bitset<32>(num).to_string().substr(32 - bits);
}

void DataLogger::logData() {
    std::ofstream file(filename);

    if (filename.empty()) {
        std::cerr << "Erro: nome do arquivo nao foi especificado!" << std::endl;
        return;
    }

    if (!file.is_open()) {
        std::cerr << "Erro ao abrir o arquivo para gravacao!" << std::endl;
        return;
    }

    for (int i = 0; i < 50; ++i) {
        file << "Bloco A " << i + 1 << "\n";
        for (int val : blocosA[i]) {
            file << intToBinaryString(val, 8) << "\n";
        }

        file << "Bloco B " << i + 1 << "\n";
        for (int val : blocosB[i]) {
            file << intToBinaryString(val, 8) << "\n";
        }

        file << "Resultado " << i + 1 << "\n";
        file << intToBinaryString(resultados[i], 8) << "\n";
    }

    file.close();
    /* // quando havia apenas 1 bloco A e B
    file << "\n";
    for (int val : getBlocoA()) {
        file << intToBinaryString(val, 8) << "\n";
    }

    file << "\n";
    for (int val : getBlocoB()) {
        file << intToBinaryString(val, 8) << "\n";
    }

    file << "\n";
    file << intToBinaryString(getResultado(), 8) << "\n";

    file.close();*/
}

