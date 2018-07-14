library ieee;
context ieee.ieee_std_context;

entity con is
  port(
    clk: in std_logic;
    rst: in std_logic;
    data: in std_logic_vector(3 downto 0)
  );
end entity;

architecture behav of con is
  signal ds: unsigned(3 downto 0) := (others => '0');
begin
  process(all)
  begin
    if (rst = '0') then
      ds <= (others => '1');
    elsif clk = '1' and clk'event then
      ds <= unsigned(data);
    end if;
  end process;
end architecture;
