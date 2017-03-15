library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.all;
use work.constants.all;

entity counter is
  generic(n : integer :=4);
    port(clk    : in std_logic;
         rst    : in std_logic;
         dout   : out std_logic_vector(n-1 downto 0));
end counter;

architecture archi of counter is
    signal tmp  : std_logic_vector(n-1 downto 0);
begin
U_proc  : process (clk)
    begin
        if (clk'event and clk='1') then
          if (rst='1') then
            tmp <= (others=>'0');
          else
            tmp <= tmp + 1;
          end if;
        end if;
    end process U_proc;

    dout <= tmp;

end archi;
