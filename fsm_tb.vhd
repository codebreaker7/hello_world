library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_tb is
end entity;

architecture tb of fsm_tb is
  signal clock: std_logic := '0';
  signal reset: std_logic := '0';
  signal start: std_logic := '0';
  signal data: std_logic_vector(4 downto 0);
  signal res: std_logic_vector(5 downto 0);
begin
  clock <= not clock after 50 ns;
  
  fsm_inst: entity work.fsm port map (
    clk => clock,
    rst => reset,
    start => start,
    data => data,
    result => res
  );
  
  stim_proc: process
  begin
    data <= "10011";
    wait for 100 ns;
    reset <= '1';
    start <= '1';
    wait for 100 ns;
    start <= '0';
    wait for 300 ns;
    wait;
  end process;
end architecture;
