module register(
	input wire [7:0] in,
	input wire clock,
	input wire reset,
	input wire enable,
	output reg [7:0] out
);

initial out <= 8'b00000000;

always @(posedge clock) begin
	if (reset)
		out <= 8'b00000000;
	else if (enable)
		out <= in;
end

endmodule
