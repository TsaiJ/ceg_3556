--------------------------------------------------------------------------------
-- Titre         : Registre a 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitregister.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un registre de taille 1 bit.
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY oneBitRegister IS
	PORT(
		i_load	: IN	STD_LOGIC;
		i_rstBar : IN STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC
		);
END oneBitRegister;

ARCHITECTURE struct OF oneBitRegister IS
  SIGNAL int_Value, int_notValue, int_d : STD_LOGIC;
  
  COMPONENT res_dFF
    PORT(
      i_d : IN STD_LOGIC;
      i_rstBar : IN STD_LOGIC;
      i_clock : IN STD_LOGIC;
      o_q, o_qBar : OUT STD_LOGIC);
  END COMPONENT;
  
  
BEGIN
  
  int_d <= (int_value AND NOT i_load) OR (i_value AND i_load);
  
  reg: res_dFF PORT MAP(
      i_d => int_d,
      i_rstBar => i_rstBar,
      i_clock => i_clock,
      o_q => int_value,
      o_qBar => int_notValue
    );
  
  -- signaux concurents
  o_value <= int_Value;
  
END struct;

