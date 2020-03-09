LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY TB_ALU_CP IS
END TB_ALU_CP;

ARCHITECTURE test OF TB_ALU_CP IS
  
  SIGNAL int_ALUop0, int_ALUop1 :STD_LOGIC;
  SIGNAL int_func : STD_LOGIC_VECTOR(3 downto 0);
  SIGNAL int_op : STD_LOGIC_VECTOR(2 downto 0);
  
  COMPONENT ALU_CP IS
    PORT(
      i_ALUop0, i_ALUop1 : IN STD_LOGIC;
      i_Function : IN STD_LOGIC_VECTOR(3 downto 0);
      o_op : OUT STD_LOGIC_VECTOR(2 downto 0)
    );
  END COMPONENT;
  
BEGIN
  
  UUT: ALU_CP
  PORT MAP(
    i_ALUop0 => int_ALUop0,
    i_ALUop1 => int_ALUop1,
    i_Function => int_func,
    o_op => int_op
  );
  
  gen_function: PROCESS
  BEGIN
    int_ALUop0 <= '0';
    int_ALUop1 <= '0';
    int_func <= "0000";
    wait for 10 ns;
    int_func <= "0010";
    wait for 10 ns;
    int_func <= "0100";
    wait for 10 ns;
    int_func <= "0101";
    wait for 10 ns;
    int_func <= "1010";
    wait for 10 ns;
    
    
    int_ALUop0 <= '1';
    int_ALUop1 <= '0';
    int_func <= "0000";
    wait for 10 ns;
    int_func <= "0010";
    wait for 10 ns;
    int_func <= "0100";
    wait for 10 ns;
    int_func <= "0101";
    wait for 10 ns;
    int_func <= "1010";
    wait for 10 ns;
    
    int_ALUop0 <= '0';
    int_ALUop1 <= '1';
    int_func <= "0000";
    wait for 10 ns;
    int_func <= "0010";
    wait for 10 ns;
    int_func <= "0100";
    wait for 10 ns;
    int_func <= "0101";
    wait for 10 ns;
    int_func <= "1010";
    wait for 10 ns;
    WAIT;
  END PROCESS gen_function;

END test;