--------------------------------------------------------------------------------
-- Titre         : Bascule Type D a reset asynchrone
-- Projet        : CEG3556 Lab 1
-------------------------------------------------------------------------------
-- Fichier       : res_dFF.vhd
-- Auteur        : Jeremie Tsai <jtsai033@uottawa.ca
--                 Sadeck Yarou N'Gobi <syaro061@uottawa.ca>
--------------------------------------------------------------------------------
-- Description : Ce fichier cree une bascule enable
--    possedant la table de verite suivante
--
--  +----------+-----+-----+------+-----+------+
--  | i_rstBar | CLK |  D  |i_load|  Q  |  Qn  |
--  +----------+-----+-----+------+-----+------+
--  |     1    |  ?  |  0  |   0  |  Q  |  Qn  |
--  |     1    |  ?  |  0  |   1  |  0  |  1   |
--  |     1    |  ?  |  1  |   0  |  Q  |  Qn  |
--  |     1    |  ?  |  1  |   1  |  1  |  0   | 
--  +----------+-----+-----+------+-----+------+
--  |     0    |  ?  |  x  |   x  |  0  |  1   |
--  +----------+-----+-----+------+-----+------+
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY res_dff IS
	PORT(
		i_d, i_rstBar, i_clock : IN STD_LOGIC;
		o_q, o_qbar : out STD_LOGIC
	);
END res_dff;

ARCHITECTURE struct OF res_dff IS
	SIGNAL int_d, int_q : STD_LOGIC;
	SIGNAL int_notClock, int_clock : STD_LOGIC;
	
	COMPONENT d_latch IS
		PORT(
			i_d : IN STD_LOGIC;
			i_e : IN STD_LOGIC;
			o_q, o_qbar : OUT STD_LOGIC
		);
	END COMPONENT;
	
BEGIN

	master : d_latch
	PORT MAP(
		i_d => int_d,
		i_e => int_notClock,
		o_q => int_q,
		o_qbar => open
	);
	
	slave : d_latch
	PORT MAP(
		i_d => int_q,
		i_e => int_clock,
		o_q => o_q,
		o_qbar => o_qbar
	);
	
	int_notClock <= NOT i_clock;
	int_clock <= NOT int_notClock;
	int_d <= i_d AND i_rstBar;
	
END struct;

