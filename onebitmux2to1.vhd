--------------------------------------------------------------------------------
-- Titre         : Multplexeur 2 a 1 de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitmux2to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un multiplexeur de 2 entrees pour un bit
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitmux2to1 IS
  PORT(
    i_A, i_B : IN STD_LOGIC;
    i_SEL : IN STD_LOGIC;
    o_q : OUT STD_LOGIC
  );
END onebitmux2to1;

ARCHITECTURE struct OF onebitmux2to1 IS
  
  SIGNAL int_A, int_B : STD_LOGIC;
  
BEGIN
  
  int_A <= i_A AND NOT i_SEL;
  int_B <= i_B AND i_SEL;
  o_q <= int_A OR int_B;
  
END struct;