--------------------------------------------------------------------------------
-- Titre         : Multplexeur 4 a 1 de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitmux2to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un multiplexeur de 4 entrees pour un bit
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitmux4to1 IS
  PORT(
    i_A, i_B, i_C, i_D : IN STD_LOGIC;
    i_SEL0, i_SEL1 : IN STD_LOGIC;
    o_q : OUT STD_LOGIC
  );
END onebitmux4to1;

ARCHITECTURE struct OF onebitmux4to1 IS
  
  SIGNAL int_A, int_B, int_C, int_D : STD_LOGIC;
  
BEGIN
  
  int_A <= i_A AND NOT i_SEL0 AND NOT i_SEL1;
  int_B <= i_B AND i_SEL0 AND NOT i_SEL1;
  int_C <= i_C AND NOT i_SEL0 AND i_SEL1;
  int_D <= i_D AND i_SEL0 AND i_SEL1;
  o_q <= int_A OR int_B OR int_C OR int_D;
  
END struct;

