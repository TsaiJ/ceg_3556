
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tableDe8Registre IS
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
END tableDe8Registre;

ARCHITECTURE struct OF tableDe8Registre IS
  
  
  -- signaux internes des sorties des registres
  SIGNAL int_reg0_output, int_reg1_output, int_reg2_output, int_reg3_output,
        int_reg4_output, int_reg5_output, int_reg6_output, int_reg7_output : STD_LOGIC_VECTOR(31 downto 0);
        
  SIGNAL int_reg0_load, int_reg1_load, int_reg2_load, int_reg3_load, int_reg4_load,
        int_reg5_load, int_reg6_load, int_reg7_load : STD_LOGIC;
  
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
  
  COMPONENT onebitdemux8to1 IS
  PORT(
    i_in : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2 : IN STD_LOGIC;
    o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7 : OUT STD_LOGIC
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
  
BEGIN
  
  RR1: nbitmux8to1
  GENERIC MAP ( size => 32)
  PORT MAP(
    i_A => int_reg0_output,
    i_B => int_reg1_output,
    i_C => int_reg2_output,
    i_D => int_reg3_output,
    i_E => int_reg4_output,
    i_F => int_reg5_output,
    i_G => int_reg6_output,
    i_H => int_reg7_output,
    i_SEL => readReg1(2 downto 0),
    o_q => readData1
  );
  
  RR2: nbitmux8to1
  GENERIC MAP ( size => 32)
  PORT MAP(
    i_A => int_reg0_output,
    i_B => int_reg1_output,
    i_C => int_reg2_output,
    i_D => int_reg3_output,
    i_E => int_reg4_output,
    i_F => int_reg5_output,
    i_G => int_reg6_output,
    i_H => int_reg7_output,
    i_SEL => readReg2(2 downto 0),
    o_q => readData2
  );
  
  DestR : onebitdemux8to1
  PORT MAP(
    o_0 => int_reg0_load,
    o_1 => int_reg1_load,
    o_2 => int_reg2_load,
    o_3 => int_reg3_load,
    o_4 => int_reg4_load,
    o_5 => int_reg5_load,
    o_6 => int_reg6_load,
    o_7 => int_reg7_load,
    i_SEL0 => writeReg(0),
    i_SEL1 => writeReg(1),
    i_SEL2 => writeReg(2),
    i_in => RegWrite
  );
  
  R0 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg0_load,
    i_value => writeData,
    o_Value => int_reg0_output,
    o_ValueBar => open
  );

  R1 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg1_load,
    i_value => writeData,
    o_Value => int_reg1_output,
    o_ValueBar => open
  );

  R2 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg2_load,
    i_value => writeData,
    o_Value => int_reg2_output,
    o_ValueBar => open
  );

  R3 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg3_load,
    i_value => writeData,
    o_Value => int_reg3_output,
    o_ValueBar => open
  );

  R4 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg4_load,
    i_value => writeData,
    o_Value => int_reg4_output,
    o_ValueBar => open
  );

  R5 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg5_load,
    i_value => writeData,
    o_Value => int_reg5_output,
    o_ValueBar => open
  );

  R6 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg6_load,
    i_value => writeData,
    o_Value => int_reg6_output,
    o_ValueBar => open
  );

  R7 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg7_load,
    i_value => writeData,
    o_Value => int_reg7_output,
    o_ValueBar => open
  );
  
END struct;

