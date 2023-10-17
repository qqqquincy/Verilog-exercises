module queue4b_8(         // 4-bit queue that can store 8 data
    input clk,
    input rstn,
    input en,             // to enable push or pop
    input push_pop,       // 1 for push and 0 for pop
    input [3:0] Din,
    output isFull,
    output isEmpty,
    output [3:0] Dout     // should be considered invalid when isEmpty=1
);   

    parameter S0 = 2'd0;  // empty state
    parameter S1 = 2'd1;
    parameter S2 = 2'd2;  // full state

    reg [1:0] cs, ns;
    reg [2:0] cptr, nptr; // pointer to the last data
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cs   <= S0;
            cptr <= 3'd0;
        end
        else begin
            cs   <= ns;
            cptr <= nptr;
        end
    end

    always @(*) begin
        if (en) begin
            case (cs)
                S0: 
                case (push_pop)
                    1'b1: begin
                        ns   = S1;
                        nptr = 3'd0;
                    end
                    1'b0: begin
                        ns   = S0;
                        nptr = 3'd0;
                    end
                endcase
                S1:
                case (push_pop)
                    1'b1:
                    case (cptr)
                        3'd6: begin
                            ns   = S2;
                            nptr = cptr + 3'd1;
                        end
                        default: begin
                            ns   = S1;
                            nptr = cptr + 3'd1;
                        end
                    endcase
                    1'b0:
                    case (cptr)
                        3'd0: begin
                            ns   = S0;
                            nptr = 3'd0;
                        end
                        default: begin
                            ns   = S1;
                            nptr = cptr - 3'd1;
                        end
                    endcase
                endcase
                S2:
                case (push_pop)
                    1'b1: begin
                        ns   = S2;
                        nptr = 3'd7;
                    end
                    1'b0: begin
                        ns   = S1;
                        nptr = 3'd6;
                    end
                endcase
            endcase
        end
        else begin 
            ns   = cs;
            nptr = cptr;
        end
    end

    reg [3:0] SR [0:7];    // use shift register to implement a queue
    reg isEmpty_r, isFull_r;
    reg [3:0] Dout_r;
    integer i;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            isEmpty_r <= 1'b1;
            isFull_r  <= 1'b0;
            Dout_r    <= 4'd0;
        end
        else if (en) begin
            case (cs)
                S0: 
                case (push_pop)
                    1'b1: begin
                        isEmpty_r <= 1'b0;
                        isFull_r  <= 1'b0;
                        Dout_r    <= Din;
                        SR[cptr]  <= Din;
                    end
                    1'b0: begin
                        isEmpty_r <= 1'b1;
                        isFull_r  <= 1'b0;
                        Dout_r    <= 4'd0;
                    end
                endcase
                S1: 
                case (push_pop)
                    1'b1: 
                    case (cptr)
                        3'd6: begin
                            isEmpty_r <= 1'b0;
                            isFull_r  <= 1'b1;
                            Dout_r    <= SR[cptr];
                            for (i=1; i<=cptr+1; i=i+1) begin
                                SR[i] <= SR[i-1];
                            end
                            SR[0]     <= Din;
                        end
                        default: begin
                            isEmpty_r <= 1'b0;
                            isFull_r  <= 1'b0;
                            Dout_r    <= SR[cptr];
                            for (i=1; i<=cptr+1; i=i+1) begin
                                SR[i] <= SR[i-1];
                            end
                            SR[0]     <= Din;
                        end
                    endcase
                    1'b0: 
                    case (cptr)
                        3'd0: begin
                            isEmpty_r <= 1'b1;
                            isFull_r  <= 1'b0;
                            Dout_r    <= SR[cptr];
                        end
                        default: begin
                            isEmpty_r <= 1'b0;
                            isFull_r  <= 1'b0;
                            Dout_r    <= SR[cptr];
                        end
                    endcase
                endcase
                S2: 
                case (push_pop)
                    1'b1: begin
                        isEmpty_r <= 1'b0;
                        isFull_r  <= 1'b1;
                        Dout_r    <= SR[cptr];  // Overflow: Data will not be pushed into the queue.
                    end
                    1'b0: begin
                        isEmpty_r <= 1'b0;
                        isFull_r  <= 1'b0;
                        Dout_r    <= SR[cptr];
                    end
                endcase
            endcase
        end
        else begin
            isEmpty_r <= isEmpty_r;
            isFull_r  <= isFull_r;
            Dout_r    <= SR[cptr];
        end
    end

    assign isEmpty = isEmpty_r;
    assign isFull = isFull_r;
    assign Dout = Dout_r;

endmodule