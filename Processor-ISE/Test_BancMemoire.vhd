--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:52:01 04/29/2020
-- Design Name:   
-- Module Name:   C:/Users/antho/Processor/Test_BancMemoire.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BancMemoire
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
 
ENTITY Test_BancMemoire IS
END Test_BancMemoire;
 
ARCHITECTURE behavior OF Test_BancMemoire IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal addr : std_logic_vector(7 downto 0) := (others => '0');
   signal IN_DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal OUT_DATA : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BancMemoire PORT MAP (
          addr => addr,
          IN_DATA => IN_DATA,
          RW => RW,
          RST => RST,
          CLK => CLK,
          OUT_DATA => OUT_DATA
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

		RST <= '0';
      wait for 20 ns;
		
		RST <= '1';
		RW <= '0';
		addr <= x"fa";
		IN_DATA <= x"ff";
		wait for 20 ns;
		
		RST <= '1';
		RW <= '1';
		addr <= x"fa";
		IN_DATA <= x"4d";
		wait for 20 ns;
		
      wait;
   end process;

END;
