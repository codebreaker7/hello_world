library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag_synch_tb is
end entity;

architecture tb of flag_synch_tb is
  signal periodA: time := 10 ns;
  signal periodB: time := 25 ns;
  
  signal clockA, clockB: std_logic := '0';
  signal valA: std_logic := '0';
  signal valB: std_logic;
begin
  clockA <= not clockA after periodA;
  clockB <= not clockB after periodB;
  
  synch_inst: entity work.flag_synch port map (
    clkA => clockA,
    sA => valA,
    clkB => clockB,
    sB => valB
  );
  
  stimul_proc: process
  begin
    wait for periodA * 2;
    valA <= '1';
    wait for periodA * 2;
    valA <= '0';
    wait for periodA * 10;
    valA <= '1';
    wait for periodA * 2;
    valA <= '0';
    wait for periodA * 10;
    wait;
  end process;
end architecture;
