library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul is
  generic (n : integer:=8);
  port (a : in std_logic_vector (n-1 downto 0);
        b : in std_logic_vector (n-1 downto 0);
        c : out std_logic_vector (2*n-1 downto 0));
end mul;

architecture multiplication of mul is
begin
c <= std_logic_vector(signed(a)*signed(b));
end multiplication; 
