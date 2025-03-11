module one_shot_tb();

    // Declaración de señales
    reg clk;
    reg button;
    wire one_shot_button;

    // Instancia del módulo a testear
    one_shot uut (
        .clk(clk),
        .button(button),
        .one_shot_button(one_shot_button)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Genera un pulso de reloj cada 5 unidades de tiempo
    end

    // Estímulo inicial
    initial begin
        // Inicialización
        button = 0;

        // Simulando el comportamiento del botón
        #10 button = 1;  // Botón presionado
        #10 button = 0;  // Botón liberado
        #10 button = 1;  // Botón presionado nuevamente
        #10 button = 0;  // Botón liberado nuevamente

        // Fin de la simulación
        #10 $finish;
    end

    // Monitoreo de las señales
    initial begin
        $monitor("Tiempo: %0t | button: %b | one_shot_button: %b", $time, button, one_shot_button);
    end

endmodule