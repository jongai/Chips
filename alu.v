module alu(
	input wire [7:0] a,
	input wire [7:0] b,
	input wire subtract,
	input wire clock,
	input wire reset,
	input wire en_flag,
	output wire [7:0] out,
	output reg zero,
	output reg carry
);

wire [7:0] b1;
wire c1;
wire [7:0] out1;

// ALU
genvar i;
generate
	for (i = 0; i < 8; i = i + 1) begin
		assign b1[i] = b[i] ^ subtract;
	end
endgenerate

adder8 U1(
	.a(a),
	.b(b1),
	.c0(subtract),
	.out(out),
	.c1(c1)
);

// Flag Register
initial begin
	zero <= 0;
	carry <= 0;
end

always @(posedge clock) begin
	if (reset) begin
		zero <= 0;
		carry <= 0;
	end
	else if (en_flag) begin
		carry <= c1;
		zero <= out === 0;
	end
end

endmodule
