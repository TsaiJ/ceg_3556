--------------------------------------------------------------------------------
-- Titre         : Multplexeur 32 a 1 de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitmux8to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un multiplexeur de 32 entrees pour un bit de 
--    sorties. 
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitmux32to1 IS
  PORT(
    i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7, 
    i_8, i_9, i_10, i_11, i_12, i_13, i_14, i_15,
    i_16, i_17, i_18, i_19, i_20, i_21, i_22, i_23,
    i_24, i_25, i_26, i_27, i_28, i_29, i_30, i_31 : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2, i_SEL3, i_SEL4 : IN STD_LOGIC;
    o_q : OUT STD_LOGIC
  );
END onebitmux32to1;

ARCHITECTURE struct OF onebitmux32to1 IS
  
  SIGNAL int_0, int_1, int_2, int_3, int_4, int_5, int_6, int_7, 
         int_8, int_9, int_10, int_11, int_12, int_13, int_14, int_15, 
         int_16, int_17, int_18, int_19, int_20, int_21, int_22, int_23, 
         int_24, int_25, int_26, int_27, int_28, int_29, int_30, int_31 : STD_LOGIC; 
  
BEGIN
  
  int_0 <= i_0 AND NOT i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  int_1 <= i_1 AND NOT i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  int_2 <= i_2 AND NOT i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  int_3 <= i_3 AND NOT i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  int_4 <= i_4 AND NOT i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  int_5 <= i_5 AND NOT i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  int_6 <= i_6 AND NOT i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  int_7 <= i_7 AND NOT i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND  i_SEL1 AND  i_SEL0;
  int_8 <= i_8 AND NOT i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  int_9 <= i_9 AND NOT i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  int_10 <= i_10 AND NOT i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  int_11 <= i_11 AND NOT i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  int_12 <= i_12 AND NOT i_SEL4 AND  i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  int_13 <= i_13 AND NOT i_SEL4 AND  i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  int_14 <= i_14 AND NOT i_SEL4 AND  i_SEL3 AND  i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  int_15 <= i_15 AND NOT i_SEL4 AND  i_SEL3 AND  i_SEL2 AND  i_SEL1 AND  i_SEL0;
  int_16 <= i_16 AND  i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  int_17 <= i_17 AND  i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  int_18 <= i_18 AND  i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  int_19 <= i_19 AND  i_SEL4 AND NOT i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  int_20 <= i_20 AND  i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  int_21 <= i_21 AND  i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  int_22 <= i_22 AND  i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  int_23 <= i_23 AND  i_SEL4 AND NOT i_SEL3 AND  i_SEL2 AND  i_SEL1 AND  i_SEL0;
  int_24 <= i_24 AND  i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  int_25 <= i_25 AND  i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  int_26 <= i_26 AND  i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  int_27 <= i_27 AND  i_SEL4 AND  i_SEL3 AND NOT i_SEL2 AND  i_SEL1 AND  i_SEL0;
  int_28 <= i_28 AND  i_SEL4 AND  i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND NOT i_SEL0;
  int_29 <= i_29 AND  i_SEL4 AND  i_SEL3 AND  i_SEL2 AND NOT i_SEL1 AND  i_SEL0;
  int_30 <= i_30 AND  i_SEL4 AND  i_SEL3 AND  i_SEL2 AND  i_SEL1 AND NOT i_SEL0;
  int_31 <= i_31 AND  i_SEL4 AND  i_SEL3 AND  i_SEL2 AND  i_SEL1 AND  i_SEL0;
  
  o_q <= int_0 OR int_1 OR int_2 OR int_3 OR int_4 OR int_5 OR int_6 OR int_7 
          OR int_8 OR int_9 OR int_10 OR int_11 OR int_12 OR int_13 OR int_14 OR int_15 
          OR int_16 OR int_17 OR int_18 OR int_19 OR int_20 OR int_21 OR int_22 OR int_23
          OR int_24 OR int_25 OR int_26 OR int_27 OR int_28 OR int_29 OR int_30 OR int_31;
  
END struct;





