--------------------------------------------------------------------------------
-- Titre         : Multplexeur 8 a 1 de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitmux8to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un multiplexeur de 8 entrees pour un bit de 
--    sorties. 
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitmux8to1 IS
  PORT(
    i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2 : IN STD_LOGIC;
    o_q : OUT STD_LOGIC
  );
END onebitmux8to1;

ARCHITECTURE struct OF onebitmux8to1 IS
  
  SIGNAL int_output1, int_output2 : STD_LOGIC;
  
  COMPONENT onebitmux4to1 IS
    PORT(
      i_A, i_B, i_C, i_D : IN STD_LOGIC;
      i_SEL0, i_SEL1 : IN STD_LOGIC;
      o_q : OUT STD_LOGIC
    );
  END COMPONENT;
  
BEGIN
  
  M4to1A : onebitmux4to1
  PORT MAP(
    i_A => i_A, i_B => i_B, i_C => i_C, i_D => i_D,
    i_SEL0 => i_SEL0, i_SEL1 => i_SEL1,
    o_q => int_output1
  );
  
  M4to1B : onebitmux4to1
  PORT MAP(
    i_A => i_E, i_B => i_F, i_C => i_G, i_D => i_H,
    i_SEL0 => i_SEL0, i_SEL1 => i_SEL1,
    o_q => int_output2
  );
  
  o_q <= (int_output1 AND NOT i_SEL2 ) OR ( int_output2 AND i_SEL2);
  
END struct;

