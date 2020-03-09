
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tableDeRegistre IS
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
END tableDeRegistre;

ARCHITECTURE struct OF tableDeRegistre IS
  
  
  -- signaux internes des sorties des registres
  SIGNAL int_reg0_output, int_reg1_output, int_reg2_output, int_reg3_output,
        int_reg4_output, int_reg5_output, int_reg6_output, int_reg7_output,
        int_reg8_output, int_reg9_output, int_reg10_output, int_reg11_output,
        int_reg12_output, int_reg13_output, int_reg14_output, int_reg15_output,
        int_reg16_output, int_reg17_output, int_reg18_output, int_reg19_output,
        int_reg20_output, int_reg21_output, int_reg22_output, int_reg23_output,
        int_reg24_output, int_reg25_output, int_reg26_output, int_reg27_output,
        int_reg28_output, int_reg29_output, int_reg30_output,
        int_reg31_output : STD_LOGIC_VECTOR(31 downto 0);
        
  SIGNAL int_reg0_load, int_reg1_load, int_reg2_load, int_reg3_load, int_reg4_load,
        int_reg5_load, int_reg6_load, int_reg7_load, int_reg8_load, int_reg9_load,
        int_reg10_load, int_reg11_load, int_reg12_load, int_reg13_load, int_reg14_load,
        int_reg15_load, int_reg16_load, int_reg17_load, int_reg18_load, int_reg19_load,
        int_reg20_load, int_reg21_load, int_reg22_load, int_reg23_load, int_reg24_load,
        int_reg25_load, int_reg26_load, int_reg27_load, int_reg28_load, int_reg29_load,
        int_reg30_load, int_reg31_load : STD_LOGIC;
  
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
  
  COMPONENT onebitdemux32to1 IS
  PORT(
    i_in : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2, i_SEL3, i_SEL4 : IN STD_LOGIC;
    o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7,
    o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
    o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23,
    o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31 : OUT STD_LOGIC
  );
  END COMPONENT;
  
  COMPONENT nbitmux32to1 IS
  GENERIC( size : integer := 1 );
  PORT(
    i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7,
    i_8, i_9, i_10, i_11, i_12, i_13, i_14, i_15,
    i_16, i_17, i_18, i_19, i_20, i_21, i_22, i_23,
    i_24, i_25, i_26, i_27, i_28, i_29, i_30, i_31 : IN STD_LOGIC_VECTOR(size-1 downto 0);
    i_SEL : IN STD_LOGIC_VECTOR(4 downto 0);
    o_q : OUT STD_LOGIC_VECTOR(size-1 downto 0)
  );
  END COMPONENT;
  
BEGIN
  
  RR1: nbitmux32to1
  GENERIC MAP ( size => 32)
  PORT MAP(
    i_0 => int_reg0_output,
    i_1 => int_reg1_output,
    i_2 => int_reg2_output,
    i_3 => int_reg3_output,
    i_4 => int_reg4_output,
    i_5 => int_reg5_output,
    i_6 => int_reg6_output,
    i_7 => int_reg7_output,
    i_8 => int_reg8_output,
    i_9 => int_reg9_output,
    i_10 => int_reg10_output,
    i_11 => int_reg11_output,
    i_12 => int_reg12_output,
    i_13 => int_reg13_output,
    i_14 => int_reg14_output,
    i_15 => int_reg15_output,
    i_16 => int_reg16_output,
    i_17 => int_reg17_output,
    i_18 => int_reg18_output,
    i_19 => int_reg19_output,
    i_20 => int_reg20_output,
    i_21 => int_reg21_output,
    i_22 => int_reg22_output,
    i_23 => int_reg23_output,
    i_24 => int_reg24_output,
    i_25 => int_reg25_output,
    i_26 => int_reg26_output,
    i_27 => int_reg27_output,
    i_28 => int_reg28_output,
    i_29 => int_reg29_output,
    i_30 => int_reg30_output,
    i_31 => int_reg31_output,
    i_SEL => readReg1,
    o_q => readData1
  );
  
  RR2: nbitmux32to1
  GENERIC MAP ( size => 32)
  PORT MAP(
    i_0 => int_reg0_output,
    i_1 => int_reg1_output,
    i_2 => int_reg2_output,
    i_3 => int_reg3_output,
    i_4 => int_reg4_output,
    i_5 => int_reg5_output,
    i_6 => int_reg6_output,
    i_7 => int_reg7_output,
    i_8 => int_reg8_output,
    i_9 => int_reg9_output,
    i_10 => int_reg10_output,
    i_11 => int_reg11_output,
    i_12 => int_reg12_output,
    i_13 => int_reg13_output,
    i_14 => int_reg14_output,
    i_15 => int_reg15_output,
    i_16 => int_reg16_output,
    i_17 => int_reg17_output,
    i_18 => int_reg18_output,
    i_19 => int_reg19_output,
    i_20 => int_reg20_output,
    i_21 => int_reg21_output,
    i_22 => int_reg22_output,
    i_23 => int_reg23_output,
    i_24 => int_reg24_output,
    i_25 => int_reg25_output,
    i_26 => int_reg26_output,
    i_27 => int_reg27_output,
    i_28 => int_reg28_output,
    i_29 => int_reg29_output,
    i_30 => int_reg30_output,
    i_31 => int_reg31_output,
    i_SEL => readReg2,
    o_q => readData2
  );
  
  DestR : onebitdemux32to1
  PORT MAP(
    o_0 => int_reg0_load,
    o_1 => int_reg1_load,
    o_2 => int_reg2_load,
    o_3 => int_reg3_load,
    o_4 => int_reg4_load,
    o_5 => int_reg5_load,
    o_6 => int_reg6_load,
    o_7 => int_reg7_load,
    o_8 => int_reg8_load,
    o_9 => int_reg9_load,
    o_10 => int_reg10_load,
    o_11 => int_reg11_load,
    o_12 => int_reg12_load,
    o_13 => int_reg13_load,
    o_14 => int_reg14_load,
    o_15 => int_reg15_load,
    o_16 => int_reg16_load,
    o_17 => int_reg17_load,
    o_18 => int_reg18_load,
    o_19 => int_reg19_load,
    o_20 => int_reg20_load,
    o_21 => int_reg21_load,
    o_22 => int_reg22_load,
    o_23 => int_reg23_load,
    o_24 => int_reg24_load,
    o_25 => int_reg25_load,
    o_26 => int_reg26_load,
    o_27 => int_reg27_load,
    o_28 => int_reg28_load,
    o_29 => int_reg29_load,
    o_30 => int_reg30_load,
    o_31 => int_reg31_load,
    i_SEL0 => writeReg(0),
    i_SEL1 => writeReg(1),
    i_SEL2 => writeReg(2),
    i_SEL3 => writeReg(3),
    i_SEL4 => writeReg(4),
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

  R8 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg8_load,
    i_value => writeData,
    o_Value => int_reg8_output,
    o_ValueBar => open
  );

  R9 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg9_load,
    i_value => writeData,
    o_Value => int_reg9_output,
    o_ValueBar => open
  );

  R10 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg10_load,
    i_value => writeData,
    o_Value => int_reg10_output,
    o_ValueBar => open
  );

  R11 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg11_load,
    i_value => writeData,
    o_Value => int_reg11_output,
    o_ValueBar => open
  );

  R12 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg12_load,
    i_value => writeData,
    o_Value => int_reg12_output,
    o_ValueBar => open
  );

  R13 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg13_load,
    i_value => writeData,
    o_Value => int_reg13_output,
    o_ValueBar => open
  );

  R14 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg14_load,
    i_value => writeData,
    o_Value => int_reg14_output,
    o_ValueBar => open
  );

  R15 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg15_load,
    i_value => writeData,
    o_Value => int_reg15_output,
    o_ValueBar => open
  );

  R16 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg16_load,
    i_value => writeData,
    o_Value => int_reg16_output,
    o_ValueBar => open
  );

  R17 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg17_load,
    i_value => writeData,
    o_Value => int_reg17_output,
    o_ValueBar => open
  );

  R18 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg18_load,
    i_value => writeData,
    o_Value => int_reg18_output,
    o_ValueBar => open
  );

  R19 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg19_load,
    i_value => writeData,
    o_Value => int_reg19_output,
    o_ValueBar => open
  );

  R20 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg20_load,
    i_value => writeData,
    o_Value => int_reg20_output,
    o_ValueBar => open
  );

  R21 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg21_load,
    i_value => writeData,
    o_Value => int_reg21_output,
    o_ValueBar => open
  );

  R22 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg22_load,
    i_value => writeData,
    o_Value => int_reg22_output,
    o_ValueBar => open
  );

  R23 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg23_load,
    i_value => writeData,
    o_Value => int_reg23_output,
    o_ValueBar => open
  );

  R24 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg24_load,
    i_value => writeData,
    o_Value => int_reg24_output,
    o_ValueBar => open
  );

  R25 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg25_load,
    i_value => writeData,
    o_Value => int_reg25_output,
    o_ValueBar => open
  );

  R26 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg26_load,
    i_value => writeData,
    o_Value => int_reg26_output,
    o_ValueBar => open
  );

  R27 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg27_load,
    i_value => writeData,
    o_Value => int_reg27_output,
    o_ValueBar => open
  );

  R28 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg28_load,
    i_value => writeData,
    o_Value => int_reg28_output,
    o_ValueBar => open
  );

  R29 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg29_load,
    i_value => writeData,
    o_Value => int_reg29_output,
    o_ValueBar => open
  );

  R30 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg30_load,
    i_value => writeData,
    o_Value => int_reg30_output,
    o_ValueBar => open
  );

  R31 : nbitRegister
  GENERIC MAP( size => 32 )
  PORT MAP(
    i_rstBar => gReset,
    i_clock => gClock,
    i_load => int_reg31_load,
    i_value => writeData,
    o_Value => int_reg31_output,
    o_ValueBar => open
  );
      
  
END struct;