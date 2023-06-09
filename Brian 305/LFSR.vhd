library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity LFSR is
    port (
        Clk, Reset : in std_logic;
        outLFSR : out integer
    );
end entity;

architecture rtl of LFSR is
    signal currentState : std_logic_vector(7 DOWNTO 0);
    
begin
    process (clk,reset)
    variable feedback : std_logic;
    begin
        if reset = '1' then
            currentState <= (0 => '1', others => '0');
        elsif (rising_edge(clk)) then
            feedback := currentState(7);
            currentState(0) <= feedback;
            currentState(1) <= currentState(0);
            currentState(2) <= feedback xor currentState(1);
            currentState(3) <= feedback xor currentState(2);
            currentState(4) <= feedback xor currentState(3);
            currentState(5) <= currentState(4);
            currentState(6) <= currentState(5);
            currentState(7) <= currentState(6);

        end if;
        
    end process;
outLFSR <= to_integer(unsigned(currentState));
    
end architecture rtl;