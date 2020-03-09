--------------------------------------------------------------------------------
-- Titre         : Registre a 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : simple32bitcpu.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier rassemble plusieurs composants pour creer un
--    processeur a cycle simple a 32 bit d'architecture mips avec un 
--    enseble d'instruction reduit
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY simple32bitcpu IS
  PORT(
  );
END ENTITY;

ARCHITECTURE struct OF simple32bitcpu IS
  
  
  COMPONENT tableDeRegistre IS
    PORT(
      readReg1: IN STD_LOGIC_VECTOR(4 downto 0);
      readReg2: IN STD_LOGIC_VECTOR(4 downto 0);
      writeReg: IN STD_LOGIC_VECTOR(4 downto 0);
      writeData : IN STD_LOGIC_VECTOR(31 downto 0);
      readData1: OUT STD_LOGIC_VECTOR(31 downto 0);
      readData2: OUT STD_LOGIC_VECTOR(31 downto 0);
    );
  END COMPONENT;
