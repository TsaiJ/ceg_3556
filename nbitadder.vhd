--------------------------------------------------------------------------------
-- Titre         : Additioneur generique
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : nbitadder.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un additioneur a propagation generique de taille n.
--    On peut selectionner la taille de l'additionneur quand on instancie le composant
--    dans une architecture.
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nBitAdder IS
  GENERIC( n : INTEGER := 1 );
  PORT (
  i_A, i_B : IN std_logic_vector( n-1 downto 0);
  i_Carry_in : IN std_logic;
  o_Carry_out : OUT std_logic;
  o_Sum : OUT STD_LOGIC_VECTOR(n-1 downto 0));
END nBitAdder;

ARCHITECTURE struct OF nBitAdder IS
  
  SIGNAL s_Carry : STD_LOGIC_VECTOR(n-1 downto 0);
  
  COMPONENT oneBitAdder IS
    PORT(
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
  END COMPONENT;
  
BEGIN
  
  GEN_ADD: FOR I IN 0 to n-1 generate
    
    LSB : IF I = 0 generate
      U0 : oneBitAdder PORT MAP (
        i_Carry_in, i_A(I), i_B(I), o_Sum(I), s_Carry(I));
    END GENERATE LSB;
      
    OB : IF I > 0 GENERATE 
      UX: oneBitAdder PORT MAP (
        S_Carry(I-1), i_A(I), i_B(I), o_Sum(I), s_Carry(I));
    END GENERATE OB;
    
  END GENERATE GEN_ADD;
  
  o_Carry_out <= S_Carry(n-1);
  
END ARCHITECTURE;
      