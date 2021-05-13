module counter(
	input wire [7:0] in,
	input wire clock,
	input wire reset,
	input wire jump,
	input wire enable,
	output reg [3:0] out
);

initial out <= 0;

always @(posedge clock) begin
	if (reset)
		out <= 0;
	else if (jump)
		out <= in[3:0];
	else if (enable)
		out <= out + 1;
end

endmodule
