`define FP_ADD  1'b0
`define FP_MULT 1'b1

`define NAN (32'hFFFFFFFF)


module FPU (Y_reg, A_reg, B_reg, SEL_reg, clk);

    output bit [31:0] Y_reg;
    input  bit [31:0] A_reg, B_reg;
    input  bit        SEL_reg;
    input  bit        clk;

    bit [31:0] A, B, Y;
    bit        SEL;

    // Surrounding Registers to Clock the Design
    always_ff @ (posedge clk) begin
        A <= A_reg;
        B <= B_reg;
        SEL <= SEL_reg;
        Y_reg <= Y;
    end

    logic 	 signA, signB, nan, infA, infB, sameSign;
    logic [7:0]  expA, expB;
    logic [23:0] sigA, sigB;
    float_unpacker uPack (.A, .B, .SEL, .signA, .signB, .expA, .expB, .sigA, .sigB, 
		                  .nan, .infA, .infB, .sameSign);

    logic [7:0] expSel, expSel1; 
    logic [26:0] sumSel;
    logic [23:0] sumSel1;
    logic roundSel;

///////////////////////////////////////////////////////////////////
// Addition
    logic [7:0]  expAlign;
    logic [26:0] numX, numY;
    logic        signX, signY;	
    alignment align (.signA, .signB, .expA, .expB, .sigA, .sigB, .expAlign,
		             .numX, .numY, .signX, .signY);

    logic [26:0] sum;
    logic cOut, zero;
    addSub adder(.X(numX), .Y(numY), .signX, .signY, .expAlign, .sum, .cOut, .zero, .sameSign);

    logic [7:0]  expNorm;
    logic [26:0] sumNorm;
    logic        underflow, nOver;
    nomalizeSum aNorm(.expAlign, .sum, .cOut, .underflow, .nOver, .expNorm, .sumNorm);

    logic [7:0]  expRound;
    logic [23:0] sumRound;
    logic	 roundOverflow; 
    realRounding aRound(.expNorm, .sumNorm, .expRound, .sumRound, .roundOverflow);

    logic [31:0] addFinal;
    addAdjust aAdj(.underflow, .roundOverflow, .zero, .nOver,
                   .nan, .infA, .infB, .sameSign,
		   .sumRound, .expRound, .signX, .floatFinal(addFinal));
///////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////
// Multiplication
    logic [26:0] mult;
    logic [7:0]  expM;
    logic        signM, mOverflow, mUnderflow, mOut, mZero;
    multiplier multi(.sigA, .sigB, .expA, .expB, .signA, .signB, .mult, .expM,
	 	             .signM, .mOverflow, .mUnderflow, .mOut, .sameSign);

    logic [26:0] multNorm;
    logic [7:0]  expMNorm;
    logic 	 mNOver;
    normalizeMult mNorm(.mult, .expM, .mOut, .multNorm, .expMNorm, .mNOver);

    logic [7:0]  expRM;
    logic [23:0] multRound;
    logic 	 mROver;
    realRounding mRound(.expNorm(expMNorm), .sumNorm(multNorm), .expRound(expRM), 
	                    .sumRound(multRound), .roundOverflow(mROver));
    
    logic [31:0] multFinal;
    multAdjust   mAdj(.mOverflow, .mNOver, .mROver, .nan, .infA, .infB, .sameSign, .mUnderflow, 
	                  .multRound, .expRM, .signM, .floatFinal(multFinal));
///////////////////////////////////////////////////////////////////

    // Good luck
    mux32 m0(.A(addFinal), .B(multFinal), .sel(SEL), .Y(Y));

    /*
    // use 1 rounder for less gates
    // using these muxes results in higher delay but smaller area
    realRounding round(.expNorm(expSel), .sumNorm(sumSel), .expRound(expSel1), .sumRound(sumSel1), .roundOverflow(roundSel));
    mux8  m1(.A(expNorm), .B(expMNorm), .sel(SEL), .Y(expSel));
    mux27 m2(.A(sumNorm), .B(multNorm), .sel(SEL), .Y(sumSel));
    */

endmodule : FPU
