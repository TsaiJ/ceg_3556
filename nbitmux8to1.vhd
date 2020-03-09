--------------------------------------------------------------------------------
-- Titre         : Multplexeur 8 a 1 de valeur binaire de taille generique
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : nmux2to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un multiplexeur de 8 a 1 pour une valeur binaire
--    de taille arbitraire, celle-ci sera choise a l'instanciation du composant
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nbitmux8to1 IS
  GENERIC( size : integer := 1 );
  PORT(
    i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H : IN STD_LOGIC_VECTOR(size-1 downto 0);
    i_SEL : IN STD_LOGIC_VECTOR(2 downto 0);
    o_q : OUT STD_LOGIC_VECTOR(size-1 downto 0)
  );
END nbitmux8to1;

ARCHITECTURE struct OF nbitmux8to1 IS
  
  SIGNAL int_A, int_B : STD_LOGIC_VECTOR(size-1 downto 0);
  
  COMPONENT  onebitmux8to1 IS
    PORT(
      i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H : IN STD_LOGIC;
      i_SEL0, i_SEL1, i_SEL2 : IN STD_LOGIC;
      o_q : OUT STD_LOGIC
    );
  END COMPONENT;
  
BEGIN
  
  gen_mux : FOR I IN 0 TO size-1 GENERATE
    MX : onebitmux8to1
    PORT MAP(
      i_A => i_A(I),
      i_B => i_B(I),
      i_C => i_C(I),
      i_D => i_D(I),
      i_E => i_E(I),
      i_F => i_F(I),
      i_G => i_G(I),
      i_H => i_H(I),
      i_SEL0 => i_SEl(0),
      i_SEL1 => i_SEl(1),
      i_SEL2 => i_SEl(2),
      o_q => o_q(I)
    );
  END GENERATE gen_mux;

  
END struct;


