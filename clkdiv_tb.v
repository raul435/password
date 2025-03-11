module clkdiv_tb();

    // Declaración de señales
    reg clk;
    reg rst;
    wire clk_div;

    // Parámetro para el divisor
    parameter CONST_N = 500;

    // Instancia del módulo a testear
    clkdiv #(.CONST_N(CONST_N)) uut (
        .clk(clk),
        .rst(rst),
        .clk_div(clk_div)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Genera un pulso de reloj cada 5 unidades de tiempo
    end

    // Estímulo inicial
    initial begin
        // Inicialización
        rst = 0;
        #10 rst = 1;  // Liberamos el reset después de 10 unidades de tiempo
        
        // Esperar a que el divisor cambie el valor
        #100000;  // Espera 100000 ciclos de reloj
        #10 rst = 0; // Reset activo
        #10 rst = 1; // Liberar reset
        #100000;  // Espera otro ciclo

        // Fin de la simulación
        #10 $finish;
    end

    // Monitoreo de las señales
    initial begin
        $monitor("Tiempo: %0t | rst: %b | clk: %b | clk_div: %b", $time, rst, clk, clk_div);
    end

endmodule