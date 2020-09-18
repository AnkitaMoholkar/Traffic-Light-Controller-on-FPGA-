module Pedestrian(
input clk,
input reset,
input ped_sensor,
output reg R2,
output reg Y2,
output reg G2,
output reg [1:0]present_state
    );
   
reg [1:0] next_state;
reg [3:0] counter; // timer will be in seconds
parameter S0 = 2'b00; // First state
parameter S1 = 2'b01; // Second state
parameter S2 = 2'b10; // Third state
parameter thirty_sec_delay=4'd2; // Set 30 sec to a value
parameter one_min_delay=4'd3; // Set 1min to a value
parameter four_min_delay=4'd5; // Set 4min to a value

always @ (posedge clk or posedge reset)
begin
    if (reset == 1'b1)
        begin
            present_state = S0; // First state is the reset state
            counter = 4'd0;
        end
    else begin
            present_state = next_state;
          end
end
 
reg reset_count;
wire [3:0] count;
counter uut5(clk,reset,reset_count,count);
 
always @(posedge clk)
begin
    case(present_state)
        S0:begin
            if (ped_sensor == 1'b1)
                begin
                    next_state = S1;
                    reset_count = 1'b1;
                end
            else
                begin
                    next_state = S0;
                    reset_count = 1'b0;
                end
            end
        S1: begin
           if (count < four_min_delay) begin
                next_state = S1;
                reset_count = 1'b0;
                end
            else 
                begin 
                    next_state = S2;
                    reset_count = 1'b1;
                end
            end
        S2: begin
           if (count < thirty_sec_delay) begin
                next_state = S2;
                reset_count = 1'b0;
                end
            else
                begin
                    next_state = S0;
                    reset_count = 1'b1;
                end
            end
        default: next_state = S0;
    endcase
end        

always @ (posedge clk)
begin
    case(present_state)
        S0: begin
            R2 = 1;
            Y2 = 0 ;
            G2 = 0 ;
            end 
        S1: begin
            R2 = 0;
            Y2 = 0;
            G2 = 1;
            end  
        S2: begin
            R2 = 0;
            Y2 = 1;
            G2 = 0;
            end
        default: begin
                 R2=1;
                 Y2=0;
                 G2=0;
                 end
    endcase
end
endmodule
