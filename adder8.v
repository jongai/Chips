module adder8(
	input wire [7:0] a,
	input wire [7:0] b,
	input wire c0,
	output wire [7:0] out,
	output wire c1
);

assign {c1, out} = c0 === 1'bX ? a + b : a + b + c0;

endmodule
