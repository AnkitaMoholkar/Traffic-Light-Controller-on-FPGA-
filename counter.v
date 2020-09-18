module counter(
input clk,
input reset,
input reset_count,
output reg [5:0] count=0
    );
    
reg [26:0] one_second_count;
wire count_enable;

always @(posedge clk or posedge reset)
begin
    if ((reset == 1'b1) || (reset_count ==1'b1))
    begin
       one_second_count = 1'b0;
    end
    else begin
        if (one_second_count >= 49999999)
        begin
            one_second_count = 1'b0;
        end
        else begin
            one_second_count = one_second_count + 1'b1;
        end
   end
end

assign count_enable = (one_second_count == 49999999) ? 1 : 0; 

always @(posedge clk or posedge reset)
begin
    if ((reset == 1'b1) || (reset_count == 1'b1))
    begin 
        count <= 1'b0;
     end
     else if (count_enable ==1'b1) begin
              count <= count + 1'b1;
          end
 end 
endmodule
