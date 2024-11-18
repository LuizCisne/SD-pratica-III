# GoldenModelSAD

## Requisitos
- g++ com suporte a C++11
- make (para compilar o projeto)

## Estrutura do Projeto
- `src/`: Contém os arquivos-fonte (.cpp)
- `include/`: Contém os arquivos de cabeçalho (.h)
- `bin/`: Onde o executável será gerado
- `obj/`: Onde os arquivos objeto (.o) serão armazenados

## Configuração e Compilação

1. **Opções de Caminho (Opcional)**:
   - Por padrão, o `Makefile` usa caminhos de inclusão e bibliotecas padrão do sistema.
   - Caso seja necessário adicionar caminhos específicos para inclusão ou bibliotecas, edite as variáveis `INCLUDE_PATH` e `LIB_PATH` no `Makefile`:
     ```makefile
     INCLUDE_PATH = -I/path/to/headers
     LIB_PATH = -L/path/to/libs
     ```

2. **Compilação**:
   - Para compilar o projeto, execute:
     ```bash
     make
     ```
   - O executável será gerado na pasta `bin/` com o nome `GoldenModelSAD.exe`.
   - O arquivo .dat será gerado na pasta 'bin/' com o nome 'GoldenModelSAD.dat'.

3. **Limpeza dos Arquivos Compilados**:
   - Para remover os arquivos compilados e o executável, execute:
     ```bash
     make clean
     ```

## Executando o Programa
- Após a compilação, o programa pode ser executado com:
  ```bash
  ./bin/GoldenModelSAD.exe
