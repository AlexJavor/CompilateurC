----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:32:00 04/29/2020 
-- Design Name: 
-- Module Name:    BancRegistres - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BancRegistres is
    Port ( addrA : in  STD_LOGIC_VECTOR (3 downto 0);
           addrB : in  STD_LOGIC_VECTOR (3 downto 0);
           addrW : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end BancRegistres;



architecture Behavioral of BancRegistres is

	type registers_array is
		 array (natural range 15 downto 0) -- On a 16 registres
		 of std_logic_vector (7 downto 0);   -- de 8 bits chacun

	signal registers: registers_array;

begin
	
	registres: process
	begin
		
		wait until CLK'event and CLK = '1';
		if (RST = '0') then
			registers <= (others => x"00");
		
		else
			if (W = '1') then
				registers(to_integer(unsigned(addrW))) <= DATA;
			end if;
		end if;
				
	end process;
	
	QA <= DATA when (addrA = addrW and W = '1') else registers(to_integer(unsigned(addrA)));
	QB <= DATA when (addrB = addrW and W = '1') else registers(to_integer(unsigned(addrB)));
	
end Behavioral;

