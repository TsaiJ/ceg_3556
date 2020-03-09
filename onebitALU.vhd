--------------------------------------------------------------------------------
-- Titre         : Alu de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitALU.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree une unite d'arithmetique logique avec les
--    operatiosn suivantes
--    000 : AND
--    001 : OR
--    010 : ADD
--    110 : SUB
--    111 : SLT
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitALU IS
  PORT(
    i_op : IN STD_LOGIC_VECTOR(2 downto 0);
    i_Ai, i_Bi, i_Cin : IN STD_LOGIC;
    i_less : IN STD_LOGIC;
    o_Cout, o_Sum, o_Set : OUT STD_LOGIC
  );
END onebitALU;

ARCHITECTURE struct OF oneBitALU IS
  
  SIGNAL int_and, int_or, int_Sum: STD_LOGIC;
  SIGNAL int_Bi, int_BiBar : STD_LOGIC;
  SIGNAL int_invertB : STD_LOGIC;
  SIGNAL int_sel0, int_sel1 : STD_LOGIC;
  
  
  COMPONENT onebitmux4to1 IS
    PORT(
      i_A, i_B, i_C, i_D : IN STD_LOGIC;
      i_SEL0, i_SEL1 : IN STD_LOGIC;
      o_q : OUT STD_LOGIC
    );
  END COMPONENT;
      
  
  COMPONENT onebitmux2to1 IS
    PORT(
      i_A, i_B : IN STD_LOGIC;
      i_SEL : IN STD_LOGIC;
      o_q : OUT STD_LOGIC
    );
  END COMPONENT;
  
  COMPONENT oneBitAdder IS
    PORT(
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
  END COMPONENT;
  
BEGIN
  
  int_invertB <= i_op(2) AND i_op(1);
  
  INVERTB : onebitmux2to1
  PORT MAP(
    i_A => i_Bi,
    i_B => int_BiBar,
    i_SEL => int_invertB,
    o_q => int_Bi
  );
  
  ADD: onebitadder
  PORT MAP(
    i_Ai => i_Ai,
    i_Bi => int_Bi,
    i_CarryIn => i_Cin,
    o_Sum => int_Sum,
    o_CarryOut => o_Cout
  );
  
  int_BiBar <= not i_Bi;
  int_and <= i_Ai AND i_Bi;
  int_or <= i_Ai OR i_Bi;
  
  MUX: onebitmux4to1
  PORT MAP(
    i_A => int_and,
    i_B => int_or,
    i_C => int_Sum,
    i_D => i_less,
    i_SEL0 => int_sel0,
    i_SEL1 => int_sel1,
    o_q => o_Sum
  );
  
  o_Set <= int_Sum;
  int_sel1 <= i_op(1);
  int_sel0 <= i_op(0);
  
END struct;