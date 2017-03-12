library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity dual_rom is
  port (clk       : in std_logic;
        en        : in std_logic;
        add1      : in std_logic_vector(addr_range1-1 downto 0);
        add2      : in std_logic_vector(addr_range1-1 downto 0);
        data_A    : out std_logic_vector(input_length-1 downto 0);
        data_B    : out std_logic_vector(input_length-1 downto 0));
end dual_rom;

architecture behave_rom of dual_rom is
  signal ROM      : rom_type  :=  rom_init(ROM_NAME);
  signal temp1    : std_logic_vector(input_length-1 downto 0);
  signal temp2    : std_logic_vector(input_length-1 downto 0);
  
  
  
  begin 
  temp1 <=to_stdlogicvector(ROM(conv_integer(add1)));
  temp2 <=to_stdlogicvector(ROM(conv_integer(add2)));
  
  rom_proc : process (clk)
                begin
                  if (clk'event and clk='1') then
                    if (en='1') then
                     data_A<=temp1;
                     data_B<=temp2;
                   end if;
                 end if;
             end process;
               
 end behave_rom;                    
