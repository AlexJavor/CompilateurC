----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:45:30 04/29/2020 
-- Design Name: 
-- Module Name:    BancMemoire - Behavioral 
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

entity BancMemoire is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           IN_DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OUT_DATA : out  STD_LOGIC_VECTOR (7 downto 0));
end BancMemoire;

architecture Behavioral of BancMemoire is

	type memory_array is
		 array (natural range 255 downto 0) -- On a 256 cases memoire
		 of std_logic_vector (7 downto 0);   -- de 8 bits chacun

	signal memories: memory_array;

begin

	registres: process
	begin
		
		wait until CLK'event and CLK = '1';
		if (RST = '0') then
			memories <= (others => x"00");
		else
			if (RW = '0') then
			-- Ecriture
				memories(to_integer(unsigned(addr))) <= IN_DATA;
			end if;
		end if;
				
	end process;
	-- Lecture
	OUT_DATA <= memories(to_integer(unsigned(addr)));

end Behavioral;

