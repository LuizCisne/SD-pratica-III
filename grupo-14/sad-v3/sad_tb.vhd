LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;

ENTITY sad_tb IS
    -- Testbench não possui portas de entrada ou saída
END ENTITY;

ARCHITECTURE tb OF sad_tb IS
    -- Sinais para as entradas e saídas do SAD
    SIGNAL clk : std_logic := '0';
    SIGNAL reset : std_logic := '0';
    SIGNAL enable : std_logic := '0';
    SIGNAL sample_ori : std_logic_vector(7 DOWNTO 0);
    SIGNAL sample_can : std_logic_vector(7 DOWNTO 0);
    SIGNAL sad_value : std_logic_vector(13 DOWNTO 0);
    SIGNAL done: std_logic;
    SIGNAL address : std_logic_vector(5 DOWNTO 0);

BEGIN
    -- Instância da entidade `sad`
    uut: ENTITY work.sad
        PORT MAP (
            clk => clk,
            reset => reset,
            enable => enable,
            sample_ori => sample_ori,
            sample_can => sample_can,
            address => address,
            done => done,
            sad_value => sad_value
        );

    -- Processo para gerar o clock com uma única instrução WAIT
    clk_process : PROCESS
    BEGIN
        LOOP
            clk <= '0';
            WAIT FOR 10 ns;
            clk <= '1';
            WAIT FOR 10 ns;
        END LOOP;
    END PROCESS;

    -- Processo para aplicar estímulos a partir do arquivo
    stimulus_process : PROCESS
        FILE dados_file : TEXT OPEN READ_MODE IS "dados.dat";  -- Caminho relativo
        VARIABLE linha : LINE;
        VARIABLE valor_ori, valor_can : BIT_VECTOR(7 DOWNTO 0);
        VARIABLE valor_esperado : BIT_VECTOR(13 DOWNTO 0);
        VARIABLE espaco : CHARACTER;
    BEGIN
        -- Inicializa reset e enable
        reset <= '1';
        enable <= '0';
        WAIT FOR 20 ns;
        reset <= '0';
        enable <= '1';

        -- Leitura do arquivo de estímulos
        WHILE NOT ENDFILE(dados_file) LOOP
            READLINE(dados_file, linha);
            BEGIN
                READ(linha, valor_ori);
                sample_ori <= TO_STDLOGICVECTOR(valor_ori);

                READ(linha, espaco);
                READ(linha, valor_can);
                sample_can <= TO_STDLOGICVECTOR(valor_can);

                READ(linha, espaco);
                READ(linha, valor_esperado);

                -- Espera até o sinal `done` ser ativado
                WAIT UNTIL done = '1';

                -- Verifica a saída
                ASSERT sad_value = TO_STDLOGICVECTOR(valor_esperado)
                    REPORT "Erro: valor SAD incorreto."
                    SEVERITY ERROR;
            EXCEPTION
                WHEN OTHERS =>
                    -- Ignora a linha se não estiver no formato correto
                    NULL;
            END;
        END LOOP;

        -- Finaliza a simulação
        ASSERT FALSE REPORT "Simulação concluída." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END ARCHITECTURE;
