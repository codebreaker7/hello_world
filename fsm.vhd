library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
  port(
    clk: in std_logic;
    rst: in std_logic;
    start: in std_logic;
    data: in std_logic_vector(4 downto 0);
    result: out std_logic_vector(5 downto 0)
  );
end entity;

architecture behav of fsm is
  type fsm_type is (idle, add_state, subtract_state);
  signal cur_state, next_state: fsm_type := idle;
  signal ds: signed(4 downto 0);
  signal rs, temp: signed(5 downto 0);
begin
  ds <= signed(data);
  
  calc_proc: process(all)
  begin
    if rst = '0' then
      rs <= (others => '0');
    elsif clk = '1' and clk'event then
      cur_state <= next_state;
      case cur_state is
        when idle =>
          null;
        when add_state =>
          temp <= resize(ds, 6) + 3; 
        when subtract_state =>
          rs <= temp - 1;
      end case;
    end if;
  end process;
  
  state_proc: process(all)
  begin
    if rst = '0' then
      next_state <= idle;
    elsif clk = '1' and clk'event then
      case cur_state is
        when idle =>
          if start = '1' then
            next_state <= add_state;
          else
            next_state <= idle;
          end if;
        when add_state =>
          next_state <= subtract_state;
        when subtract_state =>
          next_state <= idle;
      end case;
    end if;
  end process;
  
  result <= std_logic_vector(rs);
end architecture;
