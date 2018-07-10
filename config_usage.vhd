library ieee;
use ieee.std_logic_1164.all;

entity or_unit is
  port(
    a: in std_logic;
    b: in std_logic;
    res: out std_logic
  );
end entity;

architecture struct of or_unit is
  component or_component is
  port(
    a: in std_logic;
    b: in std_logic;
    res: out std_logic
  );
  end component;
begin
  or_inst: or_component port map (
    a => a,
    b => b,
    res => res
  );
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity or_comp_entity is
  port(
    a: in std_logic;
    b: in std_logic;
    res: out std_logic
  );
end entity;

architecture or_arch of or_comp_entity is
begin
  res <= a or b;
end architecture;

use work.all;

configuration or_config of or_unit is
  for struct
    for or_inst: or_component
      use entity or_comp_entity(or_arch);
    end for;
  end for;
end configuration;