LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY d_latch IS
	PORT(
		i_d : IN STD_LOGIC;
		i_e : IN STD_LOGIC;
		o_q, o_qbar : OUT STD_LOGIC
	);
END d_latch;

ARCHITECTURE struct OF d_latch IS
	
	SIGNAL int_d, int_e : STD_LOGIC;
	SIGNAL int_q, int_qbar : STD_LOGIC;
	
BEGIN
	int_d <= i_d NAND i_e;
	int_e <= int_d NAND i_e;
	int_q <= int_d NAND int_qbar;
	int_qbar <= int_e NAND int_q;
	
	o_q <= int_q;
	o_qbar <= int_qbar;
END struct;