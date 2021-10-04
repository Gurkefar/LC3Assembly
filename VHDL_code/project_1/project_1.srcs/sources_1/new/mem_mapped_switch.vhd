----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/10/2021 01:48:29 PM
-- Design Name: 
-- Module Name: mem_mapped_switch - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_mapped_switch is
port(
    clk: in std_logic;
    we: in std_logic;
    addr: in std_logic_vector(15 downto 0);
    din: in std_logic_vector(15 downto 0);
    dout: out std_logic_vector(15 downto 0)
);    
end mem_mapped_switch;

architecture Behavioral of mem_mapped_switch is

begin
    

end Behavioral;
