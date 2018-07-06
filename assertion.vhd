library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity assertion is
  port(
    clk: in std_logic;
    d: in std_logic;
    rst_n: in std_logic;
    def: in std_logic;
    q: out std_logic
  );
end entity;

architecture behave of assertion is 
  signal ds: std_logic;
begin
  process(all)
  begin
    if rst_n = '0' then
      ds <= '0';
    elsif clk = '1' and clk'event then
      if def /= '1' then
        ds <= d;
      else
        ds <= 'Z';
      end if;
    end if;
  end process;
  
  q <= ds;
end architecture;