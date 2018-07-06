library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity assertion_tb is
end entity;

architecture behave of assertion_tb is
  signal clock: std_logic := '0';
  signal ds, qs, defs, rsts: std_logic := '0';
begin
  clock <= not clock after 10 ns;
  
  inst: entity work.assertion port map (
    clk => clock,
    d => ds,
    rst_n => rsts,
    def => defs,
    q => qs
  );
  
  stimul_proc: process
  begin
    wait for 20 ns; -- reset all
    ds <= '1'; -- set value
    rsts <= '1';
    wait for 20 ns;
    assert qs /= '1' report "Wrong output value" severity note;
    defs <= '1';
    wait for 20 ns;
    assert qs /= 'Z' report "No z-value on output" severity note;
    wait for 20 ns;
    wait;
  end process;
end architecture;
