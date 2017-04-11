library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity single_ram is
	port(clk 		: in std_logic;
		 we			: in std_logic;
		 en			: in std_logic;
		 addr		: in std_logic_vector(addr_range2-1 downto 0);
		 din		: in std_logic_vector(mult_length-1 downto 0);
		 dout		: out std_logic_vector(mult_length-1 downto 0));
end single_ram;

architecture syn of single_ram is
signal RAM : ram_type;
	
begin
ram_proc :	process (clk)
				begin
					if (clk'event and clk='1') then
						if (en='1') then
							if(we='1') then
								RAM(conv_integer(addr)) <= din;
							end if;
							dout <= RAM(conv_integer(addr));
						end if;
					end if;
			end process;

end syn;
