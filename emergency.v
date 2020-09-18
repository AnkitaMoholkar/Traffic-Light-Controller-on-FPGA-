module Emergency(
input clk,
input reset,
input emer_signal,
output reg R2,
output reg Y2,
output reg G2,
output reg [1:0] present_state
    );
    
reg [1:0] next_state;
reg [3:0] counter; // timer will be in seconds
parameter S0 = 2'b00; // First state
parameter S1 = 2'b01; // Second state
parameter S2 = 2'b10; // Third state
parameter one_sec_delay=4'd1; // Set 1 sec to a value
parameter two_sec_delay=4'd2; // Set 2 sec to a value
parameter thirty_sec_delay=4'd3; // Set 30 sec to a value

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
counter uut6(clk,reset,reset_count,count); 
 
always @ (posedge clk)
begin
    case(present_state)
        S0:begin
            if (emer_signal == 1'b1)
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
            if (count < two_sec_delay) begin
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
            Y2 = 0;
            G2 = 0;
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
