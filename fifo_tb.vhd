library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_tb is
end entity;

architecture behav of fifo_tb is
  signal clock: std_logic := '0';
  signal reset: std_logic := '0';
  signal enwrite, enread: std_logic := '0';
  signal dinput: std_logic_vector(3 downto 0) := "1001";
  signal sfull, sempty: std_logic;
  signal sout: std_logic_vector(3 downto 0);
begin
  fifo_inst: entity work.fifo
  port map(
    clk => clock,
    rst_n => reset,
    enw => enwrite,
    enr => enread,
    din => dinput,
    dout => sout,
    empty => sempty,
    full => sfull  
  );    
  
  clock <= not clock after 5 ns;
  
  stim_proc: process
  begin
    wait until clock = '1';
    reset <= '1';
    wait until clock = '1';
    enwrite <= '1';
    for i in 0 to 3 loop
      wait until clock = '1';
    end loop;
    enwrite <= '0';
    enread <= '1';
    for i in 0 to 3 loop
      wait until clock = '1';
    end loop;
    enread <= '0';
    wait;
  end process;
end architecture;