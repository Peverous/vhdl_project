library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
library std;
use std.textio.all;

package constants is
  constant input_length 	: integer :=8;
  constant mult_length 		: integer :=16;
  constant cnt_width 		: integer :=4;
  constant rom_width 		: integer :=256;
  constant ram_width 		: integer :=32;
  constant addr_range1 		: integer :=integer(ceil(log2(real(rom_width))));
  constant addr_range2		: integer :=integer(ceil(log2(real(ram_width))));
  constant ROM_NAME     : string := "rom.txt";
  
  type state is (s1,s2,calc,init,write_state);
  type rom_type is array (0 to rom_width-1) of bit_vector(input_length-1 downto 0);
  type ram_type is array (0 to ram_width-1) of std_logic_vector(mult_length-1 downto 0); 
    
   --======================FUNCTION PROTOTYPE=============================== 
  impure function rom_init(rom_filename : in string) return rom_type;
    
    
  --=========COMPONENT DECLARATION============
component adder is
  generic(n:integer:=8);
  port (a : in std_logic_vector(n-1 downto 0);
        b : in std_logic_vector(n-1 downto 0);
        c : out std_logic_vector(n-1 downto 0));
end component adder;

component mul is
  generic(n:integer:=8);
  port (a : in std_logic_vector(n-1 downto 0);
        b : in std_logic_vector(n-1 downto 0);
        c : out std_logic_vector(2*n-1 downto 0));
end component mul;

component loop_reg is
  generic(n:integer:=8);
port (din : in std_logic_vector(n-1 downto 0);
      clk : in std_logic;
      rst : in std_logic;
      dout : out std_logic_vector(n-1 downto 0));
end component loop_reg;

component counter is
    generic(n:integer:=3);
    port(clk : in std_logic;
         rst : in std_logic;
         dout : out std_logic_vector(n-1 downto 0));
end component counter;

component reg2 is
    generic(n:integer:=16);
port (din : in std_logic_vector(n-1 downto 0);
      clk : in std_logic;
      rst : in std_logic;
      load : in std_logic;
      dout : out std_logic_vector(n-1 downto 0));      
end component reg2;

component  add_generator is
  port (clk      : in std_logic;
        rst      : in std_logic;
        enable_rom   : in std_logic;
        enable_ram  : in std_logic;
        addr1    : out std_logic_vector(addr_range1-1 downto 0);
        addr2    : out std_logic_vector(addr_range1-1 downto 0);
		    addr3	 : out std_logic_vector(addr_range2-1 downto 0));
end component add_generator;

component single_ram is
	port(clk 		: in std_logic;
		 we			: in std_logic;
		 en			: in std_logic;
		 addr		: in std_logic_vector(addr_range2-1 downto 0);
		 din		: in std_logic_vector(mult_length-1 downto 0);
		 dout		: out std_logic_vector(mult_length-1 downto 0));
end component single_ram;

component dual_rom is
  port (clk       : in std_logic;
        en        : in std_logic;
        add1      : in std_logic_vector(addr_range1-1 downto 0);
        add2      : in std_logic_vector(addr_range1-1 downto 0);
        data_A    : out std_logic_vector(input_length-1 downto 0);
        data_B    : out std_logic_vector(input_length-1 downto 0));
end component dual_rom;

component FSM_final is
port  ( clk				: in std_logic;
		rst   		: in std_logic;
		cnt				: in std_logic_vector(cnt_width-1 downto 0);
		enRAM			: out std_logic;
		enROM			: out std_logic;
		wr				: out std_logic;
		rstr3			: out std_logic;
		en_addr_ram		: out std_logic;
		en_addr_rom		: out std_logic);
end component FSM_final;

end constants;



package body constants is
  
  --============FUNCTION DECLARATION====================================
impure function rom_init(rom_filename: in string) return rom_type is
  
    file rom_data         : text is in rom_filename;
    variable line_name    : line;
    variable rom_name     : rom_type;
    
    begin
      for I in rom_type'range loop
        readline (rom_data ,line_name);
        read (line_name,rom_name(I));
      end loop;
      return rom_name;
    end function rom_init;
    
end constants;
