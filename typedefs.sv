package typedefs;

parameter NUM_OPS  = 32;
parameter WIDTH_OP = $clog2(NUM_OPS);

typedef enum logic[WIDTH_OP-1:0] {ALU_ADD , ALU_SUB , ALU_NOT , ALU_AND , ALU_OR , ALU_XOR , ALU_SLL , ALU_SRL , ALU_SLA , ALU_SRA , EQ , GRT , GTU , GTE , LTE , GEU , LEU, ALU_BSL} alu_opcode_t;

typedef enum logic[WIDTH_OP-1:0] {ADD , SUB , NOT , AND , OR , XOR , SLL , SRL , SRA , ADDI , LUI , ANDI , ORI , XORI , BEQ , BNE , BLT , BGT , BGE , BLE , BLTU , BGTU , BGEU , BLEU , JAL , LW , /*LB ,*/ SW , /*SB ,*/ LAD , LOA} opcode_t;

endpackage