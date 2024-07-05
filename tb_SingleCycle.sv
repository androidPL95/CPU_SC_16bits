module tb_clock_generator;

    // Declaração do clock
    logic clk;

    // Instanciando o módulo a ser testado
    SingleCycle_Top dut (
        .clk(clk)
        // Não há necessidade de conectar outras portas neste testbench simples
    );

    // Inicializa o clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Gera um clock de 10 unidades de tempo
    end

endmodule
