library ieee;
use ieee.std_logic_1164.all;


entity loop_reg is
  generic (n : integer := 8);
port (din : in std_logic_vector(n-1 downto 0);
      clk : in std_logic;
      rst : in std_logic;
      dout : out std_logic_vector (n-1 downto 0));
end loop_reg;

architecture behavioral of loop_reg is
begin
U_proc:	process (clk)
	begin
		if rising_edge(clk) then 
		   if (rst='1') then
		       dout <= (others=> '0');
		   else
			     dout <=din;
			 end if;
		end if;
	end process U_proc;

end behavioral;