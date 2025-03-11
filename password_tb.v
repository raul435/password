`timescale 1ns / 1ps

module password_tb;

    // Señales de prueba
    reg clk;
    reg rst;
    reg [9:0] Sw;
    wire [9:0] leds_out;
    wire [7:0] seg0_out, seg1_out, seg2_out, seg3_out, seg4_out;
    
    // Instancia del módulo bajo prueba (UUT: Unit Under Test)
    password uut (
        .clk(clk),
        .rst(rst),
        .Sw(Sw),
        .leds_out(leds_out),
        .seg0_out(seg0_out),
        .seg1_out(seg1_out),
        .seg2_out(seg2_out),
        .seg3_out(seg3_out),
        .seg4_out(seg4_out)
    );
    
    // Generación de reloj
    always #5 clk = ~clk; // Periodo de 10ns
    
    initial begin
        // Inicialización de señales
        clk = 0;
        rst = 1;
        Sw = 10'b0000000000;
        $display("[TIME %0t] Inicializando señales", $time);
        
        #20 rst = 0; // Liberar reset después de 20ns
        $display("[TIME %0t] Reset desactivado", $time);
		  $display("[TIME %0t] stado:", leds_out);
        
        // Prueba: Ingresar una secuencia de switches simulando una contraseña
        #10 Sw = 10'b0000000001; // Primer dígito
        $display("[TIME %0t] Primer dígito ingresado: %b", $time, Sw);
		  $display("[TIME %0t] stado:", leds_out);
        #20 Sw = 10'b0000000010; // Segundo dígito
        $display("[TIME %0t] Segundo dígito ingresado: %b", $time, Sw);
		  $display("[TIME %0t] stado:", leds_out);
        #20 Sw = 10'b0000000100; // Tercer dígito
        $display("[TIME %0t] Tercer dígito ingresado: %b", $time, Sw);
		  $display("[TIME %0t] stado:", leds_out);
        #20 Sw = 10'b0000001000; // Cuarto dígito
        $display("[TIME %0t] Cuarto dígito ingresado: %b", $time, Sw);
		  $display("[TIME %0t] stado:", leds_out);
        
        #50 $display("[TIME %0t] Finalizando simulación", $time);
		  $display("[TIME %0t] stado:", leds_out);
        $stop; // Finalizar la simulación
    end
    
endmodule

