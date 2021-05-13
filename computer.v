module computer();

wire [7:0] BUS;
reg CLR = 0;

wire HLT;
wire MI;
wire RI;
wire RO;
wire IO;
wire II;
wire AI;
wire AO;
wire EO;
wire SU;
wire BI;
wire BO;
wire OI;
wire CE;
wire CO;
wire J;
wire FI;

initial #1248 $finish;
initial begin
	$dumpfile("waves/computer.vcd");
	$dumpvars(0,computer);
end

// Clock
wire CLK;
wire CLK_inv;

clock clock(
    .halt(HLT),
    .clock(CLK),
    .clock_inv(CLK_inv)
);

// A Register
wire [7:0] VAL_a;

register a_register(
    .in(BUS),
    .clock(CLK),
    .reset(CLR),
    .enable(AI),
    .out(VAL_a)
);

tri8 a_register_tristate(
    .in(VAL_a),
    .enable(AO),
    .out(BUS)
);

// B Register
wire [7:0] VAL_b;

register b_register(
    .in(BUS),
    .clock(CLK),
    .reset(CLR),
    .enable(BI),
    .out(VAL_b)
);

tri8 b_register_tristate(
    .in(VAL_b),
    .enable(BO),
    .out(BUS)
);

// Instruction Register
wire [7:0] VAL_i;
wire [3:0] IR;
assign IR = VAL_i[7:4];

register i_register(
    .in(BUS),
    .clock(CLK),
    .reset(CLR),
    .enable(II),
    .out(VAL_i)
);

tri8 i_register_tristate(
    .in({4'b0000, VAL_i[3:0]}),
    .enable(IO),
    .out(BUS)
);

// Arithmetic Logic Unit
wire [7:0] VAL_alu;
wire CF;
wire ZF;

alu alu(
    .a(VAL_a),
    .b(VAL_b),
    .subtract(SU),
    .clock(CLK),
    .reset(CLR),
    .en_flag(FI),
    .out(VAL_alu),
    .zero(ZF),
    .carry(CF)
);

tri8 alu_tristate(
    .in(VAL_alu),
    .enable(EO),
    .out(BUS)
);

// Random Access Memory
wire [3:0] VAL_mar;
wire [7:0] VAL_ram;

mar mar(
    .in(BUS),
    .clock(CLK),
    .reset(CLR),
    .enable(MI),
    .out(VAL_mar)
);

ram ram(
    .in(BUS),
    .clock(CLK),
    .address(VAL_mar),
    .enable(RI),
    .out(VAL_ram)
);

initial $readmemh("program.mem", ram.mem);

tri8 ram_tristate(
    .in(VAL_ram),
    .enable(RO),
    .out(BUS)
);

// Program Counter
wire [3:0] VAL_c;

counter counter(
    .in(BUS),
    .clock(CLK),
    .reset(CLR),
    .jump(J),
    .enable(CE),
    .out(VAL_c)
);

tri8 counter_tristate(
    .in({4'b0000, VAL_c}),
    .enable(CO),
    .out(BUS)
);

// Output
printer printer(
    .in(BUS),
    .clock(CLK),
    .reset(CLR),
    .enable(OI)
);

// CPU
cpu cpu(
	.in(IR),
	.clock(CLK_inv),
    .ZF(ZF),
    .CF(CF),
	.HLT(HLT),
	.MI(MI),
	.RI(RI),
	.RO(RO),
	.IO(IO),
	.II(II),
	.AI(AI),
	.AO(AO),
	.EO(EO),
	.SU(SU),
	.BI(BI),
	.BO(BO),
	.OI(OI),
	.CE(CE),
	.CO(CO),
	.J(J),
	.FI(FI)
);
endmodule