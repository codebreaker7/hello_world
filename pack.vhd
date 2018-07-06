library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

package pack_record is
	type rec is record
		empty: std_logic;
		full: std_logic;
	end record;

	function rotate3(foo: std_logic_vector(3 downto 0)) return std_logic_vector;
end package ; -- pack_record 

package body pack_record is
	function rotate3(foo: std_logic_vector(3 downto 0)) return std_logic_vector is
		variable res: std_logic_vector(3 downto 0);
	begin
		for i in 0 to 3 loop
			res(i) := foo(3-i);
		end loop;
		return res;
	end function;
end package body;
