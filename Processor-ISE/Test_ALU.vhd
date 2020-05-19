--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:58:57 04/24/2020
-- Design Name:   
-- Module Name:   C:/Users/antho/Processor/Test_ALU.vhd
-- Project Name:  Processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY Test_ALU IS
END Test_ALU;
 
ARCHITECTURE behavior OF Test_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal Control_ALU : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(7 downto 0);
   signal N_Flag : std_logic;
   signal O_Flag : std_logic;
   signal Z_Flag : std_logic;
   signal C_Flag : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          S => S,
          Control_ALU => Control_ALU,
          N_Flag => N_Flag,
          O_Flag => O_Flag,
          Z_Flag => Z_Flag,
          C_Flag => C_Flag
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
--		A <= x"10";
--		B <= x"04";
--		Control_ALU <= "001";
--    wait for 20 ns;
--		
--		A <= x"00";
--		B <= x"00";
--		Control_ALU <= "001";
--		wait for 20 ns;
--		
--		A <= x"7E";
--		B <= x"0A";
--		Control_ALU <= "001";
--		wait for 20 ns;
		 
--		A <= x"0C";
--		B <= x"0A";
--		Control_ALU <= "010";
--		wait for 20 ns;
--		
--		A <= x"02";
--		B <= x"40";
--		Control_ALU <= "010";
--		wait for 20 ns;
--		
--		A <= x"27";
--		B <= x"00";
--		Control_ALU <= "010";
--		wait for 20 ns;
--		
--		A <= x"E0";
--		B <= x"0A";
--		Control_ALU <= "010";
--		wait for 20 ns;

		A <= x"0C";
		B <= x"0A";
		Control_ALU <= "011";
		wait for 20 ns;
		
		A <= x"FF";
		B <= x"E0";
		Control_ALU <= "011";
		wait for 20 ns;
		
		A <= x"0A";
		B <= x"0C";
		Control_ALU <= "011";
		wait for 20 ns;
		
		A <= x"0A";
		B <= x"80";
		Control_ALU <= "011";
		wait for 20 ns;
		
   end process;

END;
