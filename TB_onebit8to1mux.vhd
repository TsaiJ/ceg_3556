LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY TB_onebitmux8 IS
END TB_onebitmux8;

ARCHITECTURE test OF TB_onebitmux8 IS
  
  SIGNAL int_value : STD_LOGIC_VECTOR(7 downto 0);
  SIGNAL int_sel : STD_LOGIC_VECTOR(2 downto 0);
  SIGNAL int_out : STD_LOGIC;
  
  COMPONENT onebitmux8to1 IS
  PORT(
    i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H : IN STD_LOGIC;
    i_SEL0, i_SEL1, i_SEL2 : IN STD_LOGIC;
    o_q : OUT STD_LOGIC
  );
  END COMPONENT;
  
BEGIN
  
  UUT: onebitmux8to1 
  PORT MAP(
    i_A => int_value(0),
    i_B => int_value(1),
    i_C => int_value(2),
    i_D => int_value(3),
    i_E => int_value(4),
    i_F => int_value(5),
    i_G => int_value(6),
    i_H => int_value(7),
    i_SEL0 => int_sel(0),
    i_SEL1 => int_sel(1),
    i_SEL2 => int_sel(2),
    o_q => int_out
  );
  
  
  gen_sel: PROCESS
  BEGIN
    int_sel <= "000";
    FOR I IN 0 TO 7 LOOP
      WAIT FOR 40 ns;
      int_sel <= int_sel + 1;
    END LOOP;
    WAIT;
  END PROCESS;
  
  gen_v : PROCESS
  BEGIN
    int_value <= x"00";
    wait for 20 ns;
    int_value <= x"01";
    wait for 20 ns;
    int_value <= x"00";
    wait for 20 ns;
    int_value <= x"02";
    wait for 20 ns;
    int_value <= x"00";
    wait for 20 ns;
    int_value <= x"04";
    wait for 20 ns;
    int_value <= x"00";
    wait for 20 ns;
    int_value <= x"08";
    wait for 20 ns;
    int_value <= x"00";
    wait for 20 ns;
    int_value <= x"10";
    wait for 20 ns;
    int_value <= x"00";
    wait for 20 ns;
    int_value <= x"20";
    wait for 20 ns;
    int_value <= x"00";
    wait for 20 ns;
    int_value <= x"40";
    wait for 20 ns;
    int_value <= x"00";
    wait for 20 ns;
    int_value <= x"80";
    wait for 20 ns;
    wait;
  END PROCESS gen_v;

END test;