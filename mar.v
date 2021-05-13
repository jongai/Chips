module mar(
	input wire [7:0] in,
	input wire clock,
	input wire reset,
	input wire enable,
	output reg [3:0] out
);

initial out <= 4'b0000;

always @(posedge clock) begin
	if (reset)
		out <= 4'b0000;
	else if (enable)
		out <= in[3:0];
end

endmodule