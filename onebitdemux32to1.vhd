--------------------------------------------------------------------------------
-- Titre         : Demultiplexeur 32 a 1 de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitdemux32to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un demultiplexeur de 32 entrees pour un bit
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitdemux32to1 IS
  PORT(
    i_in : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2, i_SEL3, i_SEL4 : IN STD_LOGIC;
    o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7,
    o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
    o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23,
    o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31 : OUT STD_LOGIC
  );
END onebitdemux32to1;

ARCHITECTURE struct OF onebitdemux32to1 IS
  
BEGIN
  
  o_0 <= i_in AND NOT i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_1 <= i_in AND NOT i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_2 <= i_in AND NOT i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_3 <= i_in AND NOT i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  o_4 <= i_in AND NOT i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_5 <= i_in AND NOT i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_6 <= i_in AND NOT i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_7 <= i_in AND NOT i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND  i_SEL1 AND  i_SEL0;
  o_8 <= i_in AND NOT i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_9 <= i_in AND NOT i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_10 <= i_in AND NOT i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_11 <= i_in AND NOT i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  o_12 <= i_in AND NOT i_SEL4 AND  i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_13 <= i_in AND NOT i_SEL4 AND  i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_14 <= i_in AND NOT i_SEL4 AND  i_SEL3 AND  i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_15 <= i_in AND NOT i_SEL4 AND  i_SEL3 AND  i_SEL2 AND  i_SEL1 AND  i_SEL0;
  o_16 <= i_in AND  i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_17 <= i_in AND  i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_18 <= i_in AND  i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_19 <= i_in AND  i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  o_20 <= i_in AND  i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_21 <= i_in AND  i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_22 <= i_in AND  i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_23 <= i_in AND  i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND  i_SEL1 AND  i_SEL0;
  o_24 <= i_in AND  i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_25 <= i_in AND  i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_26 <= i_in AND  i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_27 <= i_in AND  i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  o_28 <= i_in AND  i_SEL4 AND  i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  o_29 <= i_in AND  i_SEL4 AND  i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  o_30 <= i_in AND  i_SEL4 AND  i_SEL3 AND  i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  o_31 <= i_in AND  i_SEL4 AND  i_SEL3 AND  i_SEL2 AND  i_SEL1 AND  i_SEL0;
  
END struct;





