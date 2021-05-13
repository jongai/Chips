module ram(
	input wire [7:0] in,
	input wire clock,
	input wire [3:0] address,
	input wire enable,
	output wire [7:0] out
);

reg [7:0] mem [0:15];

assign out = mem[address];

always @(posedge clock) begin
	if (enable) begin
		mem[address] <= in;
	end
end

endmodule