module MUX2to1(p0, p1, sel, out);
    input p0, p1, sel;
    output out;

    reg res;

    always @(*) begin
        if (sel) res=p1;
        else res=p0;
    end
    
    assign out = res;
endmodule