module imprime_tb;

    // Declaración de señales
    reg clk;
    reg rst;
    reg [3:0] state;
    wire [9:0] leds_out;
    wire [6:0] seg0_out, seg1_out, seg2_out, seg3_out, seg4_out;

    // Instancia del módulo a testear
    imprime uut (
        .clk(clk),
        .rst(rst),
        .state(state),
        .leds_out(leds_out),
        .seg0_out(seg0_out),
        .seg1_out(seg1_out),
        .seg2_out(seg2_out),
        .seg3_out(seg3_out),
        .seg4_out(seg4_out)
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
        state = 4'b0000;  // Estado inicial (IDLE)
        #10 rst = 1;      // Liberamos el reset después de 10 unidades de tiempo

        // Verificando el estado IDLE
        #10 state = 4'b0000; // Estado IDLE
        #10 state = 4'b0001; // Estado digit_2
        #10 state = 4'b0010; // Estado digit_3
        #10 state = 4'b0011; // Estado digit_4
        #10 state = 4'b0100; // Estado done
        #10 state = 4'b0101; // Estado error
        #10 state = 4'b0000; // Volver a estado IDLE

        // Fin de la simulación
        #10 $finish;
    end

    // Monitoreo de las señales
    initial begin
        $monitor("Tiempo: %0t | rst: %b | state: %b | leds_out: %b | seg0_out: %b | seg1_out: %b | seg2_out: %b | seg3_out: %b | seg4_out: %b", 
                 $time, rst, state, leds_out, seg0_out, seg1_out, seg2_out, seg3_out, seg4_out);
    end

endmodule
