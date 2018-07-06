library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag_synch is
  port(
    clkA: in std_logic;
    sA: in std_logic;
    clkB: in std_logic;
    sB: out std_logic
  );
end entity;

architecture behav of flag_synch is
  signal toggleA: std_logic := '0';
  signal buf: std_logic_vector(2 downto 0) := (others => '0');
begin
  process(all)
  begin
    if (clkA = '1' and clkA'event) then
      toggleA <= toggleA xor sA;
    end if;
  end process;
  
  process(all)
  begin
    if (clkB = '1' and clkB'event) then
        buf <= buf(1 downto 0) & toggleA;
    end if;
  end process;
  
  sB <= buf(2) xor buf(1);
end architecture;
