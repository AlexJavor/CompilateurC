----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:22 04/15/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           Control_ALU : in  STD_LOGIC_VECTOR (2 downto 0);
           N_Flag : out  STD_LOGIC;
           O_Flag : out  STD_LOGIC;
           Z_Flag : out  STD_LOGIC;
           C_Flag : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
	signal Resultat_Temp : STD_LOGIC_VECTOR (15 downto 0);
begin

		-- Realisation des calculs
		
		Resultat_Temp <= (x"00" & A) + (x"00" & B) when Control_ALU = "001" else
								A * B when Control_ALU = "010" else
								(x"00" & A) - (x"00" & B) when Control_ALU = "011" else
								x"0000";
			
		
		
		S <= Resultat_Temp(7 downto 0);
		
		-- Traitement flags
		-- Flag Z
		Z_Flag <= '1' when Resultat_Temp(7 downto 0) = x"00" else '0';
		
		-- Flag N
		N_Flag <= Resultat_Temp(7);
		
		-- Flag C
		C_Flag <= Resultat_Temp(8);
		
		-- Flag O
		O_Flag <= '1' when Control_ALU = "001" and ((A(7) = '1' and B(7) = '1' and Resultat_Temp(7) = '0') or (A(7) = '0' and B(7) = '0' and Resultat_Temp(7) = '1')) else
						'1' when Control_ALU = "010" and (Resultat_Temp(15 downto 8) /= x"00" or ((A(7) = '1' and B(7) = '1' and Resultat_Temp(7) = '1') or (A(7) = '0' and B(7) = '0' and Resultat_Temp(7) = '1') or ((A(7) = '1' xor B(7) = '1') and Resultat_Temp(7) = '0'))) else
						'1' when Control_ALU = "011" and ((A(7) = '1' and B(7) = '0' and Resultat_Temp(7) = '0') or (A(7) = '0' and B(7) = '1' and Resultat_Temp(7) = '1')) else
						'0';

end Behavioral;