library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
  generic (n: integer :=8);
  port (a : in std_logic_vector(n-1 downto 0);
        b : in std_logic_vector(n-1 downto 0);
        c : out std_logic_vector(n-1 downto 0));
end adder;

architecture behavior of adder is
begin
  c<=std_logic_vector(signed(a)+signed(b));
end behavior;