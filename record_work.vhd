library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

use work.pack_record.all;

entity record_work is
end entity ; -- record_work

architecture arch of record_work is
	signal r: rec := (empty => '1', full => '0');
	signal test: std_logic_vector(3 downto 0) := "1100";
	signal result: std_logic_vector(3 downto 0);
begin

	process
	begin
		wait for 10 ns;
		r.empty <= not r.empty;
		r.full <= not r.full;
	end process;

	process
	begin
		result <= rotate3(test);
		wait;
	end process;

end architecture ; -- arch
