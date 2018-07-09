library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generate_tb is
end entity;

architecture test of generate_tb is
  signal clock: std_logic := '0';
  signal rst: std_logic := '0';
  signal in_data: std_logic_vector(7 downto 0) := (others => '0');
  signal out_data: std_logic_vector(7 downto 0) := (others => '0');
begin
  clock <= not clock after 50 ns;
  
  registers: entity work.generate_example port map (
    clk => clock,
    rst_n => rst,
    ind => in_data,
    outd => out_data
  );
  
  stim_proc: process
  begin
    wait for 50 ns;
    rst <= '1';
    in_data <= "11110000";
    wait for 50 ns * 2;
    in_data <= "10010110";
    wait for 50 ns * 2;
    in_data <= "00001111";
    wait for 50 ns * 2;
    wait;
  end process;
end architecture;
