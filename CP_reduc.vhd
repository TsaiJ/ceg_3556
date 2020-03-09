
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CP_reduc IS
  PORT(
    i_opcode : IN STD_LOGIC_VECTOR(5 downto 0);
    RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, Jump,
    MemWrite, BEQ, BNEQ, ALUop1, ALUop0 : OUT STD_LOGIC
  );
END CP_reduc;

ARCHITECTURE struct OF CP_reduc IS
  
  SIGNAL int_typeR, int_lw, int_sw, int_beq, int_bneq, int_jump : STD_LOGIC;

BEGIN
  -- "000000" = 0
  int_typeR <= NOT i_opcode(5) AND NOT i_opcode(4) AND NOT i_opcode(3)
                AND NOT i_opcode(2) AND NOT i_opcode(1) AND NOT i_opcode(0);
                
  -- "100011" = 35
  int_lw <= i_opcode(5) AND NOT i_opcode(4) AND NOT i_opcode(3)
              AND NOT i_opcode(2) AND i_opcode(1) AND i_opcode(0);
  
  -- "101011" = 43
  int_sw <= i_opcode(5) AND NOT i_opcode(4) AND i_opcode(3) AND NOT i_opcode(2)
              AND i_opcode(1) AND i_opcode(0);
  
  -- "000010" = 2
  int_jump <= NOT i_opcode(5) AND NOT i_opcode(4) AND NOT i_opcode(3)
              AND NOT i_opcode(2) AND i_opcode(1) AND NOT i_opcode(0);
  
  -- "000100" = 4
  int_beq <= NOT i_opcode(5) AND NOT i_opcode(4) AND NOT i_opcode(3)
              AND i_opcode(2) AND NOT i_opcode(1) AND NOT i_opcode(0);
  
  -- "000101" = 5
  int_bneq <= NOT i_opcode(5) AND NOT i_opcode(4) AND NOT i_opcode(3)
              AND i_opcode(2) AND NOT i_opcode(1) AND i_opcode(0);
  
  -- Signaux de sorties
  RegDst <= int_typeR;
  ALUSrc <= int_sw OR int_lw;
  MemToReg <= int_lw;
  RegWrite <= int_lw OR int_typeR;
  MemRead <= int_lw;
  MemWrite <= int_sw;
  BEQ <= int_beq;
  BNEQ <= int_bneq;
  JUMP <= int_jump;
  ALUop1 <= int_typeR;
  ALUop0 <= int_beq OR int_bneq;
  
END struct;