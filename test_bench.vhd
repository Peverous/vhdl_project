library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity testbench is
end testbench;

architecture test_system of testbench is
component system2 is
  port (clk       	: in std_logic;
        rst     	: in std_logic;
        dout      	: out std_logic_vector(mult_length-1 downto 0));
end component;

signal clk 				: std_logic;
signal rst 				: std_logic;
signal data_out 		: std_logic_vector(mult_length-1 downto 0);
constant clock_period 	: time :=50 ns;

begin

UUT : system2 port map (clk=>clk,
						rst=>rst,
						dout=>data_out);

process
 begin
  clk<= '1';
  wait for clock_period/2;
  clk<='0';
  wait for clock_period/2;
end process;

process
 begin
  rst<='1';
  wait for 50 ns;
  rst<='0';
  wait for 5000 ns;
 end process;

end test_system;
