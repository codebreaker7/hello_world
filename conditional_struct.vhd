library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conditional_struct is
  generic (sel: boolean := true);
  port(
    clk: in std_logic;
    rst_n: in std_logic;
    din: in std_logic;
    dout: out std_logic
  );
end entity;

architecture struct of conditional_struct is
  signal ds: std_logic := '0';
begin
  gen_reg: if sel generate
    rx: entity work.reg port map (
      clk => clk,
      rst_n => rst_n,
      d => din,
      q => dout
    );
  end generate;
  
  gen_proc: if not sel generate
    inv_proc: process(all)
    begin
      if rst_n = '0' then
        ds <= '0';
      elsif clk = '1' and clk'event then
        ds <= not din;
      end if;
    end process;
    
    dout <= ds;
  end generate;
end architecture;
