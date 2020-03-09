
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPU32bit IS
  PORT(
    gClock : IN STD_LOGIC;
    gReset : IN STD_LOGIC;
	 memClock : IN STD_LOGIC;
	 i_enable : IN STD_LOGIC;
	 InstructionOut : OUT STD_LOGIC_VECTOR(31 downto 0);
    ValueSelect: IN STD_LOGIC_VECTOR(2 downto 0);
    MuxOut : OUT STD_LOGIC_VECTOR(31 downto 0);
    BranchOut : OUT STD_LOGIC;
    ZeroOut : OUT STD_LOGIC;
    MemWriteOut : OUT STD_LOGIC ;
    RegWriteOut : OUT STD_LOGIC
  );
END ENTITY;

ARCHITECTURE struct OF CPU32bit IS
  
  COMPONENT ROM_1_port_lab2 IS
	  PORT(
		 address : IN STD_LOGIC_VECTOR(7 downto 0);
		 clock : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(31 downto 0)
		);
	END COMPONENT;
  
  COMPONENT RAM_1_port_lab2 IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC;
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
  END COMPONENT;
  
  
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
  
  COMPONENT signExtend16to32bit IS
    PORT(
	  i_v : IN STD_LOGIC_VECTOR(15 downto 0);
	  o_v : OUT STD_LOGIC_VECTOR(31 downto 0)
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
  SIGNAL int_MemData : STD_LOGIC_VECTOR(31 downto 0);
  -- signaux de datasim:/tb_CPU32bit/int_MemWriteOut

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
  
  SIGNAL int_RAMWrite : STD_LOGIC;
  SIGNAL int_notClock : STD_LOGIC;
  -- logique combinatoire du circuit
  SIGNAL int_jumpAddr : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_extendedAddr : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_branch: STD_LOGIC;
  SIGNAL int_branchOffset : STD_LOGIC_VECTOR(31 downto 0);
  
  -- valeurs constantes
  SIGNAL int_4 : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL gnd, hot : STD_LOGIC;
  
BEGIN
  -----------------------------------------------------------------------------
  -- Mux pour observer les valeurs de certain signaux pendant un cycle
  -- d'horloge
  -- 
  -- ValueSelect le signal de controle.
  -----------------------------------------------------------------------------

  MOUT : nbitmux8to1
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_A => int_PC,
    i_B => int_ALUResult,
    i_C => int_data1,
    i_D => int_data2,
    i_E => int_RegWriteData,
    i_F => gnd & gnd & gnd & gnd &
	 gnd & gnd & gnd & gnd &
	 gnd & gnd & gnd & gnd &
	 gnd & gnd & gnd & gnd &
	 gnd & int_instr(25 downto 21)& int_instr(20 downto 16) & int_writeReg,
    i_G => (others => '0'),
    i_H => int_branchAddr,
    i_SEL => ValueSelect,
    o_q => MuxOut
  );
  
  -----------------------------------------------------------------------------
  -- Instantiation des composants de memoire
  -- 
  -- ROM + RAM
  -----------------------------------------------------------------------------
  
  --int_RAMWrite <= memClock AND int_MemWrite;
  
  RAM : RAM_1_port_lab2
  PORT MAP(
    address => int_ALUResult(7 downto 0),
	 clock => memClock,
	 data => int_data2,
	 wren => int_MemWrite,
	 q => int_MemData
	);
	 
  
  ROM: ROM_1_port_lab2
  PORT MAP(
	 address => int_PC(9 downto 2),
	 clock => memClock,
	 q => int_instr
  );
  
  
  -----------------------------------------------------------------------------
  -- Chemin de donnees pour l'adresse du prochain instruction.
  -- 
  -- Signaux de controles:
  --	int_branch : decision de branchement
  --	int_jump : signal du CP
  -- Signaux de donnees:
  --	int_extendedAddr : 16 bit de l'instruction sign extended
  --	int_branchAddr : addresse de branchement
  --	int_branchOffset : adresse de branchement SHL de 2 bit
  --	int_jumpAddr : addresse de destination du JUMP
  --	int_PC : addresse stocke dans le registre PC
  --	int_PC4 : addresse PC + 4
  -- Composant :
  --	PC : Registre PC
  --	PC4 : additioneur a 32 bit, pc + 4
  --	SE : extension du signe
  --	BranchADDR : additionneur a 32 bit, int_PC4 + int_extendedAddr
  -----------------------------------------------------------------------------  
  -- SIGNAUX
  int_branch <= (int_beq AND int_zero) OR (int_bneq AND NOT int_zero);
  int_jumpAddr <= int_PC4(31 downto 28) & int_instr(25 downto 0) & gnd & gnd;
  int_branchOffset <= int_extendedAddr(29 downto 0) & gnd & gnd;
  
  -- chemin de controle
  MuxBRANCH : nbitmux2to1
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_A => int_PC4,
    i_B => int_branchAddr,
    i_SEL => int_branch,
    o_q => int_addrmux1
  );
  
  MuxJUMP : nbitmux2to1
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_A => int_addrmux1,
    i_B => int_jumpAddr,
    i_SEL => int_jump,
    o_q => int_addrmux2
  );
  
  -- Composants de base
  PC : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => i_enable,
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
  
  SE : signExtend16to32bit
  PORT MAP(
    i_v => int_instr(15 downto 0),
	 o_v => int_extendedAddr
  );
  
  
  BranchADDR : nbitAdder
  GENERIC MAP( n => 32 )
  PORT MAP(
    i_A => int_PC4,
    i_B => int_branchOffset,
    i_Carry_in => gnd,
    o_Carry_out => open,
    o_Sum => int_branchAddr
  );
  
  
  
  
  

  -----------------------------------------------------------------------------
  -- Unite de controle
  ----------------------------------------------------------------------------- 
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
  
  
  -----------------------------------------------------------------------------
  -- COMPOSANTS ALU
  --
  -- SIGNAUX:
  --	int_dataB : Signal de l'entree B de l'ALU
  --	int_ALU_SEL : operation de l'ALU a effectue
  --	int_ALU_SRC : selection de la source pour l'entree B
  --	int_ALUResult : Resultat de l'operation
  --	int_zero : signal de statut
  -- COMPOSANTS:
  --	ALU_OP: Decode les signaux du CP et du champ de fonction pour
  --			selectionner l'operation a effectue
  --	ALU : unite ALU de taille generique (32 bit)
  --	MuxALUB : multiplexeur qui controle l'entree B de l'ALU
  -----------------------------------------------------------------------------
  ALU_OP : ALU_CP
  PORT MAP(
    i_ALUop0 => int_ALUop0,
    i_ALUop1 => int_ALUop1,
    i_Function => int_instr(3 downto 0),
    o_op => int_ALU_SEL
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

  MuxALUB : nbitmux2to1
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_A => int_data2,
    i_B => int_extendedAddr,
    i_SEL => int_ALUSrc,
    o_q => int_dataB
  );
  
  
  
  
  
  -----------------------------------------------------------------------------
  -- Table de registre disponible au CPU
  ----------------------------------------------------------------------------- 
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
  
  
  
  

  -----------------------------------------------------------------------------
  -- Controle du registre destination et si on y ecrit. 
  --
  -- SIGNAUX:
  --	int_MemtoReg : WriteData provient de la memoire
  --	int_RegDst : Registre de destination est rd
  -- COMPOSANTS:
  --	MUXWD : WD provient de la memoire ou l'ALU
  --	MUXWREG : RegWrite est rd ou rt
  -----------------------------------------------------------------------------
  
  MuxWD : nbitmux2to1
  GENERIC MAP( size =>32)
  PORT MAP(
    i_A => int_ALUResult,
    i_B => int_MemData,
    i_SEL => int_MemtoReg,
    o_q => int_RegWriteData
  );
  
  MuxWREG : nbitmux2to1
  GENERIC MAP( size => 5 )
  PORT MAP(
    i_A => int_instr(20 downto 16),
    i_B => int_instr(15 downto 11),
    i_SEL => int_RegDst,
    o_q => int_WriteReg
  );
  
  
  

  
  
  -- valeurs pour les signaux constants
  gnd <= '0';
  int_4 <= x"00000004";
  hot <= '1';
  
  -- signaux de sorties
  InstructionOut <= int_instr;
  ZeroOut <= int_zero;
  MemWriteOut <= int_MemWrite;
  BranchOut <= int_branch OR int_Jump;
  RegWriteOut <= int_RegWrite;
  
END struct;
