--------------------------------------------------------------------------------
-- Titre         : Multplexeur 2 a 1 de valeur binaire de taille generique
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : nmux2to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un multiplexeur de 2 a 1 pour une valeur binaire
--    de taille arbitraire, celle-ci sera choise a l'instanciation du composant
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nbitmux2to1 IS
  GENERIC( size : integer := 1 );
  PORT(
    i_A, i_B : IN STD_LOGIC_VECTOR(size-1 downto 0);
    i_SEL : IN STD_LOGIC;
    o_q : OUT STD_LOGIC_VECTOR(size-1 downto 0)
  );
END nbitmux2to1;

ARCHITECTURE struct OF nbitmux2to1 IS
  
  SIGNAL int_A, int_B : STD_LOGIC_VECTOR(size-1 downto 0);
  
  COMPONENT onebitmux2to1 IS
    PORT(
      i_A, i_B : IN STD_LOGIC;
      i_SEL : IN STD_LOGIC;
      o_q : OUT STD_LOGIC
    );
  END COMPONENT;
  
BEGIN
  
  gen_mux : FOR I IN 0 TO size-1 GENERATE
    MX : onebitmux2to1
    PORT MAP(
      i_A => i_A(I),
      i_B => i_B(I),
      i_SEL => i_SEL,
      o_q => o_q(I)
    );
  END GENERATE gen_mux;

  
END struct;
