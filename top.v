`timescale 1ns / 1ps
module controller(
input clk,
input reset,
input car_sensor,
input ped_sensor,
input emer_signal,
output R1, //santa clara street red light
output Y1, //santa clara street yellow light
output G1, //santa clara street green light
output R2, // cross st red light
output Y2, //cross st yellow light
output G2 // cross st green light
    );

wire [1:0] ped_state; 
wire [1:0] car_state
wire [1:0] emer_state;

wire	green_p, green_c, green_emr;
wire	yellow_p, yellow_c, yellow_emr;
wire	red_p, red_c, red_emr;	

Pedestrian pp(clk, reset, ped_sensor, red_p, yellow_p, green_p, ped_state);
Car cc(.clk(clk),.reset(reset),.car_sensor(car_sensor),.R2(red_c),.Y2(yellow_c),.G2(green_c),.present_state(car_state));
Emergency ee(.clk(clk),.reset(reset),.emer_signal(emer_signal),.R2(red_emr),.Y2(yellow_emr),.G2(green_emr),.present_state(emer_state));

assign G2 = green_c | green_p | green_emr;  
assign Y2 = yellow_p | yellow_c | yellow_emr;
assign R2 = !(Y2 | G2);
assign Y1 = R2 & (ped_sensor | car_sensor | emer_signal);
assign G1 = !Y1 & !Y2 & !G2;
assign R1 = !Y1 & !G1;

endmodule
