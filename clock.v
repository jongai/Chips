module clock (
    input wire halt,
    output reg clock,
    output wire clock_inv
);

  assign clock_inv = ~clock;
  
  initial clock <= 0;
  
  always #1 clock = ~clock & (halt !== 1);
endmodule