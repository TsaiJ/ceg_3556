library IEEE;
use IEEE.Std_Logic_1164.all;

ENTITY top IS
  PORT(
    HEX0, HEX1, HEX2, HEX3,
	 HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0);
	 CLOCK_50 : IN STD_LOGIC;
	 SW : IN STD_LOGIC_VECTOR(15 downto 0);
	 LEDR : OUT STD_LOGIC_VECTOR(15 downto 0);
	 LEDG : OUT STD_LOGIC_VECTOR(3 downto 0);
	 KEY : IN STD_LOGIC_VECTOR(0 downto 0)
  );
END ENTITY;

ARCHITECTURE struct of top IS
  
  SIGNAL clk : STD_LOGIC;
  SIGNAL instruction : STD_LOGIC_VECTOR(31 downto 0);
  SIGNAL mux : STD_LOGIC_VECTOR(31 downto 0);
  
  COMPONENT clk_div IS

	PORT
	(
		clock_25Mhz				: IN	STD_LOGIC;
		clock_1MHz				: OUT	STD_LOGIC;
		clock_100KHz				: OUT	STD_LOGIC;
		clock_10KHz				: OUT	STD_LOGIC;
		clock_1KHz				: OUT	STD_LOGIC;
		clock_100Hz				: OUT	STD_LOGIC;
		clock_10Hz				: OUT	STD_LOGIC;
		clock_1Hz				: OUT	STD_LOGIC);
	
END COMPONENT;
  
  
  
  COMPONENT debouncer IS
  PORT(
    i_raw	: IN	STD_LOGIC;
	 i_clock : IN	STD_LOGIC;
	 o_clean : OUT	STD_LOGIC
  );
	END COMPONENT;
  
  
  COMPONENT CPU32bit IS
    PORT(
      gClock : IN STD_LOGIC;
      gReset : IN STD_LOGIC;
		memClock: IN STD_LOGIC;
		i_enable : IN STD_LOGIC;
	   InstructionOut : OUT STD_LOGIC_VECTOR(31 downto 0);
      ValueSelect: IN STD_LOGIC_VECTOR(2 downto 0);
      MuxOut : OUT STD_LOGIC_VECTOR(31 downto 0);
      BranchOut : OUT STD_LOGIC;
      ZeroOut : OUT STD_LOGIC;
      MemWriteOut : OUT STD_LOGIC ;
      RegWriteOut : OUT STD_LOGIC
    );
  END COMPONENT;
  
  COMPONENT display7seg IS
    PORT(
	  B : in std_logic_vector((3) downto (0));
	  F : out std_logic_vector(6 downto (0))
	);
  END COMPONENT;
  
  
BEGIN

  DIV : clk_div 
	PORT MAP
	(
		clock_25Mhz => CLOCK_50,
		clock_1MHz => open,
		clock_100KHz => open,
		clock_10KHz => open,
		clock_1KHz => open,
		clock_100Hz => open,
		clock_10Hz => open,
		clock_1Hz => clk
	);
  
  
  
  D0 : display7seg
  PORT MAP(
    B => instruction(3 downto 0),
	F => HEX0
  );
  
  D1 : display7seg
  PORT MAP(
    B => instruction(7 downto 4),
	F => HEX1
  );
  
  D2 : display7seg
  PORT MAP(
    B => instruction(11 downto 8),
	F => HEX2
  );
  
  D3 : display7seg
  PORT MAP(
    B => instruction(15 downto 12),
	F => HEX3
  );
  
  D4 : display7seg
  PORT MAP(
    B => instruction(19 downto 16),
	F => HEX4
  );
  
  D5 : display7seg
  PORT MAP(
    B => instruction(23 downto 20),
	F => HEX5
  );
  
  D6 : display7seg
  PORT MAP(
    B => instruction(27 downto 24),
	F => HEX6
  );
  
  D7 : display7seg
  PORT MAP(
    B => instruction(31 downto 28),
	F => HEX7
  );
  

  CPU: CPU32bit 
  PORT MAP(
   gClock => clk,
	gReset => SW(15),
	i_enable => SW(14),
	memClock => CLOCK_50,
	InstructionOut => instruction,
	ValueSelect => SW(2 downto 0),
	MuxOut => mux,
	BranchOut => LEDG(0),
	ZeroOut => LEDG(1),
	MemWriteOut => LEDG(2),
	RegWriteOut => LEDG(3)
  );
  
  LEDR(15 downto 0) <= mux(15 downto 0);
  
END struct; 
  
