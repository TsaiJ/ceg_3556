--------------------------------------------------------------------------------
-- Titre         : Demultiplexeur 8 a 1 de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitdemux8to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un demultiplexeur de 8 entrees pour un bit
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitdemux8to1 IS
  PORT(
    i_in : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2 : IN STD_LOGIC;
    o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7 : OUT STD_LOGIC
  );
END onebitdemux8to1;

ARCHITECTURE struct OF onebitdemux8to1 IS
  
BEGIN
  
  o_0 <= i_in AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_1 <= i_in AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_2 <= i_in AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_3 <= i_in AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  o_4 <= i_in AND i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_5 <= i_in AND i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_6 <= i_in AND i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_7 <= i_in AND i_SEL2 AND  i_SEL1 AND  i_SEL0;
    
END struct;







