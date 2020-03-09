
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY TB_CP_reduc IS
END TB_CP_reduc;

ARCHITECTURE struct OF TB_CP_reduc IS
  
  COMPONENT CP_reduc IS
    PORT(
      i_opcode : IN STD_LOGIC_VECTOR(5 downto 0);
      RegDst, ALUSrc, MemtoReg, RegWrite, MemRead,
      MemWrite, BEQ, BNEQ, ALUop1, ALUop0 : OUT STD_LOGIC
    );
  END COMPONENT;
  
  SIGNAL int_opcode : STD_LOGIC_VECTOR(5 downto 0);
  SIGNAL RegDst, ALUSrc, MemtoReg, RegWrite, MemRead,
          MemWrite, BEQ, BNEQ, ALUop1, ALUop0: STD_LOGIC;

BEGIN
  
  UUT: CP_reduc
  PORT MAP(
    i_opcode => int_opcode,
    RegDst => RegDst,
    ALUSrc => ALUSrc,
    MemToReg => MemtoReg,
    RegWrite => RegWrite,
    MemRead => MemRead,
    MemWrite => MemWrite,
    BEQ => BEQ,
    BNEQ => BNEQ,
    ALUop1 => ALUop1,
    ALUop0 => ALUop0
  );
  
  gen_opcode : PROCESS
  BEGIN
    int_opcode <= "000000";
    wait for 20 ns;
    int_opcode <= "000100";
    wait for 20 ns;
    int_opcode <= "000101";
    wait for 20 ns;
    int_opcode <= "100011";
    wait for 20 ns;
    int_opcode <= "101011";
    wait for 20 ns;
    wait;
  END PROCESS;
  
END struct;
  
  
  
  
  

