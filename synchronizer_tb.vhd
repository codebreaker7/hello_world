library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity synchronizer_tb is
end entity;

architecture tb of synchronizer_tb is
  signal periodA: time := 10 ns;
  signal periodB: time := 25 ns;
  
  signal clockA, clockB: std_logic := '0';
  signal valA: std_logic := '0';
  signal valB: std_logic;
begin
  clockA <= not clockA after periodA;
  clockB <= not clockB after periodB;
  
  synch_inst: entity work.synchronizer port map (
    clkA => clockA,
    sA => valA,
    clkB => clockB,
    sB => valB
  );
  
  stimul_proc: process
  begin
    wait for 100 ns;
    valA <= '1';
    wait for 100 ns;
    valA <= '0';
    wait for 200 ns;
    wait;
  end process;
end architecture;
