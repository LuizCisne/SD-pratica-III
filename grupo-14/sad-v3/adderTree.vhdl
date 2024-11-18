LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY adderTree IS
    GENERIC (
        N : POSITIVE := 8;  -- Número de bits de cada entrada
        P : POSITIVE := 4   -- Número de entradas a serem somadas
    );
    PORT (
        inputs : IN std_logic_vector((P*N)-1 DOWNTO 0);  -- Vetor de entradas concatenadas
        sum_out : OUT std_logic_vector(N+integer(ceil(log2(real(P))))-1 DOWNTO 0)  -- Saída
    );
END ENTITY adderTree;

ARCHITECTURE rtl OF adderTree IS
    SIGNAL sum_total : unsigned(N+integer(ceil(log2(real(P))))-1 DOWNTO 0);  -- Acumulador para a soma total
    SIGNAL total_left, total_right : std_logic_vector(N+integer(ceil(log2(real(P))))-2 DOWNTO 0);
BEGIN
    sum_out <= std_logic_vector(sum_total);

    -- Gerar a estrutura de soma baseada no valor de P
    gen_sum_two: IF P = 2 GENERATE
        FA1 : ENTITY work.adder_full_unsigned
        GENERIC MAP (N => N)
        PORT MAP (
            add1 => unsigned(inputs(N-1 DOWNTO 0)),
            add2 => unsigned(inputs((2*N)-1 DOWNTO N)),
            sum => sum_total
        );
    END GENERATE gen_sum_two;

    gen_sum_recursive: IF P > 2 GENERATE
        -- Dividir as entradas em duas partes e chamar `adderTree` recursivamente
        sum_left_inst: ENTITY work.adderTree
        GENERIC MAP (N => N, P => P/2)
        PORT MAP (
            inputs => inputs(inputs'left DOWNTO INTEGER(inputs'length/2)),
            sum_out => total_left
        );

        sum_right_inst: ENTITY work.adderTree
        GENERIC MAP (N => N, P => P/2)
        PORT MAP (
            inputs => inputs(INTEGER(inputs'length/2)-1 DOWNTO 0),
            sum_out => total_right
        );

        -- Somar os resultados de `sum_left` e `sum_right`
        FA2 : ENTITY work.adder_full_unsigned
        GENERIC MAP (N => N+integer(ceil(log2(real(P))))-1)
        PORT MAP (
            add1 => unsigned(total_left),
            add2 => unsigned(total_right),
            sum => sum_total
        );
    END GENERATE gen_sum_recursive;

END ARCHITECTURE rtl;
