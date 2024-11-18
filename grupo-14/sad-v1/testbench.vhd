LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY testbench IS
    -- Testbench não possui portas de entrada ou saída
END ENTITY;

ARCHITECTURE tb OF testbench IS

    -- Sinais para as entradas e saídas do SAD
    SIGNAL clk : std_logic := '0';
    SIGNAL reset : std_logic := '0';
    SIGNAL enable : std_logic := '0';
    SIGNAL sample_ori : std_logic_vector(7 DOWNTO 0);
    SIGNAL sample_can : std_logic_vector(7 DOWNTO 0);
    SIGNAL sad_value : std_logic_vector(13 DOWNTO 0);  -- Ajuste conforme a saída esperada
    SIGNAL done: std_logic;
    SIGNAL address : std_logic_vector(5 DOWNTO 0);  -- Ajuste conforme o tamanho necessário para o endereço

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

    -- Processo para gerar o clock
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        LOOP
            WAIT FOR 10 ns;
            clk <= NOT clk;
        END LOOP;
    END PROCESS;

    -- Processo de geração de estímulos
    stimulus_process : PROCESS
    BEGIN
        -- Inicialização e reset
        reset <= '1';
        enable <= '0';
        WAIT FOR 20 ns;
        reset <= '0';
        enable <= '1';

        -- Teste com valores baixos
        sample_ori <= (OTHERS => '0');
        sample_can <= (OTHERS => '0');
        WAIT UNTIL done'event and done = '1';

        -- Teste com valores máximos
        sample_ori <= (OTHERS => '1');
        sample_can <= (OTHERS => '1');
        WAIT UNTIL done'event and done = '1';

        -- Teste com valores intermediários
        sample_ori <= "01111111";
        sample_can <= "00111111";
        WAIT UNTIL done'event and done = '1';

        -- Teste de overflow
        sample_ori <= "11111110";
        sample_can <= "11111110";
        WAIT UNTIL done'event and done = '1';

        -- Finaliza o teste
        ASSERT FALSE REPORT "Teste concluído." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END ARCHITECTURE;
