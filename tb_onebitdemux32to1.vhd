LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY TB_onebitdemux32 IS
END TB_onebitdemux32;

ARCHITECTURE test OF TB_onebitdemux32 IS
  
  SIGNAL int_value : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL int_sel : STD_LOGIC_VECTOR(4 downto 0);
  SIGNAL int_in : STD_LOGIC;
  
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
  
  UUT: onebitdemux32to1 
  PORT MAP(
    o_0 => int_value(0),
    o_1 => int_value(1),
    o_2 => int_value(2),
    o_3 => int_value(3),
    o_4 => int_value(4),
    o_5 => int_value(5),
    o_6 => int_value(6),
    o_7 => int_value(7),
    o_8 => int_value(8),
    o_9 => int_value(9),
    o_10 => int_value(10),
    o_11 => int_value(11),
    o_12 => int_value(12),
    o_13 => int_value(13),
    o_14 => int_value(14),
    o_15 => int_value(15),
    o_16 => int_value(16),
    o_17 => int_value(17),
    o_18 => int_value(18),
    o_19 => int_value(19),
    o_20 => int_value(20),
    o_21 => int_value(21),
    o_22 => int_value(22),
    o_23 => int_value(23),
    o_24 => int_value(24),
    o_25 => int_value(25),
    o_26 => int_value(26),
    o_27 => int_value(27),
    o_28 => int_value(28),
    o_29 => int_value(29),
    o_30 => int_value(30),
    o_31 => int_value(31),
    i_SEL0 => int_sel(0),
    i_SEL1 => int_sel(1),
    i_SEL2 => int_sel(2),
    i_SEL3 => int_sel(3),
    i_SEL4 => int_sel(4),
    i_in => int_in
  );
  
  gen_in: PROCESS
  BEGIN
    int_in <= '0';
    FOR I in 0 to 63 LOOP
      wait for 20 ns;
      int_in <= not int_in;
    END LOOP;
    wait;
  END PROCESS;
  
  gen_sel: PROCESS
  BEGIN
    int_sel <= "00000";
    FOR I IN 0 TO 31 LOOP
      WAIT FOR 40 ns;
      int_sel <= int_sel + 1;
    END LOOP;
    WAIT;
  END PROCESS;
  

END test;



