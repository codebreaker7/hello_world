library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
  port(
    clk: in std_logic;
    rst_n: in std_logic;
    d: in std_logic;
    q: out std_logic
  );
end entity; 

architecture behav of reg is
  signal ds: std_logic := '0';
-- psl default clock is rising_edge(clk);
-- psl property check_val is always {d} |=> {q};
begin
  process(all)
  begin
    if rst_n = '0' then
      ds <= '0';
    elsif rising_edge(clk) then
      ds <= d;
    end if;
  end process;
  
  q <= ds;
  -- psl assert check_val;
end architecture;
