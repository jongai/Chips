module printer(
    input wire [7:0] in,
    input wire clock,
    input wire reset,
    input wire enable
);

reg [7:0] val;

initial val <= 0;

always @(posedge clock) begin
    if (reset)
        val <= 0;
    else if (enable)
        val <= in;
    $monitor("%d",val);
end

endmodule