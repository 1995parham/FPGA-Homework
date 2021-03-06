--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   22-05-2016
-- Module Name:   main.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity main is
	port (DDR_addr : inout STD_LOGIC_VECTOR (14 downto 0);
		DDR_ba : inout STD_LOGIC_VECTOR (2 downto 0);
		DDR_cas_n : inout STD_LOGIC;
		DDR_ck_n : inout STD_LOGIC;
		DDR_ck_p : inout STD_LOGIC;
		DDR_cke : inout STD_LOGIC;
		DDR_cs_n : inout STD_LOGIC;
		DDR_dm : inout STD_LOGIC_VECTOR (3 downto 0);
		DDR_dq : inout STD_LOGIC_VECTOR (31 downto 0);
		DDR_dqs_n : inout STD_LOGIC_VECTOR (3 downto 0);
		DDR_dqs_p : inout STD_LOGIC_VECTOR (3 downto 0);
		DDR_odt : inout STD_LOGIC;
		DDR_ras_n : inout STD_LOGIC;
		DDR_reset_n : inout STD_LOGIC;
		DDR_we_n : inout STD_LOGIC;
		FIXED_IO_ddr_vrn : inout STD_LOGIC;
		FIXED_IO_ddr_vrp : inout STD_LOGIC;
		FIXED_IO_mio : inout STD_LOGIC_VECTOR (53 downto 0);
		FIXED_IO_ps_clk : inout STD_LOGIC;
		FIXED_IO_ps_porb : inout STD_LOGIC;
		FIXED_IO_ps_srstb : inout STD_LOGIC;
		FSM_clk : in std_logic);
end entity;

architecture structural of main is
	component FSM is
		port (start_state : in std_logic_vector(3 downto 0);
			end_state : out std_logic_vector(3 downto 0);
			str : in std_logic_vector(31 downto 0);
			enable, clk : in std_logic;
			done : out std_logic);
	end component;
	component base_zynq_design_wrapper
		port (DDR_addr : inout STD_LOGIC_VECTOR (14 downto 0);
			DDR_ba : inout STD_LOGIC_VECTOR (2 downto 0);
		      	DDR_cas_n : inout STD_LOGIC;
			DDR_ck_n : inout STD_LOGIC;
		     	DDR_ck_p : inout STD_LOGIC;
		     	DDR_cke : inout STD_LOGIC;
		     	DDR_cs_n : inout STD_LOGIC;
		     	DDR_dm : inout STD_LOGIC_VECTOR (3 downto 0);
		     	DDR_dq : inout STD_LOGIC_VECTOR (31 downto 0);
		     	DDR_dqs_n : inout STD_LOGIC_VECTOR (3 downto 0);
		     	DDR_dqs_p : inout STD_LOGIC_VECTOR (3 downto 0);
		     	DDR_odt : inout STD_LOGIC;
		     	DDR_ras_n : inout STD_LOGIC;
		     	DDR_reset_n : inout STD_LOGIC;
		     	DDR_we_n : inout STD_LOGIC;
		     	FIXED_IO_ddr_vrn : inout STD_LOGIC;
		     	FIXED_IO_ddr_vrp : inout STD_LOGIC;
		     	FIXED_IO_mio : inout STD_LOGIC_VECTOR (53 downto 0);
		     	FIXED_IO_ps_clk : inout STD_LOGIC;
		     	FIXED_IO_ps_porb : inout STD_LOGIC;
		     	FIXED_IO_ps_srstb : inout STD_LOGIC;
		     	gpio_rtl_0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
		     	gpio_rtl_1_i : in STD_LOGIC_VECTOR ( 9 downto 0 );
		     	gpio_rtl_1_o : out STD_LOGIC_VECTOR ( 9 downto 0 ));
	end component;

	signal gpio_rtl_1_i : std_logic_vector (9 downto 0);
	signal gpio_rtl_1_o : std_logic_vector (9 downto 0);
	signal gpio_rtl_0 : std_logic_vector (31 downto 0);
	
	signal start_state, end_state : std_logic_vector (3 downto 0);
	signal str : std_logic_vector (31 downto 0);
	signal enable : std_logic;
	signal done : std_logic;
begin
	start_state <= gpio_rtl_1_o (3 downto 0);
	gpio_rtl_1_i (8 downto 5) <= end_state;
	str <= gpio_rtl_0;
	enable <= gpio_rtl_1_o (4);
	gpio_rtl_1_i (9) <= done;
	
	FSM_i: component FSM
		port map (start_state, end_state, str, enable, FSM_clk, done);
	base_zynq_design_wrapper_i: component base_zynq_design_wrapper
		port map (DDR_addr, DDR_ba, DDR_cas_n, DDR_ck_n, DDR_ck_p, DDR_cke, DDR_cs_n,
			DDR_dm, DDR_dq, DDR_dqs_n, DDR_dqs_p, DDR_odt, DDR_ras_n,
			DDR_reset_n, DDR_we_n, FIXED_IO_ddr_vrn, FIXED_IO_ddr_vrp, FIXED_IO_mio,
			FIXED_IO_ps_clk, FIXED_IO_ps_porb, FIXED_IO_ps_srstb, gpio_rtl_0, gpio_rtl_1_i, gpio_rtl_1_o);
end architecture;
