library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;
use std.textio.all;
use ieee.std_logic_textio.all;

entity text_test is
end entity ; -- text_test

architecture arch of text_test is
	file input_data: text;
	file output_data: text;
	constant period: time := 100 ns;
	signal clk: std_logic := '0';
	signal input_signal : std_logic_vector(3 downto 0) := (others => '0');
begin

	clk <= not clk after period / 2;

	read_file: process
		variable in_line: line;
		variable input_variable: std_logic_vector(3 downto 0);
	begin
		file_open(input_data, "input.txt", READ_MODE);
 		while not endfile(input_data) loop
			readline(input_data, in_line);
			read(in_line, input_variable);
			input_signal <= input_variable;
			wait until rising_edge(clk);
		end loop; 
		file_close(input_data);
	end process;

	write_file: process
		variable out_line: line;
	begin
		file_open(output_data, "output.txt", WRITE_MODE);
		wait until rising_edge(clk);
		for i in 1 to 15 loop
			write(out_line, input_signal, RIGHT, 12);
			writeline(output_data, out_line);
			wait until rising_edge(clk);
		end loop;
		file_close(output_data);
		wait;
	end process;
end architecture ; -- arch
