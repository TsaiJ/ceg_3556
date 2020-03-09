--------------------------------------------------------------------------------
-- Titre         : Multplexeur 32 a 1 de valeur binaire de taille generique
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : nmux2to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un multiplexeur de 32 a 1 pour une valeur binaire
--    de taille arbitraire, celle-ci sera choise a l'instanciation du composant
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nbitmux32to1 IS
  GENERIC( size : integer := 1 );
  PORT(
    i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7,
    i_8, i_9, i_10, i_11, i_12, i_13, i_14, i_15,
    i_16, i_17, i_18, i_19, i_20, i_21, i_22, i_23,
    i_24, i_25, i_26, i_27, i_28, i_29, i_30, i_31 : IN STD_LOGIC_VECTOR(size-1 downto 0);
    i_SEL : IN STD_LOGIC_VECTOR(4 downto 0);
    o_q : OUT STD_LOGIC_VECTOR(size-1 downto 0)
  );
END nbitmux32to1;

ARCHITECTURE struct OF nbitmux32to1 IS
  
  SIGNAL int_A, int_B : STD_LOGIC_VECTOR(size-1 downto 0);
  
  COMPONENT onebitmux32to1 IS
  PORT(
    i_0, i_1, i_2, i_3, i_4, i_5, i_6, i_7, i_8,
    i_9, i_10, i_11, i_12, i_13, i_14, i_15,
    i_16, i_17, i_18, i_19, i_20, i_21, i_22, i_23,
    i_24, i_25, i_26, i_27, i_28, i_29, i_30, i_31 : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2, i_SEL3, i_SEL4 : IN STD_LOGIC;
    o_q : OUT STD_LOGIC
  );
  END COMPONENT;
  
BEGIN
  
  gen_mux : FOR I IN 0 TO size-1 GENERATE
    MX : onebitmux32to1
    PORT MAP(
      i_0 => i_0(I),
      i_1 => i_1(I),
      i_2 => i_2(I),
      i_3 => i_3(I),
      i_4 => i_4(I),
      i_5 => i_5(I),
      i_6 => i_6(I),
      i_7 => i_7(I),
      i_8 => i_8(I),
      i_9 => i_9(I),
      i_10 => i_10(I),
      i_11 => i_11(I),
      i_12 => i_12(I),
      i_13 => i_13(I),
      i_14 => i_14(I),
      i_15 => i_15(I),
      i_16 => i_16(I),
      i_17 => i_17(I),
      i_18 => i_18(I),
      i_19 => i_19(I),
      i_20 => i_20(I),
      i_21 => i_21(I),
      i_22 => i_22(I),
      i_23 => i_23(I),
      i_24 => i_24(I),
      i_25 => i_25(I),
      i_26 => i_26(I),
      i_27 => i_27(I),
      i_28 => i_28(I),
      i_29 => i_29(I),
      i_30 => i_30(I),
      i_31 => i_31(I),
      i_SEL0 => i_SEL(0),
      i_SEL1 => i_SEL(1),
      i_SEL2 => i_SEL(2),
      i_SEL3 => i_SEL(3),
      i_SEL4 => i_SEL(4),
      o_q => o_q(I)
    );
  END GENERATE gen_mux;

  
END struct;
