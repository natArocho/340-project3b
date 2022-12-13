// Define shared modules here
// We will always include this file when testing your code

//1-bit half adder
module halfAdder
(
    input  logic A, B, 
    output logic S, cOut
);
    AND2 a0(cOut, A, B);
    XOR2 x0(S, A, B);

endmodule

//1-bit full adder
module fullAdder
(
    input  logic A, B, cIn,
    output logic S, cOut
);
    logic x, c0, c1;
    halfAdder h0(.A(A), .B(B), .S(x), .cOut(c0));
    halfAdder h1(.A(cIn), .B(x), .S(S), .cOut(c1));
    OR2 o0(cOut, c0, c1);

endmodule

//8 bit Adder
module add8
(
    input  logic [7:0] A, B,
    output logic [7:0] S,
    output logic Co
);
    logic [7:0] cOuts;
    
    genvar i;
    generate
        for (i=0; i<8; i++) begin
            if (i==0) begin
                halfAdder h0(.A(A[i]), .B(B[i]), .S(S[i]), .cOut(cOuts[i]));
            end
            else begin
                fullAdder h1(.A(A[i]), .B(B[i]), .cIn(cOuts[i-1]), .S(S[i]), .cOut(cOuts[i]));
            end
        end
    endgenerate

    assign Co = cOuts[7];

endmodule

//27 bit Adder
module add27
(
    input  logic [26:0] A, B,
    output logic [26:0] S,
    output logic Co
);
    logic [26:0] cOuts;
    
    genvar i;
    generate
        for (i=0; i<27; i++) begin
            if (i==0) begin
                halfAdder h0(.A(A[i]), .B(B[i]), .S(S[i]), .cOut(cOuts[i]));
            end
            else begin
                fullAdder h1(.A(A[i]), .B(B[i]), .cIn(cOuts[i-1]), .S(S[i]), .cOut(cOuts[i]));
            end
        end
    endgenerate

    assign Co = cOuts[26];

endmodule


//adds 1 to 8-bit number
module addOne8
(
    input  logic [7:0] A,
    output logic [7:0] B,
    output logic cOut
);
    logic [7:0] cOuts;
    
    genvar i;
    generate
        for (i=0; i<8; i++) begin
            if (i==0) begin
                halfAdder h0(.A(A[i]), .B(1'b1), .S(B[i]), .cOut(cOuts[i]));
            end
            else begin
                halfAdder h1(.A(A[i]), .B(cOuts[i-1]), .S(B[i]), .cOut(cOuts[i]));
            end
        end
    endgenerate

    assign cOut = cOuts[7];

endmodule

//adds 1 to 24-bit number
module addOne24
(
    input  logic [23:0] A,
    output logic [23:0] B,
    output logic cOut
);
    logic [23:0] cOuts;
    
    genvar i;
    generate
        for (i=0; i<24; i++) begin
            if (i==0) begin
                halfAdder h0(.A(A[i]), .B(1'b1), .S(B[i]), .cOut(cOuts[i]));
            end
            else begin
                halfAdder h1(.A(A[i]), .B(cOuts[i-1]), .S(B[i]), .cOut(cOuts[i]));
            end
        end
    endgenerate

    assign cOut = cOuts[23];

endmodule

//adds 1 to 24-bit number
module addOne27
(
    input  logic [26:0] A,
    output logic [26:0] B,
    output logic cOut
);
    logic [26:0] cOuts;
    
    genvar i;
    generate
        for (i=0; i<27; i++) begin
            if (i==0) begin
                halfAdder h0(.A(A[i]), .B(1'b1), .S(B[i]), .cOut(cOuts[i]));
            end
            else begin
                halfAdder h1(.A(A[i]), .B(cOuts[i-1]), .S(B[i]), .cOut(cOuts[i]));
            end
        end
    endgenerate

    assign cOut = cOuts[26];

endmodule

//1-bit subtraction cell
module subBit
(
    input  logic A, B, bIn,
    output logic bOut, D
);
    //optimize later?
    logic nA, x, nX, sA0, sA1, bA0, bA1, bO0;

    INV i0(nA, A);

    XOR2 x0(x, B, bIn);
    INV i1(nX, x);

    AND2 a0(sA0, A, nX);
    AND2 a1(sA1, nA, x);
    OR2  o0(D, sA0, sA1);
    
    AND3 a2(bA0, A, B, bIn);
    OR2  o1(bO0, B, bIn);
    AND2 a3(bA1, bO0, nA);
    OR2  o2(bOut, bA1, bA0);

endmodule

//1-bit half subtractor
module halfSub
(
    input  logic A, B, 
    output logic D, bOut
);
    logic nA;
    INV i0(nA, A);
    AND2 a0(bOut, nA, B);
    XOR2 x0(D, A, B);

endmodule

//8-bit subtractor
module sub8
(
    input  logic [7:0] A, B, 
    output logic [7:0] D,
    output logic bOut
);
    logic [7:0] bOuts;

    genvar i;
    generate 
        for(i=0; i<8; i++) begin
            if(i==0) begin
                halfSub s0(.A(A[i]), .B(B[i]), .bOut(bOuts[i]), .D(D[i]));
            end
            else begin
                subBit s1(.A(A[i]), .B(B[i]), .bIn(bOuts[i-1]), .bOut(bOuts[i]), .D(D[i]));
            end
        end
    endgenerate

    assign bOut = bOuts[7];

endmodule

//9-bit subtractor
module sub9
(
    input  logic [8:0] A, B, 
    output logic [8:0] D,
    output logic bOut
);
    logic [8:0] bOuts;

    genvar i;
    generate 
        for(i=0; i<9; i++) begin
            if(i==0) begin
                halfSub s0(.A(A[i]), .B(B[i]), .bOut(bOuts[i]), .D(D[i]));
            end
            else begin
                subBit s1(.A(A[i]), .B(B[i]), .bIn(bOuts[i-1]), .bOut(bOuts[i]), .D(D[i]));
            end
        end
    endgenerate

    assign bOut = bOuts[8];

endmodule

//27-bit subtractor
module sub27
(
    input  logic [26:0] A, B, 
    output logic [26:0] D,
    output logic bOut
);
    logic [26:0] bOuts;

    genvar i;
    generate 
        for(i=0; i<27; i++) begin
            if(i==0) begin
                halfSub s0(.A(A[i]), .B(B[i]), .bOut(bOuts[i]), .D(D[i]));
            end
            else begin
                subBit s1(.A(A[i]), .B(B[i]), .bIn(bOuts[i-1]), .bOut(bOuts[i]), .D(D[i]));
            end
        end
    endgenerate

    assign bOut = bOuts[26];

endmodule

//returns 1 if two bits are equal
module equalBit
(
    input  logic A, B, eqIn,
    output logic eqOut
);
    logic eq;
    XNOR2 x0(eq, A, B);
    
    AND2 a0(eqOut, eq, eqIn);
endmodule

//returns 1 if A = 0
module equalBit0
(
    input  logic A, eqIn,
    output logic eqOut
);
    logic nA;
    INV i0(nA, A);
    
    AND2 a0(eqOut, nA, eqIn);
endmodule

//returns 1 if  A = 1
module equalBit1
(
    input  logic A, eqIn,
    output logic eqOut
);  
    AND2 a0(eqOut, A, eqIn);
endmodule

//Returns A == B
module equal8
(
    input  logic [7:0] A, B,
    output logic       eq
);
    logic [7:0] eqOuts;


    genvar i;
    generate
	for (i=0; i<8; i++) begin
            if(i==0) begin
	        equalBit e0(.A(A[i]), .B(B[i]), .eqIn(1'b1), .eqOut(eqOuts[i]));
	    end
	    else begin
		    equalBit e1(.A(A[i]), .B(B[i]), .eqIn(eqOuts[i-1]), .eqOut(eqOuts[i]));
	    end
	end
    endgenerate

    assign eq = eqOuts[7];

endmodule

//Returns A == B
module equal27
(
    input  logic [26:0] A, B,
    output logic       eq
);
    logic [26:0] eqOuts;


    genvar i;
    generate
	for (i=0; i<27; i++) begin
            if(i==0) begin
	        equalBit e0(.A(A[i]), .B(B[i]), .eqIn(1'b1), .eqOut(eqOuts[i]));
	    end
	    else begin
		    equalBit e1(.A(A[i]), .B(B[i]), .eqIn(eqOuts[i-1]), .eqOut(eqOuts[i]));
	    end
	end
    endgenerate

    assign eq = eqOuts[26];

endmodule

//Returns A == 8'd0
module equalZero8
(
    input  logic [7:0] A,
    output logic       eq
);
    logic [7:0] eqOuts;


    genvar i;
    generate
	for (i=0; i<8; i++) begin
            if(i==0) begin
	        equalBit0 e0(.A(A[i]), .eqIn(1'b1), .eqOut(eqOuts[i]));
	    end
	    else begin
		    equalBit0 e1(.A(A[i]), .eqIn(eqOuts[i-1]), .eqOut(eqOuts[i]));
	    end
	end
    endgenerate

    assign eq = eqOuts[7];

endmodule

//Returns A == 5'd0
module equalZero5
(
    input  logic [4:0] A,
    output logic       eq
);
    logic [4:0] eqOuts;


    genvar i;
    generate
	for (i=0; i<5; i++) begin
        if(i==0) begin
	        equalBit0 e0(.A(A[i]), .eqIn(1'b1), .eqOut(eqOuts[i]));
	    end
	    else begin
		    equalBit0 e1(.A(A[i]), .eqIn(eqOuts[i-1]), .eqOut(eqOuts[i]));
	    end
	end
    endgenerate

    assign eq = eqOuts[4];

endmodule

//Returns A == 8'hFF
module equalFF8
(
    input  logic [7:0] A,
    output logic       eq
);
    logic [7:0] eqOuts;


    genvar i;
    generate
	for (i=0; i<8; i++) begin
            if(i==0) begin
	        equalBit1 e0(.A(A[i]), .eqIn(1'b1), .eqOut(eqOuts[i]));
	    end
	    else begin
		    equalBit1 e1(.A(A[i]), .eqIn(eqOuts[i-1]), .eqOut(eqOuts[i]));
	    end
	end
    endgenerate

    assign eq = eqOuts[7];

endmodule

//Returns A == 23'd0
module equalZero23
(
    input  logic [22:0] A,
    output logic       eq
);
    logic [22:0] eqOuts;


    genvar i;
    generate
	for (i=0; i<23; i++) begin
            if(i == 0) begin
	        equalBit0 e0(.A(A[i]), .eqIn(1'b1), .eqOut(eqOuts[i]));
	    end
	    else begin
		    equalBit0 e1(.A(A[i]), .eqIn(eqOuts[i-1]), .eqOut(eqOuts[i]));
	    end
	end
    endgenerate

    assign eq = eqOuts[22];

endmodule

//8 bit 2-1 mux
module mux8
(
    input  logic [7:0] A, B,
    input  logic       sel,
    output logic [7:0] Y
);
    genvar i;
    generate 
	for (i=0; i<8; i++) begin
	     MUX2 m0(.Y(Y[i]), .sel(sel), .A(A[i]), .B(B[i]));
	end
   endgenerate
endmodule

//24 bit 2-1 mux
module mux24
(
    input  logic [23:0] A, B,
    input  logic       sel,
    output logic [23:0] Y
);
    genvar i;
    generate 
	for (i=0; i<24; i++) begin
	    MUX2 m0(.Y(Y[i]), .sel(sel), .A(A[i]), .B(B[i]));
	end
   endgenerate
endmodule

//27 bit 2-1 mux
module mux27
(
    input  logic [26:0] A, B,
    input  logic       sel,
    output logic [26:0] Y
);
    genvar i;
    generate 
	for (i=0; i<27; i++) begin
	     MUX2 m0(.Y(Y[i]), .sel(sel), .A(A[i]), .B(B[i]));
	end
   endgenerate
endmodule
    
//32 bit 2-1 mux
module mux32
(
    input  logic [31:0] A, B,
    input  logic       sel,
    output logic [31:0] Y
);
    genvar i;
    generate 
	for (i=0; i<32; i++) begin
	     MUX2 m0(.Y(Y[i]), .sel(sel), .A(A[i]), .B(B[i]));
	end
   endgenerate
endmodule

// unpacks floats A and B to be used for arithmetic also indicates if there is a sepcial case
module float_unpacker
(
    input  logic [31:0] A, B,
    input  logic SEL,

    //floating point number
    output logic signA, signB, sameSign, //sign
    output logic [7:0] expA, expB,       //exponent
    output logic [23:0] sigA, sigB,      //significand

    //special cases
    output logic nan,  // NAN + or * Anything 
                 infA, // A is +/- infinity 
	             infB  // B is +/- infinity
);
    assign signA = A[31];
    assign signB = B[31];
    XNOR2 x0(sameSign, signA, signB);

    assign expA = A[30:23];
    assign expB = B[30:23];

    logic expAEq0, expBEq0;
    equalZero8 e0(.A(expA), .eq(expAEq0));
    equalZero8 e1(.A(expB), .eq(expBEq0));

    mux24  m0(.A({1'b1, A[22:0]}), .B(24'd0), .sel(expAEq0), .Y(sigA));
    mux24  m1(.A({1'b1, B[22:0]}), .B(24'd0), .sel(expBEq0), .Y(sigB));

    logic nanA, nanB, 
	  nInfA, nInfB, sig0A, sig0B;

    equalZero23 e2(.A(A[22:0]), .eq(sig0A));
    equalZero23 e3(.A(B[22:0]), .eq(sig0B));

    logic expAMax, expBMax, n0A, n0B;

    equalFF8 e4(.A(expA), .eq(expAMax));
    equalFF8 e5(.A(expB), .eq(expBMax));

    INV i0(n0A, sig0A);
    INV i1(n0B, sig0B);

    AND2 a0(nanA, n0A, expAMax); 
    AND2 a1(nanB, n0B, expBMax); 

    INV i2(nSA, signA);
    INV i3(nSB, signB);

    AND2 a2(infA, sig0A, expAMax); 
    AND2 a3(infB, sig0B, expBMax); 
    
    OR2  o0(nan, nanA, nanB);
     
endmodule

//1-bit comparator block
module compare
(
    input  logic A, B,
    		 eqIn,  ltIn,  gtIn,
    output logic eqOut, ltOut, gtOut
);
    equalBit e0(.A, .B, .eqIn, .eqOut);
    
    logic nGtIn, nLtIn, nA, nB;    
    INV i0(nGtIn, gtIn);  
    INV i1(nLtIn, ltIn);
    INV i2(nA, A);
    INV i3(nB, B);

    logic bitGT;
    AND3 a0(bitGT, A, nB, nLtIn);
    OR2  o0(gtOut, gtIn, bitGT);

    logic bitLT;
    AND3 a1(bitLT, nA, B, nGtIn);
    OR2  o1(ltOut, ltIn, bitLT);
 
endmodule

//8-bit comparator, returns a > b, a == b, and a < b
module compare8
(
    input  logic [7:0] A, B,
    output logic eq, lt, gt
);
    logic [7:0] ltBits, eqBits, gtBits;
    genvar i;
    generate 
	for(i=8; i>0; i--) begin
	    if(i == 8) begin
		compare c0(.A(A[i-1]), .B(B[i-1]),
	  .eqIn(1'b1), .ltIn(1'b0), .gtIn(1'b0),
	  .eqOut(eqBits[i-1]), .ltOut(ltBits[i-1]), .gtOut(gtBits[i-1]));  
	    end
	    else begin
		compare c1(.A(A[i-1]), .B(B[i-1]),
	  .eqIn(eqBits[i]), .ltIn(ltBits[i]), .gtIn(gtBits[i]),
	  .eqOut(eqBits[i-1]), .ltOut(ltBits[i-1]), .gtOut(gtBits[i-1]));  
	    end
	end
    endgenerate

    assign eq = eqBits[0];
    assign lt = ltBits[0];
    assign gt = gtBits[0];

endmodule 

//9-bit comparator, returns a > b, a == b, and a < b
module compare9
(
    input  logic [8:0] A, B,
    output logic eq, lt, gt
);
    logic [8:0] ltBits, eqBits, gtBits;
    genvar i;
    generate 
	for(i=9; i>0; i--) begin
	    if(i == 9) begin
		compare c0(.A(A[i-1]), .B(B[i-1]),
	  .eqIn(1'b1), .ltIn(1'b0), .gtIn(1'b0),
	  .eqOut(eqBits[i-1]), .ltOut(ltBits[i-1]), .gtOut(gtBits[i-1]));  
	    end
	    else begin
		compare c1(.A(A[i-1]), .B(B[i-1]),
	  .eqIn(eqBits[i]), .ltIn(ltBits[i]), .gtIn(gtBits[i]),
	  .eqOut(eqBits[i-1]), .ltOut(ltBits[i-1]), .gtOut(gtBits[i-1]));  
	    end
	end
    endgenerate

    assign eq = eqBits[0];
    assign lt = ltBits[0];
    assign gt = gtBits[0];

endmodule 

//24-bit comparator, returns a > b, a == b, and a < b
module compare24
(
    input  logic [23:0] A, B,
    output logic eq, lt, gt
);
    logic [23:0] ltBits, eqBits, gtBits;
    genvar i;
    generate 
	for(i=24; i>0; i--) begin
	    if(i == 24) begin
		compare c0(.A(A[i-1]), .B(B[i-1]),
	  .eqIn(1'b1), .ltIn(1'b0), .gtIn(1'b0),
	  .eqOut(eqBits[i-1]), .ltOut(ltBits[i-1]), .gtOut(gtBits[i-1]));  
	    end
	    else begin
		compare c1(.A(A[i-1]), .B(B[i-1]),
	  .eqIn(eqBits[i]), .ltIn(ltBits[i]), .gtIn(gtBits[i]),
	  .eqOut(eqBits[i-1]), .ltOut(ltBits[i-1]), .gtOut(gtBits[i-1]));  
	    end
	end
    endgenerate

    assign eq = eqBits[0];
    assign lt = ltBits[0];
    assign gt = gtBits[0];

endmodule 

//Does B = A >> shiftAmount
module shift27 
(
    input  logic [26:0] A,
    input  logic [7:0]  shiftAmount,
    output logic [26:0] B
);
    logic [26:0] shift1, shift2, shift3, shift4, shift5;
    logic shiftSel;

    mux27 m0(.A(A), .B({1'b0, A[26:1]}), .sel(shiftAmount[0]), .Y(shift1)); // >> 1

    mux27 m1(.A(shift1), .B({2'b0, shift1[26:2]}), .sel(shiftAmount[1]), .Y(shift2)); // >> 2

    mux27 m2(.A(shift2), .B({4'b0, shift2[26:4]}), .sel(shiftAmount[2]), .Y(shift3)); // >> 4

    mux27 m3(.A(shift3), .B({8'b0, shift3[26:8]}), .sel(shiftAmount[3]), .Y(shift4)); // >> 8

    mux27 m4(.A(shift4), .B({16'b0, shift4[26:16]}), .sel(shiftAmount[4]), .Y(shift5)); // >> 16

    OR3   o0(shiftSel, shiftAmount[5], shiftAmount[6], shiftAmount[7]);
    mux27 m5(.A(shift5), .B(27'd0), .sel(shiftSel), .Y(B)); // >> 32+


endmodule

//Does B = A << shiftAmount
module shift27Left
(
    input  logic [26:0] A,
    input  logic [4:0]  shiftAmount,
    output logic [26:0] B
);
    logic [26:0] shift1, shift2, shift3, shift4;
    logic shiftSel;

    mux27 m0(.A(A), .B({A[25:0], 1'b0}), .sel(shiftAmount[0]), .Y(shift1)); // >> 1

    mux27 m1(.A(shift1), .B({shift1[24:0], 2'b0}), .sel(shiftAmount[1]), .Y(shift2)); // >> 2

    mux27 m2(.A(shift2), .B({shift2[22:0], 4'b0}), .sel(shiftAmount[2]), .Y(shift3)); // >> 4

    mux27 m3(.A(shift3), .B({shift3[18:0], 8'b0}), .sel(shiftAmount[3]), .Y(shift4)); // >> 8

    mux27 m4(.A(shift4), .B({shift4[10:0], 16'b0}), .sel(shiftAmount[4]), .Y(B)); // >> 16

endmodule

//aligns significand to be used for 
module alignment
(
    input  logic        signA, signB, 
    input  logic [7:0]  expA, expB,
    input  logic [23:0] sigA, sigB,
    output logic [7:0]  expAlign,    //shared exponent for arithmetic
    output logic [26:0] numX, numY,  //numbers used for add/sub
    output logic 	signX, signY
);
    logic [26:0] numYTemp,  //value of number before shifting
		 numYShift; //value of number after shifting;
    logic [7:0]  shiftAmount, expD1; //difference of A-B if A >= B, B-A otherwise
    logic stickyBit, aGtB, gt, lt, eqS, gtS, eqSel, signSel; 

    compare8  expComp(.A(expA), .B(expB), .eq(eq), .lt(lt), .gt(gt));
    compare24 sigComp(.A(sigA), .B(sigB), .eq(eqS), .lt(), .gt(gtS));
    OR2 o0(aGtB, gtS, eqS);
    
    shift27 shiftY(.A(numYTemp), .shiftAmount(shiftAmount), .B(numYShift));
    assign numY = {numYShift[26:1], stickyBit};

    mux8 m0(.A(expA), .B(expB), .sel(lt), .Y(expAlign));
    mux8 m1(.A(expB), .B(expA), .sel(lt), .Y(expD1));
    sub8  expSub(.A(expAlign), .B(expD1), .D(shiftAmount), .bOut());

    getSticky_27 sticky(numYTemp, shiftAmount[4:0], stickyBit);

    AND2 a0(eqSel, eq, aGtB);
    OR2  o1(signSel, eqSel, gt);
    MUX2 m3(.A(signB), .B(signA), .sel(signSel), .Y(signX));
    MUX2 m4(.A(signA), .B(signB), .sel(signSel), .Y(signY));

    mux27 m5(.A({sigB, 3'd0}), .B({sigA, 3'd0}), .sel(signSel), .Y(numX)); 
    mux27 m6(.A({sigA, 3'd0}), .B({sigB, 3'd0}), .sel(signSel), .Y(numYTemp)); 

endmodule

//27 bit adder/subtractor
module addSub 
(
	input  logic [26:0] X, Y,
	input  logic        signX, signY, sameSign, 
	input  logic [7:0]  expAlign,
	output logic [26:0] sum,
	output logic 	    cOut, zero
);
    logic [26:0] nY, tcY, yVal;
    logic xEqY, diffSign, cOutS, cOutA, expEq;

    sub27 subXY(.A(X), .B(Y), .D(tcY), .bOut(cOutS));

    mux27 m0(.A(tcY), .B(yVal), .sel(sameSign), .Y(sum));
    MUX2  m1(.A(cOutS), .B(cOutA), .sel(sameSign), .Y(cOut));

    add27 addXY(.S(yVal), .Co(cOutA), .A(X), .B(Y));

    equal27 eq0(.A(X), .B(Y), .eq(xEqY));
    INV i1(diffSign, sameSign);
    AND2 a0(zero, xEqY, diffSign);
endmodule

//normalizes result of addition subtraction if needed
module nomalizeSum
(
	input  logic [7:0]  expAlign,
	input  logic [26:0] sum,
	input  logic 	    cOut,
	output logic [7:0]  expNorm, 
	output logic [26:0] sumNorm,
    output logic 	    underflow, nOver
);
    logic [26:0] sumRShift, sumLShift, sumMux;
    logic [4:0] lead0; // num of leading zeroes
    logic [7:0] expMux, expSub, expOne;
    logic under, ldEq0, ldNeq, eqFF, nOut, uSel, newSticky;

    OR2 o0(newSticky, sum[0], sum[1]);

    LeadingZeros_27 lead(sum, lead0);

    shift27Left shiftL(.A(sum), .shiftAmount(lead0), .B(sumLShift));

    addOne8 exp1(.A(expAlign), .B(expOne), .cOut());

    sub8 expS(.A(expAlign), .B({3'd0, lead0}), .D(expSub), .bOut(under));

    equalZero5 e0(.A(lead0), .eq(ldEq0));
    INV i0(ldNeq, ldEq0);
    INV i1(nOut, cOut);
    AND2 a0(uSel, ldNeq, nOut);

    MUX2 m0(.A(1'b0), .B(under), .sel(uSel), .Y(underflow));

    equalFF8 e1(.A(expNorm), .eq(eqFF));
    MUX2 m1(.A(1'b0), .B(eqFF), .sel(cOut), .Y(nOver));

    mux8 m2(.A(expMux), .B(expOne), .sel(cOut), .Y(expNorm));
    mux8 m3(.A(expAlign), .B(expSub), .sel(ldNeq), .Y(expMux));

    mux27 m4(.A(sumMux), .B({cOut, sum[26:2], newSticky}), .sel(cOut), .Y(sumNorm));
    mux27 m5(.A(sum), .B(sumLShift), .sel(ldNeq), .Y(sumMux));

endmodule

//implements real rounding, can be used for addition and multiplication
module realRounding
(
	input  logic [7:0]  expNorm,
	input  logic [26:0] sumNorm,
	output logic [7:0]  expRound,
	output logic [23:0] sumRound,     
	output logic 	    roundOverflow 
);
    logic r1, r2, r3, //guard and sticky bits for rounding
          nR1, nR2, nR3, tAnd, nSum, rAnd, rOr, rAnd1, rOver, eqFF,
	            rOut, // carry out of rounding
	      truncate, roundUp, one00;
    logic [23:0] roundAdd, sumR0;
    logic [7:0] expAdd, expR0;

    assign r1 = sumNorm[2];
    assign r2 = sumNorm[1];
    assign r3 = sumNorm[0];

    INV i0(nR1, r1);
    INV i1(nR2, r2);
    INV i2(nR3, r3);
    INV i3(nSum, sumNorm[3]);

    addOne24 add0(.A(sumNorm[26:3]), .B(roundAdd), .cOut(rOut)); //make this faster?
    addOne8  add1(.A(expNorm), .B(expAdd), .cOut());

    AND3 a0(one00, r1, nR2, nR3);
    AND2 a1(tAnd, one00, nSum);
    OR2  o0(truncate, nR1, tAnd);

    AND2 a2(rAnd, one00,  sumNorm[3]);
    OR2  o1(rOr, r2, r3);
    AND2 a3(rAnd1, r1, rOr);
    OR2  o2(roundUp, rAnd1, rAnd);

    mux24  m0(.A(roundAdd), .B({rOut, roundAdd[23:1]}), .sel(rOut), .Y(sumR0));
    mux8   m1(.A(expNorm), .B(expAdd), .sel(rOut), .Y(expR0));
    equalFF8 c0(.A(expAdd), .eq(eqFF));
    AND2   a4(rOver, rOut, eqFF);
    MUX2   mR(.A(rOver), .B(1'b0), .sel(truncate), .Y(roundOverflow));

    mux24  m2(.A(sumR0), .B(sumNorm[26:3]), .sel(truncate), .Y(sumRound));
    mux8   m3(.A(expR0), .B(expNorm), .sel(truncate), .Y(expRound));

    
endmodule

//result adjustment for addition
module addAdjust
(
	input  logic  underflow, roundOverflow, zero, nOver,
                     nan, infA, infB,
	input  logic [23:0] sumRound,
	input  logic [7:0]  expRound,
	input  logic        signX, sameSign,
	output logic [31:0] floatFinal
);
    logic diffSign, nanInf, nanRes, infR0, infRes, zeroRes;
    logic [31:0] mux0, mux1;

    INV i0(diffSign, sameSign);
    AND3 a0(nanInf, infA, infB, diffSign);

    OR2 o0(nanRes, nan, nanInf);
    OR2 o1(infR0, roundOverflow, nOver);
    OR3 o2(infRes, infR0, infB, infA);
    OR2 o3(zeroRes, underflow, zero);

    mux32 m0(.A(mux0), .B({signX, 8'hFF, 23'h7FFFFF}), .sel(nanRes), .Y(floatFinal));
    mux32 m1(.A(mux1), .B({signX, 8'hFF, 23'd0}), .sel(infRes), .Y(mux0));
    mux32 m2(.A({signX, expRound, sumRound[22:0]}), .B(32'd0), .sel(zeroRes), .Y(mux1));

endmodule


//24-bit multiplier
module multiplier
( 
	input  logic [23:0] sigA, sigB,
	input  logic [7:0]  expA, expB,
	input  logic 	    signA, signB, sameSign,
	output logic [26:0] mult,
	output logic [7:0]  expM,
	output logic 	    signM, mOverflow, mUnderflow, mOut
);
    logic [47:0] M;
	logic [8:0] expTemp;
    logic [7:0] expAdd;
	logic stickyBit, expCo, eq, gt; // gtEq, nEA, nEB;

	INV i0(signM, sameSign);
        
	add8 expAdd0(.S(expAdd), .Co(expCo), .A(expA), .B(expB));
    sub9  expSub(.A({expCo, expAdd}), .B(9'd127), .D(expTemp), .bOut());
    assign expM = expTemp[7:0];

    compare9 expOver (.A({expCo, expAdd}), .B(9'b1_0111_1110), .eq(eq), .lt(), .gt(gt));
    compare9 expUnder(.A({expCo, expAdd}), .B(9'b0_0111_1111), .eq(), .lt(mUnderflow), .gt());
    OR2 o0(mOverflow, eq, gt);

	//multiplication logic
	mult_24 multi(M, sigA, sigB);
	getSticky_27 sticky(M[26:0], 5'd20, stickyBit);
	assign mOut = M[47];
	assign mult = {M[46:21], stickyBit};

endmodule

//normalizes result of multiplication
module normalizeMult
(
	input  logic [26:0] mult,
	input  logic [7:0]  expM,
	input  logic        mOut,
        output logic [26:0] multNorm,
	output logic [7:0]  expMNorm,
	output logic	    mNOver
);
    logic newSticky; 
    OR2 o0(newSticky, mult[0], mult[1]);

    logic [7:0] expMAdd;
    addOne8 a0(.B(expMAdd), .cOut(), .A(expM));

    mux27  m0(.A(mult), .B({mOut, mult[26:2], newSticky}), .sel(mOut), .Y(multNorm));
    mux8   m1(.A(expM), .B(expMAdd), .sel(mOut), .Y(expMNorm));

    equalFF8 e0(.A(expMNorm), .eq(mNOver)); 

endmodule

//result adjustment for mult
module multAdjust
(
	input logic mOverflow, mNOver, mROver, 
	      nan, infA, infB, mUnderflow,
	input logic [23:0] multRound,
	input logic [7:0]  expRM,
	input logic        signM, sameSign,	
	output logic [31:0] floatFinal
);
    logic diffSign, nanInf, nanRes, infR0, infR1, infRes, zeroRes, nUnder, over, mZero;
    logic [31:0] mux0, mux1;

    equalZero8 eq0(.A(expRM), .eq(mZero));

    INV i0(diffSign, sameSign);
    AND3 a0(nanInf, infA, infB, diffSign);

    INV i1(nUnder, mUnderflow);

    OR2 o0(nanRes, nan, nanInf);
    OR2 o4(over, mROver, mNOver);
    AND2 a4(infR1, nUnder, over);
    OR2 o1(infR0, mOverflow, infR1);
    OR3 o2(infRes, infR0, infB, infA);
    OR2 o3(zeroRes, mUnderflow, mZero);

    mux32 m0(.A(mux0), .B({signM, 8'hFF, 23'h7FFFFF}), .sel(nanRes), .Y(floatFinal));
    mux32 m1(.A(mux1), .B({signM, 8'hFF, 23'd0}), .sel(infRes), .Y(mux0));
    mux32 m2(.A({signM, expRM, multRound[22:0]}), .B(32'd0), .sel(zeroRes), .Y(mux1));
     
endmodule
