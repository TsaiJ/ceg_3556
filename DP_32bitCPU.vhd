--------------------------------------------------------------------------------
-- Titre         : Datapath du processeur
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : simple32bitcpu.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier rassemble plusieurs composants pour creer un
--    processeur a cycle simple a 32 bit d'architecture mips avec un 
--    enseble d'instruction reduit
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DP_32bitCPU IS
  PORT(
    gClock : IN STD_LOGIC;
    gReset : IN STD_LOGIC;
    ValueSelect: IN STD_LOGIC_VECTOR(2 downto 0);
    MuxOut : OUT STD_LOGIC_VECTOR(31 downto 0);
    InstructionOut : OUT STD_LOGIC_VECTOR(31 downto 0);
    BranchOut : OUT STD_LOGIC;
    ZeroOut : OUT STD_LOGIC;
    MemWriteOut : OUT STD_LOGIC ;
    RegWriteOut : OUT STD_LOGIC;
    i_WriteData : IN STD_LOGIC_VECTOR(31 downto 0);
    i_instruction : IN STD_LOGIC_VECTOR(31 downto 0)
  );
END ENTITY;

ARCHITECTURE struct OF DP_32bitCPU IS
  
  COMPONENT nbitRegister IS
    GENERIC( size : integer := 4);
    PORT(
		  i_load	: IN	STD_LOGIC;
		  i_rstBar : IN STD_LOGIC;
		  i_clock			: IN	STD_LOGIC;
		  i_Value			: IN	STD_LOGIC_VECTOR(size-1 downto 0);
		  o_Value			: OUT	STD_LOGIC_VECTOR(size-1 downto 0);
		  o_ValueBar : OUT STD_LOGIC_VECTOR(size-1 downto 0)
	  );
  END COMPONENT;
  
  COMPONENT tableDeRegistre IS
    PORT(
      gClock : IN STD_LOGIC;
      gReset : IN STD_LOGIC;
      RegWrite : IN STD_LOGIC;
      readReg1: IN STD_LOGIC_VECTOR(4 downto 0);
      readReg2: IN STD_LOGIC_VECTOR(4 downto 0);
      writeReg: IN STD_LOGIC_VECTOR(4 downto 0);
      writeData : IN STD_LOGIC_VECTOR(31 downto 0);
      readData1: OUT STD_LOGIC_VECTOR(31 downto 0);
      readData2: OUT STD_LOGIC_VECTOR(31 downto 0)
    );
  END COMPONENT;
  
  COMPONENT nbitALU IS
    GENERIC( n : INTEGER := 1 );
    PORT(
      i_A, i_B : IN STD_LOGIC_VECTOR(n-1 downto 0);
      i_op : IN STD_LOGIC_VECTOR(2 downto 0);
      o_Sum : OUT STD_LOGIC_VECTOR(n-1 downto 0);
      o_Zero : OUT STD_LOGIC
    );
  END COMPONENT;
  
  COMPONENT nbitAdder IS
    GENERIC( n : INTEGER := 1 );
    PORT (
      i_A, i_B : IN std_logic_vector( n-1 downto 0);
      i_Carry_in : IN std_logic;
      o_Carry_out : OUT std_logic;
      o_Sum : OUT STD_LOGIC_VECTOR(n-1 downto 0)
    );
  END COMPONENT;
  
  COMPONENT ALU_CP IS
    PORT(
      i_ALUop0, i_ALUop1 : IN STD_LOGIC;
      i_Function : IN STD_LOGIC_VECTOR(3 downto 0);
      o_op : OUT STD_LOGIC_VECTOR(2 downto 0)
    );
  END COMPONENT;
  
  COMPONENT nbitmux8to1 IS
    GENERIC( size : integer := 1 );
    PORT(
      i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H : IN STD_LOGIC_VECTOR(size-1 downto 0);
      i_SEL : IN STD_LOGIC_VECTOR(2 downto 0);
      o_q : OUT STD_LOGIC_VECTOR(size-1 downto 0)
    );
  END COMPONENT;
  
  COMPONENT nbitmux2to1
    GENERIC ( size : INTEGER := 1);
    PORT(
      i_A, i_B : IN STD_LOGIC_VECTOR(size-1 downto 0);
      i_SEL : IN STD_LOGIC;
      o_q : OUT STD_LOGIC_VECTOR(size-1 downto 0)
    );
  END COMPONENT;
  
  COMPONENT onebitmux2to1 IS
    PORT(
      i_A, i_B : IN STD_LOGIC;
      i_SEL : IN STD_LOGIC;
      o_q : OUT STD_LOGIC
    );
  END COMPONENT;
  
  COMPONENT CP_reduc IS
    PORT(
      i_opcode : IN STD_LOGIC_VECTOR(5 downto 0);
      RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, Jump,
      MemWrite, BEQ, BNEQ, ALUop1, ALUop0 : OUT STD_LOGIC
    );
  END COMPONENT;
  
  -- control signals
  SIGNAL int_RegDst : STD_LOGIC;
  SIGNAL int_Jump : STD_LOGIC;
  SIGNAL int_BEQ : STD_LOGIC;
  SIGNAL int_BNEQ : STD_LOGIC;
  SIGNAL int_MemRead : STD_LOGIC;
  SIGNAL int_MemWrite : STD_LOGIC;
  SIGNAL int_MemtoReg : STD_LOGIC;
  SIGNAL int_ALUop1 : STD_LOGIC;
  SIGNAL int_ALUop0 : STD_LOGIC;
  SIGNAL int_ALUSrc : STD_LOGIC;
  SIGNAL int_RegWrite : STD_LOGIC;
  
  
  SIGNAL int_RegWriteData : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_MemWriteData : STD_LOGIC_VECTOR(31 downto 0);
  -- signaux de datasim:/tb_dp_32bitcpu/int_MemWriteOut

  SIGNAL int_instr : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_WriteReg : STD_LOGIC_VECTOR(4 downto 0);
  SIGNAL int_PC : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_PC4 : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_data1, int_data2 : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_ALUResult : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_zero : STD_LOGIC;
  SIGNAL int_dataB : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_ALU_SEL : STD_LOGIC_VECTOR(2 downto 0);
  SIGNAL int_branchAddr: STD_LOGIC_VECTOR(31 downto 0);
  
  SIGNAL int_addrmux1 : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_addrmux2 : STD_LOGIC_VECTOR(31 downto 0);
  
  -- logique combinatoire du circuit
  SIGNAL int_jumpAddr : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_extendedAddr : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_branch: STD_LOGIC;
  SIGNAL int_branchOffset : STD_LOGIC_VECTOR(31 downto 0);
  
  -- valeurs constantes
  SIGNAL int_4 : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL gnd, hot : STD_LOGIC;
  
BEGIN
  
  MOUT : nbitmux8to1
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_A => int_PC,
    i_B => int_ALUResult,
    i_C => int_data1,
    i_D => int_data2,
    i_E => int_RegWriteData,
    i_F => int_branchAddr,
    i_G => int_jumpAddr,
    i_H => (others => '0'),
    i_SEL => ValueSelect,
    o_q => MuxOut
  );
  
  
  
  CP: CP_reduc
  PORT MAP(
    i_opcode => int_instr(31 downto 26),
    RegDst => int_RegDst,
    ALUSrc => int_ALUSrc,
    MemToReg => int_MemtoReg,
    RegWrite => int_RegWrite,
    MemRead => int_MemRead,
    MemWrite => int_MemWrite,
    BEQ => int_BEQ,
    BNEQ => int_BNEQ,
    Jump => int_jump,
    ALUop1 => int_ALUop1,
    ALUop0 => int_ALUop0
  );
  
  
  ALU_OP : ALU_CP
  PORT MAP(
    i_ALUop0 => int_ALUop0,
    i_ALUop1 => int_ALUop1,
    i_Function => int_instr(3 downto 0),
    o_op => int_ALU_SEL
  );
  
  
  PC : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => hot,
    i_value => int_addrmux2,
    o_Value => int_PC,
    o_ValueBar => open
  );
  
  PC4 : nbitadder
  GENERIC MAP( n => 32 )
  PORT MAP(
    i_A => int_PC,
    i_B => int_4,
    i_Carry_in => gnd,
    o_Carry_out => open,
    o_Sum => int_PC4
  );
  
  
  MWR : nbitmux2to1
  GENERIC MAP( size => 5 )
  PORT MAP(
    i_A => int_instr(20 downto 16),
    i_B => int_instr(15 downto 11),
    i_SEL => int_RegDst,
    o_q => int_WriteReg
  );
    
  
  TR : tablederegistre
  PORT MAP(
    readReg1 => int_instr(25 downto 21),
    readReg2 => int_instr(20 downto 16),
    readData1 => int_data1,
    readData2 => int_data2,
    writeData => int_RegWriteData,
    writeReg => int_writeReg,
    regWrite => int_regWrite,
    gClock => gClock,
    gReset => gReset
  );
  
  ALU : nbitALU
  GENERIC MAP ( n => 32 )
  PORT MAP(
    i_A => int_data1,
    i_B => int_dataB,
    i_op => int_ALU_SEL,
    o_Sum => int_ALUResult,
    o_Zero => int_zero
  );
  
  MALUB : nbitmux2to1
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_A => int_data2,
    i_B => int_extendedAddr,
    i_SEL => int_ALUSrc,
    o_q => int_dataB
  );
  
  
  BADDR : nbitAdder
  GENERIC MAP( n => 32 )
  PORT MAP(
    i_A => int_PC4,
    i_B => int_branchOffset,
    i_Carry_in => gnd,
    o_Carry_out => open,
    o_Sum => int_branchAddr
  );
  
  
  MBRANCH : nbitmux2to1
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_A => int_PC4,
    i_B => int_branchAddr,
    i_SEL => int_branch,
    o_q => int_addrmux1
  );
  
  MJUMP : nbitmux2to1
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_A => int_addrmux1,
    i_B => int_jumpAddr,
    i_SEL => int_jump,
    o_q => int_addrmux2
  );
  
  MData : nbitmux2to1
  GENERIC MAP( size =>32)
  PORT MAP(
    i_A => int_ALUResult,
    i_B => i_WriteData,
    i_SEL => int_MemtoReg,
    o_q => int_RegWriteData
  );
  
  
  
  -- SIGNAUX
  int_branch <= (int_beq AND int_zero) OR (int_bneq AND NOT int_zero);
  int_jumpAddr <= int_PC4(31 downto 28) & int_instr(25 downto 0) & gnd & gnd;
  int_extendedAddr <= int_instr(15) & int_instr(15) & int_instr(15) & int_instr(15)
                    & int_instr(15) & int_instr(15) & int_instr(15) & int_instr(15)
                    & int_instr(15) & int_instr(15) & int_instr(15) & int_instr(15)
                    & int_instr(15) & int_instr(15) & int_instr(15) & int_instr(15)
                    & int_instr(15 downto 0);
  int_branchOffset <= int_extendedAddr(29 downto 0) & gnd & gnd;
  
  
  -- valeurs pour les signaux constants
  gnd <= '0';
  int_4 <= x"00000004";
  hot <= '1';
  
  -- Data de memoire
  int_instr <= i_instruction;
  int_MemWriteData <= int_data2;
  
  -- a etre modifie dans le fichier final
  InstructionOut <= i_instruction;
  ZeroOut <= int_zero;
  MemWriteOut <= int_MemWrite;
  BranchOut <= int_branch;
  RegWriteOut <= int_RegWrite;
  
END struct;
