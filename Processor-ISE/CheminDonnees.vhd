----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:24:27 05/11/2020 
-- Design Name: 
-- Module Name:    CheminDonnees - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:35 05/06/2020 
-- Design Name: 
-- Module Name:    CheminDonnees - Behavioral 
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

entity CheminDonnees is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC);
end CheminDonnees;

architecture Behavioral of CheminDonnees is

	COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         S : OUT  std_logic_vector(7 downto 0);
         Control_ALU : IN  std_logic_vector(2 downto 0);
         N_Flag : OUT  std_logic;
         O_Flag : OUT  std_logic;
         Z_Flag : OUT  std_logic;
         C_Flag : OUT  std_logic
        );
    END COMPONENT;
	 
	--Inputs ALU
   signal A_ALU : std_logic_vector(7 downto 0) := (others => '0');
   signal B_ALU : std_logic_vector(7 downto 0) := (others => '0');
   signal Control_ALU : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs ALU
   signal S_ALU : std_logic_vector(7 downto 0);
   signal N_Flag_ALU : std_logic;
   signal O_Flag_ALU : std_logic;
   signal Z_Flag_ALU : std_logic;
   signal C_Flag_ALU : std_logic;
	
	--------------------------------------------------------------------------
	
	COMPONENT BancMemoireInstruction
    PORT(
         addr : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
			RST : in  STD_LOGIC;
         OUT_INSTR : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	--Inputs BMI
   signal addr_BMI : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs BMI
   signal OUT_INSTR_BMI : std_logic_vector(31 downto 0);
	
	--------------------------------------------------------------------------
	
	COMPONENT BancRegistres
    PORT(
         addrA : IN  std_logic_vector(3 downto 0);
         addrB : IN  std_logic_vector(3 downto 0);
         addrW : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
	
	--Inputs BR
   signal addrA_BR : std_logic_vector(3 downto 0) := (others => '0');
   signal addrB_BR : std_logic_vector(3 downto 0) := (others => '0');
   signal addrW_BR : std_logic_vector(3 downto 0) := (others => '0');
   signal W_BR : std_logic := '0';
   signal DATA_BR : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs BR
   signal QA_BR : std_logic_vector(7 downto 0);
   signal QB_BR : std_logic_vector(7 downto 0);
	
	--------------------------------------------------------------------------
	
	COMPONENT BancMemoire
    PORT(
         addr : IN  std_logic_vector(7 downto 0);
         IN_DATA : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         OUT_DATA : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
	
	--Inputs BM
   signal addr_BM : std_logic_vector(7 downto 0) := (others => '0');
   signal IN_DATA_BM : std_logic_vector(7 downto 0) := (others => '0');
   signal RW_BM : std_logic := '0';

 	--Outputs BM
   signal OUT_DATA_BM : std_logic_vector(7 downto 0);
	
	--------------------------------------------------------------------------
	
	COMPONENT Pipeline
    PORT(
         OP_IN : IN  std_logic_vector(7 downto 0);
         OP_OUT : OUT  std_logic_vector(7 downto 0);
         A_IN : IN  std_logic_vector(7 downto 0);
         A_OUT : OUT  std_logic_vector(7 downto 0);
         B_IN : IN  std_logic_vector(7 downto 0);
         B_OUT : OUT  std_logic_vector(7 downto 0);
         C_IN : IN  std_logic_vector(7 downto 0);
         C_OUT : OUT  std_logic_vector(7 downto 0);
         CLK : IN  std_logic
        );
    END COMPONENT;
	
	--Inputs PPL LI/DI
   signal OP_IN_PPL_LIDI : std_logic_vector(7 downto 0) := (others => '0');
   signal A_IN_PPL_LIDI : std_logic_vector(7 downto 0) := (others => '0');
   signal B_IN_PPL_LIDI : std_logic_vector(7 downto 0) := (others => '0');
   signal C_IN_PPL_LIDI : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs PPL LI/DI
   signal OP_OUT_PPL_LIDI : std_logic_vector(7 downto 0);
   signal A_OUT_PPL_LIDI : std_logic_vector(7 downto 0);
   signal B_OUT_PPL_LIDI : std_logic_vector(7 downto 0);
   signal C_OUT_PPL_LIDI : std_logic_vector(7 downto 0);
	
	
	--Inputs PPL DI/EX
   signal OP_IN_PPL_DIEX : std_logic_vector(7 downto 0) := (others => '0');
   signal A_IN_PPL_DIEX : std_logic_vector(7 downto 0) := (others => '0');
   signal B_IN_PPL_DIEX : std_logic_vector(7 downto 0) := (others => '0');
   signal C_IN_PPL_DIEX : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs PPL DI/EX
   signal OP_OUT_PPL_DIEX : std_logic_vector(7 downto 0);
   signal A_OUT_PPL_DIEX : std_logic_vector(7 downto 0);
   signal B_OUT_PPL_DIEX : std_logic_vector(7 downto 0);
   signal C_OUT_PPL_DIEX : std_logic_vector(7 downto 0);
	
	
	--Inputs PPL EX/Mem
   signal OP_IN_PPL_EXMem : std_logic_vector(7 downto 0) := (others => '0');
   signal A_IN_PPL_EXMem : std_logic_vector(7 downto 0) := (others => '0');
   signal B_IN_PPL_EXMem : std_logic_vector(7 downto 0) := (others => '0');
   signal C_IN_PPL_EXMem : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs PPL EX/Mem
   signal OP_OUT_PPL_EXMem : std_logic_vector(7 downto 0);
   signal A_OUT_PPL_EXMem : std_logic_vector(7 downto 0);
   signal B_OUT_PPL_EXMem : std_logic_vector(7 downto 0);
   signal C_OUT_PPL_EXMem : std_logic_vector(7 downto 0);
	
	
	--Inputs PPL Mem/RE
   signal OP_IN_PPL_MemRE : std_logic_vector(7 downto 0) := (others => '0');
   signal A_IN_PPL_MemRE : std_logic_vector(7 downto 0) := (others => '0');
   signal B_IN_PPL_MemRE : std_logic_vector(7 downto 0) := (others => '0');
   signal C_IN_PPL_MemRE : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs PPL Mem/RE
   signal OP_OUT_PPL_MemRE : std_logic_vector(7 downto 0);
   signal A_OUT_PPL_MemRE : std_logic_vector(7 downto 0);
   signal B_OUT_PPL_MemRE : std_logic_vector(7 downto 0);
   signal C_OUT_PPL_MemRE : std_logic_vector(7 downto 0);
	
	--------------------------------------------------------------------------
	signal Pointeur_instruction : std_logic_vector(7 downto 0) := (others => '0'); 

begin

	-- Instantiate the ALU
   alu_inst: ALU PORT MAP (
          A => A_ALU,
          B => B_ALU,
          S => S_ALU,
          Control_ALU => Control_ALU,
          N_Flag => open,
          O_Flag => open,
          Z_Flag => open,
          C_Flag => open
        );
	
	-- Instantiate the BMI
	bmi: BancMemoireInstruction PORT MAP (
          addr => addr_BMI,
          CLK => CLK,
			 RST => RST,
          OUT_INSTR => OUT_INSTR_BMI
        );
		
	-- Instantiate the BR
	br: BancRegistres PORT MAP (
          addrA => addrA_BR,
          addrB => addrB_BR,
          addrW => addrW_BR,
          W => W_BR,
          DATA => DATA_BR,
          RST => RST,
          CLK => CLK,
          QA => QA_BR,
          QB => QB_BR
        );
	
	-- Instantiate the BM
	bm: BancMemoire PORT MAP (
          addr => addr_BM,
          IN_DATA => IN_DATA_BM,
          RW => RW_BM,
          RST => RST,
          CLK => CLK,
          OUT_DATA => OUT_DATA_BM
        );
	
	-- Instantiate the PPL LI/DI
	ppl_lidi: Pipeline PORT MAP (
          OP_IN => OP_IN_PPL_LIDI,
          OP_OUT => OP_OUT_PPL_LIDI,
          A_IN => A_IN_PPL_LIDI,
          A_OUT => A_OUT_PPL_LIDI,
          B_IN => B_IN_PPL_LIDI,
          B_OUT => B_OUT_PPL_LIDI,
          C_IN => C_IN_PPL_LIDI,
          C_OUT => C_OUT_PPL_LIDI,
          CLK => CLK
        );
		  
	-- Instantiate the PPL DI/EX
	ppl_diex: Pipeline PORT MAP (
          OP_IN => OP_IN_PPL_DIEX,
          OP_OUT => OP_OUT_PPL_DIEX,
          A_IN => A_IN_PPL_DIEX,
          A_OUT => A_OUT_PPL_DIEX,
          B_IN => B_IN_PPL_DIEX,
          B_OUT => B_OUT_PPL_DIEX,
          C_IN => C_IN_PPL_DIEX,
          C_OUT => C_OUT_PPL_DIEX,
          CLK => CLK
        );
		  
	-- Instantiate the PPL EX/Mem
	ppl_exmem: Pipeline PORT MAP (
          OP_IN => OP_IN_PPL_EXMem,
          OP_OUT => OP_OUT_PPL_EXMem,
          A_IN => A_IN_PPL_EXMem,
          A_OUT => A_OUT_PPL_EXMem,
          B_IN => B_IN_PPL_EXMem,
          B_OUT => B_OUT_PPL_EXMem,
          C_IN => C_IN_PPL_EXMem,
          C_OUT => open,
          CLK => CLK
        );
		  
	-- Instantiate the PPL Mem/RE
	ppl_memre: Pipeline PORT MAP (
          OP_IN => OP_IN_PPL_MemRE,
          OP_OUT => OP_OUT_PPL_MemRE,
          A_IN => A_IN_PPL_MemRE,
          A_OUT => A_OUT_PPL_MemRE,
          B_IN => B_IN_PPL_MemRE,
          B_OUT => B_OUT_PPL_MemRE,
          C_IN => C_IN_PPL_MemRE,
          C_OUT => open,
          CLK => CLK
        );
		  
	Incrementation_pointeur_instruction: process
	begin
		
		wait until CLK'event and CLK = '1';
		if (RST = '0') then
			Pointeur_instruction <= (others => '0');
		else
			Pointeur_instruction <= Pointeur_instruction + 1;
		end if;
		
	end process;
	
	-- Etage 1 : Lecture Instruction
	addr_BMI <= Pointeur_instruction;
	OP_IN_PPL_LIDI <= OUT_INSTR_BMI(31 downto 24);
	A_IN_PPL_LIDI <= OUT_INSTR_BMI(23 downto 16);
	B_IN_PPL_LIDI <= OUT_INSTR_BMI(15 downto 8);
	C_IN_PPL_LIDI <= OUT_INSTR_BMI(7 downto 0);
	
	-- Etage 2 : Banc Registres Lecture
	OP_IN_PPL_DIEX <= OP_OUT_PPL_LIDI;
	A_IN_PPL_DIEX <= A_OUT_PPL_LIDI;
	B_IN_PPL_DIEX <= B_OUT_PPL_LIDI when (OP_OUT_PPL_LIDI = x"06" or OP_OUT_PPL_LIDI = x"07") else QA_BR;
	C_IN_PPL_DIEX <= QB_BR;
	addrA_BR <= B_OUT_PPL_LIDI(3 downto 0);
	addrB_BR <= C_OUT_PPL_LIDI(3 downto 0);
	
	-- Etage 3 : ALU
	OP_IN_PPL_EXMem <= OP_OUT_PPL_DIEX;
	A_IN_PPL_EXMem <= A_OUT_PPL_DIEX;
	
	A_ALU <= B_OUT_PPL_DIEX;
	B_ALU <= C_OUT_PPL_DIEX;
	Control_ALU <= OP_OUT_PPL_DIEX(2 downto 0);
	
	B_IN_PPL_EXMem <= S_ALU when (OP_OUT_PPL_DIEX = x"01" or OP_OUT_PPL_DIEX = x"02" or OP_OUT_PPL_DIEX = x"03" or OP_OUT_PPL_DIEX = x"04")
									else B_OUT_PPL_DIEX;

	-- Etage 4 : Banc Memoire
	OP_IN_PPL_MemRE <= OP_OUT_PPL_EXMem;
	A_IN_PPL_MemRE <= A_OUT_PPL_EXMem;
	B_IN_PPL_MemRE <= OUT_DATA_BM when (OP_OUT_PPL_EXMem = x"07") else B_OUT_PPL_EXMem;
	addr_BM <= A_OUT_PPL_EXMem when (OP_OUT_PPL_EXMem = x"08") else B_OUT_PPL_EXMem;
	IN_DATA_BM <= B_OUT_PPL_EXMem;
	RW_BM <= '0' when (OP_OUT_PPL_EXMem = x"08") else '1';
	
	-- Etage 5 : Banc Registres Ecriture
	W_BR <= '0' when (OP_OUT_PPL_MemRE = x"08" or OP_OUT_PPL_MemRE = x"00") else '1';
	addrW_BR <= A_OUT_PPL_MemRE(3 downto 0);
	DATA_BR <= B_OUT_PPL_MemRE; 

end Behavioral;
