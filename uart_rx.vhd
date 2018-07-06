library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
  port(
    in_clk: in std_logic;
    rx: in std_logic;
    rx_data: out std_logic_vector(7 downto 0)
  );
end entity;

architecture behav of uart_rx is 
  type UART_state is (idle, start_bit, data_bits, stop_bit, clean);
  signal cur_state: UART_state := idle;
  signal data_index: unsigned(3 downto 0) := "0000";
  signal rec_data: std_logic_vector(7 downto 0) := (others => '0');
  signal clk_count: unsigned(6 downto 0) := (others => '0');
  signal data_reg, buf_data_reg: std_logic := '0';
begin
  process(all)
  begin
    if in_clk = '1' and in_clk'event then
      buf_data_reg <= rx;
      data_reg <= buf_data_reg;
    end if;
  end process;
  
  process(all)
  begin
    if in_clk = '1' and in_clk'event then
      case cur_state is
        when idle => 
          data_index <= (others => '0');
          clk_count <= (others => '0');
          if data_reg = '0' then
            cur_state <= start_bit;
          else
            cur_state <= idle;
          end if;
        when start_bit => 
          if to_integer(clk_count) = 43 then
            if data_reg = '0' then
              clk_count <= (others => '0');
              cur_state <= data_bits;
            else
              cur_state <= idle;
            end if;
          else
            clk_count <= clk_count + 1;
            cur_state <= start_bit;
          end if;
        when data_bits => 
          if to_integer(clk_count) < 86 then -- 86
            clk_count <= clk_count + 1;
            cur_state <= data_bits;
          else
            clk_count <= (others => '0');
            rec_data(to_integer(data_index)) <= data_reg;
            if to_integer(data_index) < 7 then
              data_index <= data_index + 1;
              cur_state <= data_bits;
            else
              data_index <= (others => '0');
              cur_state <= stop_bit;
            end if;
          end if;
        when stop_bit => 
          if to_integer(clk_count) < 86 then
            clk_count <= clk_count + 1;
            cur_state <= stop_bit;
          else
            clk_count <= (others => '0');
            cur_state <= clean;
          end if;
        when clean => 
          cur_state <= idle;
        when others =>
          cur_state <= idle;
      end case;
    end if;
  end process;
  
  rx_data <= rec_data;
end architecture;
