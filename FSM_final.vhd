library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity FSM_final is
port  ( clk				: in std_logic;
		rst			: in std_logic;
		cnt				: in std_logic_vector(cnt_width-1 downto 0);
		enRAM			: out std_logic;
		enROM			: out std_logic;
		wr				: out std_logic;
		rstr3			: out std_logic;
		en_addr_ram		: out std_logic;
		en_addr_rom		: out std_logic);
end FSM_final;

architecture behavior of FSM_final is

signal current_state	: state;
signal next_state		: state;
signal enRAM_i			: std_logic;
signal enROM_i			: std_logic;
signal wr_i				: std_logic;
signal en_addr_ram_i	: std_logic;
signal en_addr_rom_i	: std_logic;
signal rstr3_i			: std_logic;

begin

U_CLK :  process (clk)
	begin
		if (clk'event and clk='1') then
			if (rst = '1') then
				current_state 	<= s1;
				enRAM 			<= '0';
				enROM			<= '1';
				wr 				<= '0';
				rstr3 			<= '1';
				en_addr_rom 	<= '1';
				en_addr_ram 	<= '0';
			else
				current_state 	<= next_state;
				enRAM 			<= enRAM_i;
				enROM 			<= enROM_i;
				wr 				<= wr_i;
				rstr3 			<= rstr3_i;
				en_addr_rom 	<= en_addr_rom_i;
				en_addr_ram 	<= en_addr_ram_i;
			end if;
		end if;
	end process U_CLK;

U_OUTPUT_DEC : process (current_state)
	begin
    if (current_state = s1) then
			enRAM_i 			<='0';
			enROM_i 			<='1';
			wr_i 				<='0';
			rstr3_i 			<='0';
			en_addr_rom_i 	<='1';
			en_addr_ram_i 	<='0';

		elsif (current_state = s2) then
			enRAM_i 				<='1';
			enROM_i 				<='1';
			wr_i 					<='1';
			rstr3_i 				<='1';
			en_addr_rom_i 		<='1';
			en_addr_ram_i 		<='0';
		
		elsif (current_state = calc) then
			enRAM_i 				<='1';
			enROM_i 				<='1';
			wr_i 					<='0';
			rstr3_i 				<='0';
			en_addr_rom_i 		<='1';
			en_addr_ram_i 		<='0';

		elsif (current_state = init) then
			enRAM_i 				<='1';
			enROM_i 				<='1';
			wr_i 					<='0';
			rstr3_i 				<='0';
			en_addr_rom_i 		<='1';
			en_addr_ram_i 		<='1';

		else 
			enRAM_i 				<='1';
			enROM_i 				<='1';
			wr_i 					<='1';
			rstr3_i 				<='1';
			en_addr_rom_i 		<='1';
			en_addr_ram_i 		<='0';

		end if;
	end process U_OUTPUT_DEC;

U_NEXT_DEC : process (current_state,cnt)
	begin
		--next_state <= current_state;
		case (current_state) is

			when s1 =>
				if(cnt = "0010") then
					next_state 	<= s2;
				else
					next_state 	<= s1;
				end if;

			when s2 =>
				next_state 	<= calc;

			when calc =>
				if (cnt = "0001") then
					next_state <= init;
				else 
					next_state <= calc;
				end if;

			when init =>
				next_state <= write_state;
		
			when write_state =>
				next_state <= calc;

			when others =>
				next_state <= s1;

			end case;
		end process U_NEXT_DEC;

end behavior;
