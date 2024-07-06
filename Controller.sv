module Controller import typedefs::*;
(
    input  logic        clk       ,
    input  opcode_t     op        ,
    input  logic        comp      ,
    output logic        sel_PC    ,
    output logic        sum_imm   ,
    output logic        store_pc  ,
    output logic        reg_we    ,
    output logic        alu_imm   ,
    output alu_opcode_t alu_ctrl  ,
    output logic        alu_bypass,
	 output logic			alu_feedback_in,
    output logic        mem_we    ,
    output logic        mem_bypass
);

always_comb begin

    case(op)

        ADD  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_ADD;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        SUB  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_SUB;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        NOT : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_NOT;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        AND  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_AND;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        OR   : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_OR;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        XOR  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_XOR;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        SLL  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_SLL;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        SRL  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_SRL;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        SRA  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_SRA;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        ADDI : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '1;
            alu_ctrl   = ALU_ADD;
            alu_bypass = '0;
				alu_feedback_in = '1;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        LUI  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '1;
            alu_ctrl   = ALU_BSL;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        ANDI : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '1;
            alu_ctrl   = ALU_AND;
            alu_bypass = '0;
				alu_feedback_in = '1;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        ORI  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '1;
            alu_ctrl   = ALU_OR;
            alu_bypass = '0;
				alu_feedback_in = '1;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        XORI : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '1;
            alu_ctrl   = ALU_XOR;
            alu_bypass = '0;
				alu_feedback_in = '1;
            mem_we     = '0;
            mem_bypass = '0;        
        end

        BEQ  : begin
            sel_PC     = '1;
            if(comp == '1) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = EQ;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BNE  : begin
            sel_PC     = '1;
            if(comp == '0) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = EQ;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BGT  : begin
            sel_PC     = '1;
            if(comp == '1) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = GRT;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BLT  : begin
            sel_PC     = '1;
            if(comp == '0) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = GRT;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BGE  : begin
            sel_PC     = '1;
            if(comp == '1) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = GTE;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BLE : begin
            sel_PC     = '1;
            if(comp == '1) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = LTE;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BGTU : begin
            sel_PC     = '1;
            if(comp == '1) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = GTU;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BLTU : begin
            sel_PC     = '1;
            if(comp == '0) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = GTU;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BGEU : begin
            sel_PC     = '1;
            if(comp == '1) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = GEU;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        BLEU : begin
            sel_PC     = '1;
            if(comp == '1) 
                sum_imm = '1;
            else
                sum_imm = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = LEU;
				alu_feedback_in = '0;
            alu_bypass = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        JAL  : begin
            sel_PC     = '0;
            sum_imm    = '0;
            store_pc   = '1;
            reg_we     = '1;
            alu_imm    = '0;
            alu_ctrl   = ALU_ADD;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        // Instead of summing the value of the aux with imm
        // will just access address stored at auxiliary
        // Otherwise we'll need to change the datapath (simple but meh)
        // READS MEMORY AT ADDRESS SPECIFIED BY AUX AND STORES AT REG FILE
        // ADDRESS A1
        LW   : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '1;
            alu_imm    = '0;
            alu_ctrl   = ALU_ADD;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

        //LB   :

        // Instead of summing the value of the aux with imm
        // will just acces address stored at auxiliary
        // Otherwise we'll need to change the datapath (simple but meh)
        // READS REG FILE AT A2 AND THEN LOADS THE VALUE INTO MEM ADDRESS
        // SPECIFIED BY AUXILIARY
        SW   : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_ADD;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '1;
            mem_bypass = '0;
        end

        LAD  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '1;
            alu_imm    = '0;
            alu_ctrl   = ALU_ADD;
            alu_bypass = '0;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '1;
        end

        LOA  : begin
            sel_PC     = '1;
            sum_imm    = '0;
            store_pc   = '0;
            reg_we     = '0;
            alu_imm    = '0;
            alu_ctrl   = ALU_ADD;
            alu_bypass = '1;
				alu_feedback_in = '0;
            mem_we     = '0;
            mem_bypass = '0;
        end

    endcase

end

endmodule