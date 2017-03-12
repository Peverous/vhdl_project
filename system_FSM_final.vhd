library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity system2 is
  port (clk       : in std_logic;
        rst     : in std_logic;
        dout      : out std_logic_vector(mult_length-1 downto 0));
end system2;

architecture struct of system2 is

signal enROM            : std_logic;
signal enRAM            : std_logic;
signal rstr3            : std_logic;
signal wr               : std_logic;
signal en_addr_ram      : std_logic;
signal en_addr_rom      : std_logic;
signal rom1             : std_logic_vector(input_length-1 downto 0);
signal rom2             : std_logic_vector(input_length-1 downto 0);
signal ginomeno         : std_logic_vector(mult_length-1 downto 0);
signal sum              : std_logic_vector(mult_length-1 downto 0);
signal old              : std_logic_vector(mult_length-1 downto 0);
signal address0         : std_logic_vector(addr_range1-1 downto 0);
signal address1         : std_logic_vector(addr_range1-1 downto 0);
signal addr_RAM         : std_logic_vector(addr_range2-1 downto 0);
signal cnt_out          : std_logic_vector(cnt_width-1 downto 0);

begin
  
  U_DUAL_ROM      : dual_rom
                            port map(clk=>clk,
                                     en=>enROM,
                                     add1=>address0,
                                     add2=>address1,
                                     data_A=>rom1,
                                     data_B=>rom2);
                                  
  U_OUT_RAM        : single_ram
                            port map (clk=>clk,
                                      we=>wr,
                                      en=>enRAM,
                                      addr=>addr_RAM,
                                      din=>sum,
                                      dout=>dout);
                                      
  U_MULTI           : mul generic map (n=>input_length)
                            port map (a=>rom1,
                                      b=>rom2,
                                      c=>ginomeno);

                                      
 U_ADDER           : adder generic map (n=>mult_length)
                            port map(a=>old,
                                     b=>ginomeno,
                                     c=>sum);
                                     
  U_REG              : loop_reg generic map (n=>mult_length)
                            port map (din=>sum,
                                      clk=>clk,
                                      rst=>rstr3,
                                      dout=>old);
                                      
  U_ADDR_GEN          : add_generator
                              port map (clk=>clk,
                                        rst=>rst,
                                        enable_ram=>en_addr_ram,
                                        enable_rom=>en_addr_rom,
                                        addr1=>address0,
                                        addr2=>address1,
                                        addr3=>addr_RAM);
                                        
  U_COUNTER            : counter generic map(n=>cnt_width)
                              port map (clk=>clk,
                                        rst=>rstr3,
                                        dout=>cnt_out);
  
  
  U_FSM					 	: FSM_final 
										port map (clk=>clk,
													 rst=>rst,
													 cnt=>cnt_out,
													 enRAM=>enRAM,
													 enROM=>enROM,
													 wr=>wr,
													 rstr3=>rstr3,
													 en_addr_ram=>en_addr_ram,
													 en_addr_rom=>en_addr_rom);
  
  end struct;