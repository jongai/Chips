opcode = {"NOP": format(0b0000, 'x'),
          "LDA": format(0b0001, 'x'),
          "ADD": format(0b0010, 'x'),
          "SUB": format(0b0011, 'x'),
          "STA": format(0b0100, 'x'),
          "LDI": format(0b0101, 'x'),
          "JMP": format(0b0110, 'x'),
          "OUT": format(0b1110, 'x'),
          "HLT": format(0b1111, 'x'),
          }

with open("program.txt", 'r') as f:
    data = [item.strip() for item in f.readlines()]

out = []
with open("program.mem", 'w') as f:
    for item in data:
        if len(item) == 1:
            out.append(format(int(item), 'x') + "\n")
        else:
            op, num = item.split()
            out.append(opcode[op] + format(int(num), 'x') + "\n")
    while len(out) < 16:
        out.append("00\n")
    out[-1] = out[-1][0:-1]
    if len(out) > 16:
        print("Too long")
    else:
        f.writelines(out)
        print("Success")