--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:34:35 05/06/2020
-- Design Name:   
-- Module Name:   C:/Users/antho/Processor/Test_Pipeline.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pipeline
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_Pipeline IS
END Test_Pipeline;
 
ARCHITECTURE behavior OF Test_Pipeline IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal OP_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal A_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal B_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal C_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal OP_OUT : std_logic_vector(7 downto 0);
   signal A_OUT : std_logic_vector(7 downto 0);
   signal B_OUT : std_logic_vector(7 downto 0);
   signal C_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pipeline PORT MAP (
          OP_IN => OP_IN,
          OP_OUT => OP_OUT,
          A_IN => A_IN,
          A_OUT => A_OUT,
          B_IN => B_IN,
          B_OUT => B_OUT,
          C_IN => C_IN,
          C_OUT => C_OUT,
          CLK => CLK
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		A_IN <= x"12";
		B_IN <= x"43";
		C_IN <= x"a3";
		OP_IN <= x"02";
		wait for 22 ns;
		
		A_IN <= x"ff";
		B_IN <= x"fd";
		C_IN <= x"00";
		OP_IN <= x"08";
		wait for 20 ns;

      wait;
   end process;

END;
