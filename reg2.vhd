library ieee;
use ieee.std_logic_1164.all;


entity reg2 is
  generic (n : integer := 8);
port (din : in std_logic_vector(n-1 downto 0);
      clk : in std_logic;
      rst : in std_logic;
      load : in std_logic;
      dout : out std_logic_vector (n-1 downto 0));
end reg2;

architecture behavioral of reg2 is
begin
U_proc:	process (clk)
	begin
		if rising_edge(clk) then 
		   if (rst='1') then
		       dout <= (others=> '0');
		   elsif (load='1') then
			     dout <=din;
			 end if;
		end if;
	end process U_proc;

end behavioral;