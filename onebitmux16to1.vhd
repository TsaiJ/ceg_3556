--------------------------------------------------------------------------------
-- Titre         : Multplexeur 16 a 1 de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitmux8to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un multiplexeur de 16 entrees pour un bit de 
--    sorties. 
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitmux16to1 IS
  PORT(
    i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7,
    i_8, i_9, i_10, i_11, i_12, i_13, i_14, i_15 : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2, i_SEL3 : IN STD_LOGIC;
    o_q : OUT STD_LOGIC
  );
END onebitmux16to1;

ARCHITECTURE struct OF onebitmux16to1 IS
  
  SIGNAL int_output1, int_output2 : STD_LOGIC;
  
  COMPONENT onebitmux8to1 IS
    PORT(
      i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H : IN STD_LOGIC;
      i_SEL0, i_SEL1, i_SEL2 : IN STD_LOGIC;
      o_q : OUT STD_LOGIC
    );
  END COMPONENT;
  
BEGIN
  
  M8to1A : onebitmux8to1
  PORT MAP(
    i_A => i_0, i_B => i_1, i_C => i_2, i_D => i_3, i_E => i_4, i_F => i_5, i_G => i_6, i_H => i_7,
    i_SEL0 => i_SEL0, i_SEL1 => i_SEL1, i_SEL2 => i_SEL2,
    o_q => int_output1
  );
  
  M8to1B : onebitmux8to1
  PORT MAP(
    i_A => i_8, i_B => i_9, i_C => i_10, i_D => i_11, i_E => i_12, i_F => i_13, i_G => i_14, i_H => i_15,
    i_SEL0 => i_SEL0, i_SEL1 => i_SEL1, i_SEL2 => i_SEL2,
    o_q => int_output2
  );
  
  o_q <= (int_output1 AND NOT i_SEL3 ) OR ( int_output2 AND i_SEL3);
  
END struct;



