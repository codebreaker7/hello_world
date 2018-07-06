library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
  generic (
    dwidth: integer := 4;
    ddepth: integer := 5
  );
  port(
    clk: in std_logic;
    rst_n: in std_logic;
    din: in std_logic_vector(dwidth-1 downto 0);
    dout: out std_logic_vector(dwidth-1 downto 0);
    enr: in std_logic;
    enw: in std_logic;
    empty: out std_logic;
    full: out std_logic
  );
end entity;

architecture behave of fifo is
  type memory is array (0 to 2**ddepth-1) of std_logic_vector(dwidth-1 downto 0);
  signal mem: memory := (others => (others => '0'));
  signal rptr, wptr: integer := 0;
  signal emp, fl: std_logic := '0';
  signal numptr : integer := 0;
begin
  
  emp <= '1' when numptr = 0 else '0';
  fl <= '1' when numptr = 2**ddepth else '0';
  
  empty <= emp;
  full <= fl;
  
  dout <= mem(rptr);
  
  fifo_proc: process(all)
  begin
    if rst_n = '0' then
      rptr <= 0;
      wptr <= 0;
      numptr <= 0;
    elsif clk = '1' and clk'event then
      if (enw = '1' and enr = '0') then
        numptr <= numptr + 1;
      elsif (enw = '0' and enr = '1') then
        numptr <= numptr - 1;
      end if;
      if (enw = '1' and fl = '0') then 
        if (wptr = 2**ddepth-1) then
          wptr <= 0;
        else
          wptr <= wptr + 1;
        end if;
      end if;
      if (enr = '1' and emp = '0') then
        if (rptr = 2**ddepth-1) then
          rptr <= 0;
        else
          rptr <= rptr + 1;
        end if;
      end if;
      if (enw = '1') then
        mem(wptr) <= din;
      end if;
    end if;
  end process;
  
end architecture;
