module traffic_light(
    input clk,
    input rstn,
    output [2:0] lightA,
    output [2:0] lightB);
    
    parameter S0 = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    parameter S3 = 3;

    reg [2:0] ns, cs;
    reg [3:0] ncnt, ccnt;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cs <= S0;
            ccnt <= 1;
        end
        else begin
            cs <= ns;
            ccnt <= ncnt;
        end
    end

    always @(*) begin
        case (cs)
            S0: begin
                ns = (ccnt<8) ? S0 : S1;
                ncnt = (ccnt<8) ? (ccnt+1) : 1;
            end
            S1: begin
                ns = (ccnt<3) ? S1 : S2;
                ncnt = (ccnt<3) ? (ccnt+1) : 1;
            end
            S2: begin
                ns = (ccnt<10) ? S2 : S3;
                ncnt = (ccnt<10) ? (ccnt+1) : 1;
            end
            S3: begin
                ns = (ccnt<3) ? S3 : S0;
                ncnt = (ccnt<3) ? (ccnt+1) : 1;
            end
        endcase
    end

    reg [2:0] la, lb;
    assign lightA = la;
    assign lightB = lb;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            la <= 3'b001;
            lb <= 3'b100;
        end
        else begin
            case (cs)
                S0: begin
                    la <= 3'b001;    // (Red, Yellow, Green)
                    lb <= 3'b100;
                end
                S1: begin
                    la <= 3'b010;
                    lb <= 3'b100;
                end
                S2: begin
                    la <= 3'b100;
                    lb <= 3'b001;
                end
                S3: begin
                    la <= 3'b100;
                    lb <= 3'b010;
                end
            endcase
        end
    end

endmodule