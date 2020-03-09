LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ALU_CP IS
  PORT(
    i_ALUop0, i_ALUop1 : IN STD_LOGIC;
    i_Function : IN STD_LOGIC_VECTOR(3 downto 0);
    o_op : OUT STD_LOGIC_VECTOR(2 downto 0)
  );
END ALU_CP;

ARCHITECTURE struct OF ALU_CP IS
  
BEGIN
  
  o_op(2) <= i_ALUop0 OR (i_Function(1) AND i_ALUop1);
  o_op(1) <= NOT i_Function(2) OR NOT i_ALUop1;
  o_op(0) <= i_ALUop1 AND (i_Function(3) OR i_Function(0));
  
END struct;
