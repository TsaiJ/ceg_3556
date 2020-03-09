LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY TB_nbitALU IS
  GENERIC(n : INTEGER := 8);
END TB_nbitALU;

ARCHITECTURE test OF TB_nbitALU IS
  
  SIGNAL int_A, int_B, int_output :STD_LOGIC_VECTOR(n-1 downto 0);
  SIGNAL int_op : STD_LOGIC_VECTOR(2 downto 0);
  SIGNAL int_zero, int_set : STD_LOGIC;
  
  COMPONENT nbitALU IS
    GENERIC( n : INTEGER := 1 );
    PORT(
      i_A, i_B : IN STD_LOGIC_VECTOR(n-1 downto 0);
      i_Set : IN STD_LOGIC;
      i_op : IN STD_LOGIC_VECTOR(2 downto 0);
      o_Sum : OUT STD_LOGIC_VECTOR(n-1 downto 0);
      o_Zero, o_Set : OUT STD_LOGIC
    );
  END COMPONENT;
  
BEGIN
  
  UUT : nbitALU
  GENERIC MAP( n => n)
  PORT MAP(
    i_A => int_A,
    i_B => int_B,
    i_Set => int_set,
    i_op => int_op,
    o_Sum => int_output,
    o_Zero => int_zero,
    o_Set => int_set
  );
  
  proc_op: PROCESS
  BEGIN
    int_A <= x"10";
    int_B <= x"11";
    int_op <= "000";
    wait for 20 ns;
    int_op <= "001";
    wait for 20 ns;
    int_op <= "010";
    wait for 20 ns;
    int_op <= "110";
    wait for 20 ns;
    int_op <= "111";
    wait for 20 ns;
    int_A <= x"12";
    int_B <= x"11";
    wait for 20 ns;
    int_A <= x"12";
    int_B <= x"14";
    wait for 20 ns;
    wait;
  END PROCESS;
    
END ARCHITECTURE;
    
  
