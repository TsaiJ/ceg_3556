--------------------------------------------------------------------------------
-- Titre         : Demultiplexeur 2 a 1 de taille 1 bit
-- Projet        : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- Fichier       : onebitdemux2to1.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca>
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree un demultiplexeur de 2 entrees pour un bit
--    L'implementation est realise en style structurel
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitdemux2to1 IS
  PORT(
    i_in : IN STD_LOGIC;
    i_SEL : IN STD_LOGIC;
    o_A, o_B : OUT STD_LOGIC
  );
END onebitdemux2to1;

ARCHITECTURE struct OF onebitdemux2to1 IS
  
BEGIN
  
  o_A <= i_in AND NOT i_SEL;
  o_B <= i_in AND i_SEL;
  
END struct;

