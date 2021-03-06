from itertools import groupby
from datetime import datetime


def opout(item, i):
    out = 0
    for i in item[i].split():
        out = out | output_wires[i]
    return out


def opin(op, i):
    return (opcode[op] << 4) + i


out = [
f"// Generated by cpu_gen.py at {datetime.now()}\n"
"""// by Jonathan Gai
reg [15:0] out;

assign {HLT, MI, RI, RO, IO, II, AI, AO, EO, SU, BI,
\t\tOI, CE, CO, J, FI} = out;
always @(posedge clock) begin
\tcase ({in, count_cpu})
"""
]

output_wires = {"HLT": 0b1000000000000000,
                "MI":  0b0100000000000000,
                "RI":  0b0010000000000000,
                "RO":  0b0001000000000000,
                "IO":  0b0000100000000000,
                "II":  0b0000010000000000,
                "AI":  0b0000001000000000,
                "AO":  0b0000000100000000,
                "EO":  0b0000000010000000,
                "SU":  0b0000000001000000,
                "BI":  0b0000000000100000,
                "OI":  0b0000000000010000,
                "CE":  0b0000000000001000,
                "CO":  0b0000000000000100,
                "J":   0b0000000000000010,
                "FI":  0b0000000000000001,
                }

opcode = {"NOP": 0b0000,
          "LDA": 0b0001,
          "ADD": 0b0010,
          "SUB": 0b0011,
          "STA": 0b0100,
          "LDI": 0b0101,
          "JMP": 0b0110,
          "OUT": 0b1110,
          "HLT": 0b1111,
          }

with open("cpu_in") as f:
    cpu_in = list(map(str.strip, f.readlines()))
cpu_in = [list(g) for k, g in groupby(cpu_in, lambda x: x != "--") if k]

for item in cpu_in:
    op = item[0]
    out.append(f"\t\t// {op}\n")
    for i in range(len(item) - 1):
        s = f"8\'b{opin(op, i):>08b}: out <= 16\'b{opout(item, i + 1):>016b};"
        out.append('\t\t' + s + '\n')

out.append(
"""\t\tdefault:     out <= 16'b0000000000000000;
\tendcase
end
"""
)

with open("cpu.v", 'r') as f:
    cpu = f.readlines()

with open("cpu.v", 'w') as f:
    if min(cpu.index("// START\n"), cpu.index("// FINISH\n")) >= 0:
        f.writelines(cpu[:cpu.index("// START\n") + 1] + out + cpu[cpu.index("// FINISH\n"):])
        print("Success")
    else:
        print("No markers found")