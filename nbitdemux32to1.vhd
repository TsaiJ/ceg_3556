--------------------------------------------------------------------------------
-- Titre         : Demultiplexeur 2 a 1 de valeur binaire de taille generique
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : nbitdemux2to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un demultiplexeur de 2 a 1 pour une valeur binaire
--    de taille arbitraire, celle-ci sera choise a l'instanciation du composant
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nbitdemux32to1 IS
  GENERIC( size : integer := 1 );
  PORT(
    i_in : IN STD_LOGIC_VECTOR(size-1 downto 0);
    i_SEL : IN STD_LOGIC_VECTOR(4 downto 0);
    o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7,
    o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
    o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23,
    o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31 : OUT STD_LOGIC_VECTOR(31 downto 0)
  );
END nbitdemux32to1;

ARCHITECTURE struct OF nbitdemux32to1 IS
  
  COMPONENT onebitdemux32to1 IS
  PORT(
    i_in : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2, i_SEL3, i_SEL4 : IN STD_LOGIC;
    o_0, o_1, o_2, o_3, o_4, o_5, o_6, o_7,
    o_8, o_9, o_10, o_11, o_12, o_13, o_14, o_15,
    o_16, o_17, o_18, o_19, o_20, o_21, o_22, o_23,
    o_24, o_25, o_26, o_27, o_28, o_29, o_30, o_31 : OUT STD_LOGIC
  );
  END COMPONENT;
  
BEGIN
  
  gen_demux : FOR I IN 0 TO size-1 GENERATE
    MX : onebitdemux32to1
    PORT MAP(
      o_0 => o_0(I),
      o_1 => o_1(I),
      o_2 => o_2(I),
      o_3 => o_3(I),
      o_4 => o_4(I),
      o_5 => o_5(I),
      o_6 => o_6(I),
      o_7 => o_7(I),
      o_8 => o_8(I),
      o_9 => o_9(I),
      o_10 => o_10(I),
      o_11 => o_11(I),
      o_12 => o_12(I),
      o_13 => o_13(I),
      o_14 => o_14(I),
      o_15 => o_15(I),
      o_16 => o_16(I),
      o_17 => o_17(I),
      o_18 => o_18(I),
      o_19 => o_19(I),
      o_20 => o_20(I),
      o_21 => o_21(I),
      o_22 => o_22(I),
      o_23 => o_23(I),
      o_24 => o_24(I),
      o_25 => o_25(I),
      o_26 => o_26(I),
      o_27 => o_27(I),
      o_28 => o_28(I),
      o_29 => o_29(I),
      o_30 => o_30(I),
      o_31 => o_31(I),
      i_SEL0 => i_sel(0),
      i_SEL1 => i_sel(1),
      i_SEL2 => i_sel(2),
      i_SEL3 => i_sel(3),
      i_SEL4 => i_sel(4),
      i_in => i_in(I)
    );
  END GENERATE gen_demux;

  
END struct;


