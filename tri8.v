module tri8(
	input wire [7:0] in,
	input wire enable,
	input wire clock,
	output wire [7:0] out
);

	assign out = enable ? in : 8'bz;

endmodule