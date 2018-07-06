library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity synchronizer is
  port(
    clkA: in std_logic;
    sA: in std_logic;
    clkB: in std_logic;
    sB: out std_logic
  );
end entity;

architecture behav of synchronizer is
  signal buf1, buf2: std_logic := '0';
begin
  process(all)
  begin
    if (clkB = '1' and clkB'event) then
      buf1 <= sA;
      buf2 <= buf1;
    end if;
  end process;
  
  sB <= buf2;
end architecture;
