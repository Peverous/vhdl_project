library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity add_generator is
  port (clk     : in std_logic;
        rst     : in std_logic;
        enable_rom : in std_logic;
        enable_ram  : in std_logic;
        addr1    : out std_logic_vector(addr_range1-1 downto 0);
        addr2    : out std_logic_vector(addr_range1-1 downto 0);
		    addr3	: out std_logic_vector(addr_range2-1 downto 0));
  end add_generator;
  
architecture behavior of add_generator is

signal cnt      : std_logic_vector(addr_range1-2 downto 0);
signal temp     : std_logic_vector(addr_range2-1 downto 0);
begin
  
U_rom_addr:  process (clk)
    begin
      if (clk'event and clk='1') then
        if (rst='1') then
          cnt<=(others=>'0');
        elsif (enable_rom='1') then
          cnt<=cnt+1;
        else
          cnt<=cnt;
        end if;
      end if;
  end process U_rom_addr;
  
addr1<='0'&cnt;
addr2<='1'&cnt;


U_ram_addr : process (clk)

    begin
      if (clk'event and clk='1') then
        if (rst='1') then
          temp<=(others =>'0');
        elsif (enable_ram='1') then
          temp<=temp + 1;
        else
          temp<=temp;
        end if;
      end if;
  end process U_ram_addr;
  
  
addr3<=temp;
end behavior;

  
