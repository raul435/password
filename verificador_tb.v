module verificador_tb();

    // Declaración de señales
    reg rst;
    reg clk;
    reg [9:0] Sw;
    wire [3:0] status_out;

    // Instancia del módulo a testear
    verificador uut (
        .rst(rst),
        .clk(clk),
        .Sw(Sw),
        .status_out(status_out)
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
        Sw = 10'b0000000000;  // Sw en 0 inicialmente
        #10 rst = 1;          // Liberamos el reset después de 10 unidades de tiempo
        
        // Estado inicial (IDLE) - Debe cambiar a digit_2 cuando Sw[2] == 1
        #10 Sw = 10'b0000000100;  // Sw[2] en 1 (debe pasar a digit_2)
        #10 Sw = 10'b0000000000;  // Sw vuelve a 0, estado aún en digit_2
        #10 Sw = 10'b0000000001;  // Sw[0] en 1 (debe pasar a digit_3)
        
        // Transición a digit_4
        #10 Sw = 10'b0000000010;  // Sw[1] en 1 (debe pasar a digit_4)
        
        // Finalización en done
        #10 Sw = 10'b0000010000;  // Sw[6] en 1 (debe pasar a done)
        
        // Transición a error
        #10 Sw = 10'b0000000000;  // Si Sw está en 0 y se recibe un valor incorrecto, pasa a error
        #10 Sw = 10'b1111111111;  // Si Sw tiene valores incorrectos, se pasa a error
        
        // Fin de la simulación
        #10 $finish;
    end

    // Monitoreo de las señales
    initial begin
        $monitor("Tiempo: %0t | rst: %b | Sw: %b | Estado: %d | status_out: %b", 
                 $time, rst, Sw, uut.state, status_out);
    end

endmodule
