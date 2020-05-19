----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:27 05/06/2020 
-- Design Name: 
-- Module Name:    Pipeline - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pipeline is
    Port ( OP_IN : in STD_LOGIC_VECTOR(7 downto 0);
           OP_OUT : out  STD_LOGIC_VECTOR(7 downto 0);
           A_IN : in  STD_LOGIC_VECTOR(7 downto 0);
           A_OUT : out  STD_LOGIC_VECTOR(7 downto 0);
           B_IN : in  STD_LOGIC_VECTOR(7 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR(7 downto 0);
           C_IN : in  STD_LOGIC_VECTOR(7 downto 0);
           C_OUT : out  STD_LOGIC_VECTOR(7 downto 0);
           CLK : in  STD_LOGIC);
end Pipeline;

architecture Behavioral of Pipeline is

begin

	pipeline: process
	begin
		
		wait until CLK'event and CLK = '1';
		OP_OUT <= OP_IN;
		A_OUT <= A_IN;
		B_OUT <= B_IN;
		C_OUT <= C_IN;
		
	end process;

end Behavioral;

