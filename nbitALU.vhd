--------------------------------------------------------------------------------
-- Titre         : Alu de taille generiqu
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : nbitALU.vhd
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
------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nbitALU IS
  GENERIC( n : INTEGER := 4 );
  PORT(
    i_A, i_B : IN STD_LOGIC_VECTOR(n-1 downto 0);
	  i_Set : IN STD_LOGIC;
    i_op : IN STD_LOGIC_VECTOR(2 downto 0);
    o_Sum : OUT STD_LOGIC_VECTOR(n-1 downto 0);
    o_Zero, o_Set : OUT STD_LOGIC
  );
END ENTITY;

ARCHITECTURE struct OF nbitALU IS
  
  SIGNAL int_ZeroOr, int_Cout, int_Sum : STD_LOGIC_VECTOR(n-1 downto 0);
  SIGNAL int_Cin : STD_LOGIC;
  
  COMPONENT onebitALU  IS
    PORT(
      i_op : IN STD_LOGIC_VECTOR(2 downto 0);
      i_Ai, i_Bi, i_Cin : IN STD_LOGIC;
      i_less : IN STD_LOGIC;
      o_Cout, o_Sum, o_Set : OUT STD_LOGIC
    );
  END COMPONENT;
  
BEGIN
  
  GEN_ALU : FOR I IN 0 TO n-1 GENERATE
    
    LSB : IF (I = 0) GENERATE
      U0 : onebitALU
      PORT MAP(
        i_op => i_op,
        i_Ai => i_A(I),
        i_Bi => i_B(I),
        i_Cin => int_Cin,
        i_less => i_Set,
        o_Cout => int_Cout(I),
        o_Sum => int_Sum(I),
        o_Set => open
      );
    END GENERATE LSB;
    
    OB : IF (I > 0 AND I < n-1) GENERATE
      UX : onebitALU
      PORT MAP(
        i_op => i_op,
        i_Ai => i_A(I),
        i_Bi => i_B(I),
        i_Cin => int_Cout(I-1),
        i_less => '0',
        o_Cout => int_Cout(I),
        o_Sum => int_Sum(I),
        o_Set => open
      );
    END GENERATE OB;
    
    MSB : IF I = n-1 GENERATE
      UN : onebitALU
      PORT MAP(
        i_op => i_op,
        i_Ai => i_A(I),
        i_Bi => i_B(I),
        i_Cin => int_Cout(I-1),
        i_less => '0',
        o_Cout => int_Cout(I),
        o_Sum => int_Sum(I),
        o_Set => o_set
      );
    END GENERATE MSB;
    
  END GENERATE GEN_ALU;
  
  GEN_ZERO : FOR I IN 0 TO n-1 GENERATE
    
    LSB_OR : IF I = 0 GENERATE
      int_ZeroOr(I) <= int_Sum(I);
    END GENERATE LSB_OR;
    
    OB_OR : IF I > 0 GENERATE
      int_ZeroOr(I) <= int_Sum(I) OR int_ZeroOr(I-1);
    END GENERATE OB_OR;
    
  END GENERATE GEN_ZERO;
  
  o_zero <= not int_ZeroOr(n-1);
  o_Sum <= int_sum;
  int_Cin <= i_op(2) AND i_op(1);
  
END ARCHITECTURE;

