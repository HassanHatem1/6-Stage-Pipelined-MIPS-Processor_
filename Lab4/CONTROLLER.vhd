Library ieee;
Use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use IEEE.math_real.all;

ENTITY CONTROLLER IS
PORT(
CLK: IN STD_LOGIC;
INPUT: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
ALU_OPERATION: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
CIN: OUT STD_LOGIC;
WRITE_EN: OUT STD_LOGIC
--READ_EN: OUT STD_LOGIC
);
END ENTITY;

ARCHITECTURE ZAKARIA OF CONTROLLER IS

BEGIN

PROCESS(CLK)
BEGIN


IF INPUT="010" THEN--XOR
ALU_OPERATION<="0100" ;
WRITE_EN<='1';
CIN<='0';
ELSIF INPUT="011" THEN--INC 
ALU_OPERATION<="0000" ;
WRITE_EN<='1';
CIN<='1';
ELSIF INPUT="001" THEN
ALU_OPERATION<="0001";
WRITE_EN<='1';
CIN<='0';
ELSE
ALU_OPERATION<="1011";
WRITE_EN<='0';
CIN<='0';
END IF;


END PROCESS;

END ZAKARIA;
