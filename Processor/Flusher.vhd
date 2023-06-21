
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Flusher IS 
PORT
(
OPCODE:IN STD_LOGIC_VECTOR(4 DOWNTO 0);
funct: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
EX_MEM_ALU_OPERATION: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
M2_ALU_OP: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
ZF,CF,SF: IN STD_LOGIC;
INTERRUPT: IN STD_LOGIC;
if_idflush: OUT STD_LOGIC;
id_exflush: OUT STD_LOGIC
);

END ENTITY;

ARCHITECTURE ARC OF Flusher IS 

BEGIN
PROCESS(OPCODE,ZF,CF)
BEGIN --JZ JC JMP RET RTI in order
IF (ZF='1' AND OPCODE="11000" AND funct="000") OR (CF='1' AND OPCODE="11001" AND funct="000") OR
(ZF='0' AND OPCODE="11000" AND funct="011") OR (CF='0' AND OPCODE="11001" AND funct="011") 
OR (OPCODE="11011" AND funct="000") --JMP
OR (OPCODE="11011" AND funct="001" AND SF='0')--JGE 
OR (OPCODE="11011" AND funct="010" AND ZF='1' AND SF/='0')--JLE 
OR (OPCODE="11011" AND funct="001" AND ZF='0' AND SF='0')--JG 
OR (OPCODE="11011" AND funct="001" AND SF/='0')--JL 



OR (OPCODE="01100")
OR (OPCODE="01101") OR (OPCODE="01110") --RET OR RTI 
-- OR EX_MEM_ALU_OPERATION="01101" OR EX_MEM_ALU_OPERATION="01110" --OR M2_ALU_OP="01101" OR M2_ALU_OP="01110"  

--added on 17/6/2023 --very suspicious
-- OR (OPCODE="00111") OR (OPCODE="10010")
THEN 
if_idflush<='1';
id_exflush<='1';
-- FROM 30 TO 33 IS THE ADDITION
ELSIF (OPCODE="00111") OR (OPCODE="10010") THEN --LDM and IADD
if_idflush<='0'; 
id_exflush<='1';
ELSE 
if_idflush<='0';
id_exflush<='0';
END IF;

END PROCESS;

END ARC;





