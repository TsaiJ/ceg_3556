LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY TB_onebitmux32 IS
END TB_onebitmux32;

ARCHITECTURE test OF TB_onebitmux32 IS
  
  SIGNAL int_input : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_sel : STD_LOGIC_VECTOR(4 downto 0);
  SIGNAL int_out : STD_LOGIC;
  
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
  
  UUT: onebitmux32to1 
  PORT MAP(
    i_0 => int_input(0),
    i_1 => int_input(1),
    i_2 => int_input(2),
    i_3 => int_input(3),
    i_4 => int_input(4),
    i_5 => int_input(5),
    i_6 => int_input(6),
    i_7 => int_input(7),
    i_8 => int_input(8),
    i_9 => int_input(9),
    i_10 => int_input(10),
    i_11 => int_input(11),
    i_12 => int_input(12),
    i_13 => int_input(13),
    i_14 => int_input(14),
    i_15 => int_input(15),
    i_16 => int_input(16),
    i_17 => int_input(17),
    i_18 => int_input(18),
    i_19 => int_input(19),
    i_20 => int_input(20),
    i_21 => int_input(21),
    i_22 => int_input(22),
    i_23 => int_input(23),
    i_24 => int_input(24),
    i_25 => int_input(25),
    i_26 => int_input(26),
    i_27 => int_input(27),
    i_28 => int_input(28),
    i_29 => int_input(29),
    i_30 => int_input(30),
    i_31 => int_input(31),
    i_SEL0 => int_sel(0),
    i_SEL1 => int_sel(1),
    i_SEL2 => int_sel(2),
    i_SEL3 => int_sel(3),
    i_SEL4 => int_sel(4),
    o_q => int_out
  );
  
  
  gen_sel: PROCESS
  BEGIN
    int_sel <= "00000";
    FOR I IN 0 TO 31 LOOP
      WAIT FOR 40 ns;
      int_sel <= int_sel + 1;
    END LOOP;
    WAIT;
  END PROCESS;
  
  gen_v : PROCESS
  BEGIN
    int_input <= x"00000001";
    FOR I IN 0 to 31 LOOP
      wait for 20 ns;
      int_input <= int_input(30 downto 0) & int_input(31);
      wait for 20 ns;
    END LOOP;
    wait;
  END PROCESS gen_v;

END test;

