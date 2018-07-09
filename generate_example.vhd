library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generate_example is
  port(
    clk: in std_logic;
    rst_n: in std_logic;
    ind: in std_logic_vector(7 downto 0);
    outd: out std_logic_vector(7 downto 0)
  );
end entity;

architecture behav_gen of generate_example is
begin
  registers: for i in 0 to 7 generate
    regx_inst: entity work.reg port map (
      clk => clk,
      rst_n => rst_n,
      d => ind(i),
      q => outd(7-i)
    );
  end generate;
end architecture;
