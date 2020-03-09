--------------------------------------------------------------------------------
-- Titre         : Registre de taille generique
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitregister.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un registre de taille aleatoire.
--    Sa taille est decide quand le composant est instancie dans une autre
--    architecture.
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nbitregister IS
  GENERIC( size : integer := 4);
	PORT(
		i_load	: IN	STD_LOGIC;
		i_rstBar : IN STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(size-1 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(size-1 downto 0);
		o_ValueBar : OUT STD_LOGIC_VECTOR(size-1 downto 0));
END nbitregister;

ARCHITECTURE struct OF nbitregister IS
  SIGNAL int_Value, int_notValue, int_Mux : STD_LOGIC_VECTOR(size-1 downto 0);
  
  COMPONENT res_dFF
    PORT(
      i_d : IN STD_LOGIC;
      i_rstBar : IN STD_LOGIC;
      i_clock : IN STD_LOGIC;
      o_q, o_qBar : OUT STD_LOGIC);
  END COMPONENT;
  
  
  COMPONENT nbitmux2to1
    GENERIC ( size : INTEGER := 1);
    PORT(
      i_A, i_B : IN STD_LOGIC_VECTOR(size-1 downto 0);
      i_SEL : IN STD_LOGIC;
      o_q : OUT STD_LOGIC_VECTOR(size-1 downto 0)
    );
  END COMPONENT;
  
BEGIN
  
  -- multiplexeur pour chaque bit
  -- SEL = 1 , prend i_B = i_Value
  -- SEL = 0, maintient la valeur courante
    MUX : nbitmux2to1
    GENERIC MAP( size => size )
    PORT MAP (
      i_A => int_Value,
      i_B => i_Value,
      i_SEL => i_load,
      o_q => int_Mux
    );
  
  
  -- Flip flop D pour chaque bit
  GEN_D : FOR I IN 0 TO size-1 GENERATE
    BX : res_dFF PORT MAP(
      i_d => int_Mux(I),
      i_rstBar => i_rstBar,
      i_clock => i_clock,
      o_q => int_value(I),
      o_qBar => int_notValue(I)
    );
  END GENERATE GEN_D;

  
  -- signaux concurents
  o_value <= int_Value;
  o_valueBar <= int_notValue;
END struct;

