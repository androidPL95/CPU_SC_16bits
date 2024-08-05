package typedefs;

parameter NUM_OPS  = 32;
parameter WIDTH_OP = $clog2(NUM_OPS);

typedef enum logic[WIDTH_OP-1:0] { 
    ALU_ADD , 
    ALU_SUB , 
    ALU_NOT , 
    ALU_AND , 
    ALU_OR  , 
    ALU_XOR , 
    ALU_SLL , 
    ALU_SRL , 
    ALU_SLA , 
    ALU_SRA , 
    EQ      , 
    GRT     , 
    GTU     , 
    GTE     , 
    LTE     , 
    GEU     , 
    LEU     , 
    ALU_BSL 
} alu_opcode_t;

typedef enum logic[5:0] {
    ADD   = 6'b000000,
    SUB   = 6'b000001,
    NOT   = 6'b000010,
    AND   = 6'b000011,
    OR    = 6'b000100,
    XOR   = 6'b000101,
    SLL   = 6'b000110,
    SRL   = 6'b000111,
    SRA   = 6'b001000,
    ADDI  = 6'b001001,
    LUI   = 6'b001010,
    ANDI  = 6'b001011,
    ORI   = 6'b001100,
    XORI  = 6'b001101,
    BEQ   = 6'b001110,
    BNE   = 6'b001111,
    BLT   = 6'b010000,
    BGT   = 6'b010001,
    BGE   = 6'b010010,
    BLE   = 6'b010011,
    BLTU  = 6'b010100,
    BGTU  = 6'b010101,
    BGEU  = 6'b010110,
    BLEU  = 6'b010111,
    JAL   = 6'b011000,
    LW    = 6'b011001,
    SW    = 6'b011010,
    LAD   = 6'b011011,
    LOA   = 6'b011100,
    SIER  = 6'b011101, // SET IER
    UIER  = 6'b011110, // UNSET IER
    SIFR  = 6'b011111, // SET IFR
    UIFR  = 6'b100000, // UNSET IFR
    EDRT  = 6'b100001  // END ROUTINE -> MUST BE AT THE END OF EVERY ROUTINE
} opcode_t;


endpackage