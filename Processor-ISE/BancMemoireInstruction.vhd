----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:02:57 04/29/2020 
-- Design Name: 
-- Module Name:    BancMemoireInstruction - Behavioral 
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
use std.textio.all;
-- From ieee synopsys, to have the hread function.
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BancMemoireInstruction is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
			  RST : in  STD_LOGIC;
           OUT_INSTR : out  STD_LOGIC_VECTOR (31 downto 0));
end BancMemoireInstruction;

architecture Behavioral of BancMemoireInstruction is

	type intruction_array is
		 array (natural range 255 downto 0) -- On a 256 instructions
		 of std_logic_vector (31 downto 0);   -- de 32 bits chacune

	signal instructions: intruction_array;
	
	-- Init memory with the filename "init_file" or not.
  impure function init_mem(filename: in string) return intruction_array is
    file f_handler: text;
    variable mem: intruction_array;
    variable f_line: line;
    variable data_line : std_logic_vector(31 downto 0);
    variable good: boolean;
    variable lineno: integer := 0;
  begin
    mem := (others => (others => '0'));
    file_open(f_handler, filename, READ_MODE);
    while (not endfile(f_handler)) loop
      readline(f_handler, f_line);
      hread(f_line, data_line, good);
      assert good report "READ ERROR" severity warning;
      mem(lineno) := data_line;
      lineno := lineno + 1;
    end loop;
    file_close(f_handler);
    return mem;
  end function;

begin

	instructions_proc: process
	begin
		wait until CLK'event and CLK = '1';
		if (RST = '0') then
			instructions <= init_mem("init_mem_instr");
		end if;
	end process;
	
	OUT_INSTR <= instructions(to_integer(unsigned(addr)));

end Behavioral;

