module iris_nn(
    clk,
    input_layer1, input_layer2, input_layer3, input_layer4,
    layer1_n1w1, layer1_n1w2, layer1_n1w3, layer1_n1w4,
    layer1_n2w1, layer1_n2w2, layer1_n2w3, layer1_n2w4,
    layer1_n3w1, layer1_n3w2, layer1_n3w3, layer1_n3w4,
    layer1_n4w1, layer1_n4w2, layer1_n4w3, layer1_n4w4,
    layer1_n5w1, layer1_n5w2, layer1_n5w3, layer1_n5w4,
    layer1_n6w1, layer1_n6w2, layer1_n6w3, layer1_n6w4,
    layer2_n7w1, layer2_n7w2, layer2_n7w3, layer2_n7w4, layer2_n7w5, layer2_n7w6,
    layer2_n8w1, layer2_n8w2, layer2_n8w3, layer2_n8w4, layer2_n8w5, layer2_n8w6,
    layer2_n9w1, layer2_n9w2, layer2_n9w3, layer2_n9w4, layer2_n9w5, layer2_n9w6,
    layer1_bias1, layer1_bias2, layer1_bias3, layer1_bias4, layer1_bias5, layer1_bias6,
    layer2_bias1, layer2_bias2, layer2_bias3,
    neuron7_output, neuron8_output, neuron9_output
);

    parameter SIG_WIDTH = 23;
    parameter EXP_WIDTH = 8;

    input clk;
    input [SIG_WIDTH+EXP_WIDTH : 0] input_layer1;
    input [SIG_WIDTH+EXP_WIDTH : 0] input_layer2;
    input [SIG_WIDTH+EXP_WIDTH : 0] input_layer3;
    input [SIG_WIDTH+EXP_WIDTH : 0] input_layer4;

    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n1w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n1w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n1w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n1w4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n2w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n2w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n2w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n2w4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n3w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n3w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n3w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n3w4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n4w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n4w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n4w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n4w4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n5w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n5w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n5w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n5w4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n6w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n6w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n6w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_n6w4;

    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n7w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n7w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n7w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n7w4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n7w5;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n7w6;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n8w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n8w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n8w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n8w4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n8w5;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n8w6;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n9w1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n9w2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n9w3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n9w4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n9w5;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_n9w6;

    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_bias1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_bias2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_bias3;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_bias4;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_bias5;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer1_bias6;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_bias1;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_bias2;
    input [SIG_WIDTH+EXP_WIDTH : 0] layer2_bias3;

    output [SIG_WIDTH+EXP_WIDTH : 0] neuron7_output;
    output [SIG_WIDTH+EXP_WIDTH : 0] neuron8_output;
    output [SIG_WIDTH+EXP_WIDTH : 0] neuron9_output;

    wire [SIG_WIDTH+EXP_WIDTH : 0] neuron1_output;
    wire [SIG_WIDTH+EXP_WIDTH : 0] neuron2_output;
    wire [SIG_WIDTH+EXP_WIDTH : 0] neuron3_output;
    wire [SIG_WIDTH+EXP_WIDTH : 0] neuron4_output;
    wire [SIG_WIDTH+EXP_WIDTH : 0] neuron5_output;
    wire [SIG_WIDTH+EXP_WIDTH : 0] neuron6_output;


    /**************************/
    /* Layer 1                */
    /**************************/

    ////    neuron 1
    logic [31:0] n1Mul1, n1Mul2, n1Mul3, n1Mul4, n1Add1, n1Add2, n1Add3, n1In;
    logic [7:0]  t1;
    FPU n1M1(.A_reg(layer1_n1w1), .B_reg(input_layer1), .Y_reg(n1Mul1), .SEL_reg(1'b1), .clk);
    FPU n1M2(.A_reg(layer1_n1w2), .B_reg(input_layer2), .Y_reg(n1Mul2), .SEL_reg(1'b1), .clk);
    FPU n1M3(.A_reg(layer1_n1w3), .B_reg(input_layer3), .Y_reg(n1Mul3), .SEL_reg(1'b1), .clk);
    FPU n1M4(.A_reg(layer1_n1w4), .B_reg(input_layer4), .Y_reg(n1Mul4), .SEL_reg(1'b1), .clk);

    FPU n1A1(.A_reg(n1Mul1), .B_reg(n1Mul2), .Y_reg(n1Add1), .SEL_reg(1'b0), .clk);
    FPU n1A2(.A_reg(n1Mul3), .B_reg(n1Mul4), .Y_reg(n1Add2), .SEL_reg(1'b0), .clk);
    FPU n1A3(.A_reg(n1Add1), .B_reg(n1Add2), .Y_reg(n1Add3), .SEL_reg(1'b0), .clk);
    FPU n1A4(.A_reg(n1Add3), .B_reg(layer1_bias1), .Y_reg(n1In), .SEL_reg(1'b0), .clk);
    sigmoid n1S(n1In, t1,3'b000, neuron1_output);
    ////    neuron 2
    logic [31:0] n2Mul1, n2Mul2, n2Mul3, n2Mul4, n2Add1, n2Add2, n2Add3, n2In;
    logic [7:0]  t1;
    FPU n2M1(.A_reg(layer1_n2w1), .B_reg(input_layer1), .Y_reg(n2Mul1), .SEL_reg(1'b1), .clk);
    FPU n2M2(.A_reg(layer1_n2w2), .B_reg(input_layer2), .Y_reg(n2Mul2), .SEL_reg(1'b1), .clk);
    FPU n2M3(.A_reg(layer1_n2w3), .B_reg(input_layer3), .Y_reg(n2Mul3), .SEL_reg(1'b1), .clk);
    FPU n2M4(.A_reg(layer1_n2w4), .B_reg(input_layer4), .Y_reg(n2Mul4), .SEL_reg(1'b1), .clk);

    FPU n2A1(.A_reg(n2Mul1), .B_reg(n2Mul2), .Y_reg(n2Add1), .SEL_reg(1'b0), .clk);
    FPU n2A2(.A_reg(n2Mul3), .B_reg(n2Mul4), .Y_reg(n2Add2), .SEL_reg(1'b0), .clk);
    FPU n2A3(.A_reg(n2Add1), .B_reg(n2Add2), .Y_reg(n2Add3), .SEL_reg(1'b0), .clk);
    FPU n2A4(.A_reg(n2Add3), .B_reg(layer1_bias2), .Y_reg(n2In), .SEL_reg(1'b0), .clk);
    sigmoid n2S(n2In, t2,3'b000, neuron2_output);

    ////    neuron 3
    logic [31:0] n3Mul1, n3Mul2, n3Mul3, n3Mul4, n3Add1, n3Add2, n3Add3, n3In;
    logic [7:0]  t3;
    FPU n3M1(.A_reg(layer1_n3w1), .B_reg(input_layer1), .Y_reg(n3Mul1), .SEL_reg(1'b1), .clk);
    FPU n3M2(.A_reg(layer1_n3w2), .B_reg(input_layer2), .Y_reg(n3Mul2), .SEL_reg(1'b1), .clk);
    FPU n3M3(.A_reg(layer1_n3w3), .B_reg(input_layer3), .Y_reg(n3Mul3), .SEL_reg(1'b1), .clk);
    FPU n3M4(.A_reg(layer1_n3w4), .B_reg(input_layer4), .Y_reg(n3Mul4), .SEL_reg(1'b1), .clk);

    FPU n3A1(.A_reg(n3Mul1), .B_reg(n3Mul2), .Y_reg(n3Add1), .SEL_reg(1'b0), .clk);
    FPU n3A2(.A_reg(n3Mul3), .B_reg(n3Mul4), .Y_reg(n3Add2), .SEL_reg(1'b0), .clk);
    FPU n3A3(.A_reg(n3Add1), .B_reg(n3Add2), .Y_reg(n3Add3), .SEL_reg(1'b0), .clk);
    FPU n3A4(.A_reg(n3Add3), .B_reg(layer1_bias3), .Y_reg(n3In), .SEL_reg(1'b0), .clk);
    sigmoid n3S(n3In, t3,3'b000, neuron3_output);

    ////    neuron 4
    logic [31:0] n4Mul1, n4Mul2, n4Mul3, n4Mul4, n4Add1, n4Add2, n4Add3, n4In;
    logic [7:0]  t4;
    FPU n4M1(.A_reg(layer1_n4w1), .B_reg(input_layer1), .Y_reg(n4Mul1), .SEL_reg(1'b1), .clk);
    FPU n4M2(.A_reg(layer1_n4w2), .B_reg(input_layer2), .Y_reg(n4Mul2), .SEL_reg(1'b1), .clk);
    FPU n4M3(.A_reg(layer1_n4w3), .B_reg(input_layer3), .Y_reg(n4Mul3), .SEL_reg(1'b1), .clk);
    FPU n4M4(.A_reg(layer1_n4w4), .B_reg(input_layer4), .Y_reg(n4Mul4), .SEL_reg(1'b1), .clk);

    FPU n4A1(.A_reg(n4Mul1), .B_reg(n4Mul2), .Y_reg(n4Add1), .SEL_reg(1'b0), .clk);
    FPU n4A2(.A_reg(n4Mul3), .B_reg(n4Mul4), .Y_reg(n4Add2), .SEL_reg(1'b0), .clk);
    FPU n4A3(.A_reg(n4Add1), .B_reg(n4Add2), .Y_reg(n4Add3), .SEL_reg(1'b0), .clk);
    FPU n4A4(.A_reg(n4Add3), .B_reg(layer1_bias4), .Y_reg(n4In), .SEL_reg(1'b0), .clk);
    sigmoid n4S(n4In, t4,3'b000, neuron4_output);

    ////    neuron 5
    logic [31:0] n5Mul1, n5Mul2, n5Mul3, n5Mul4, n5Add1, n5Add2, n5Add3, n5In;
    logic [7:0]  t5;
    FPU n5M1(.A_reg(layer1_n5w1), .B_reg(input_layer1), .Y_reg(n5Mul1), .SEL_reg(1'b1), .clk);
    FPU n5M2(.A_reg(layer1_n5w2), .B_reg(input_layer2), .Y_reg(n5Mul2), .SEL_reg(1'b1), .clk);
    FPU n5M3(.A_reg(layer1_n5w3), .B_reg(input_layer3), .Y_reg(n5Mul3), .SEL_reg(1'b1), .clk);
    FPU n5M4(.A_reg(layer1_n5w4), .B_reg(input_layer4), .Y_reg(n5Mul4), .SEL_reg(1'b1), .clk);

    FPU n5A1(.A_reg(n5Mul1), .B_reg(n5Mul2), .Y_reg(n5Add1), .SEL_reg(1'b0), .clk);
    FPU n5A2(.A_reg(n5Mul3), .B_reg(n5Mul4), .Y_reg(n5Add2), .SEL_reg(1'b0), .clk);
    FPU n5A3(.A_reg(n5Add1), .B_reg(n5Add2), .Y_reg(n5Add3), .SEL_reg(1'b0), .clk);
    FPU n5A4(.A_reg(n5Add3), .B_reg(layer1_bias5), .Y_reg(n5In), .SEL_reg(1'b0), .clk);
    sigmoid n5S(n5In, t5,3'b000, neuron5_output);

    ////    neuron 6
    logic [31:0] n6Mul1, n6Mul2, n6Mul3, n6Mul4, n6Add1, n6Add2, n6Add3, n6In;
    logic [7:0]  t6;
    FPU n6M1(.A_reg(layer1_n6w1), .B_reg(input_layer1), .Y_reg(n6Mul1), .SEL_reg(1'b1), .clk);
    FPU n6M2(.A_reg(layer1_n6w2), .B_reg(input_layer2), .Y_reg(n6Mul2), .SEL_reg(1'b1), .clk);
    FPU n6M3(.A_reg(layer1_n6w3), .B_reg(input_layer3), .Y_reg(n6Mul3), .SEL_reg(1'b1), .clk);
    FPU n6M4(.A_reg(layer1_n6w4), .B_reg(input_layer4), .Y_reg(n6Mul4), .SEL_reg(1'b1), .clk);

    FPU n6A1(.A_reg(n6Mul1), .B_reg(n6Mul2), .Y_reg(n6Add1), .SEL_reg(1'b0), .clk);
    FPU n6A2(.A_reg(n6Mul3), .B_reg(n6Mul4), .Y_reg(n6Add2), .SEL_reg(1'b0), .clk);
    FPU n6A3(.A_reg(n6Add1), .B_reg(n6Add2), .Y_reg(n6Add3), .SEL_reg(1'b0), .clk);
    FPU n6A4(.A_reg(n6Add3), .B_reg(layer1_bias6), .Y_reg(n6In), .SEL_reg(1'b0), .clk);
    sigmoid n6S(n6In, t6,3'b000, neuron6_output);

    /**************************/
    /* Layer 2                */
    /**************************/

    /// neuron 7
    logic [31:0] n7Mul1, n7Mul2, n7Mul3, n7Mul4, n7Mul5, n7Mul6, n7Add1, n7Add2, n7Add3, n7Add4, n7Add5, n7In;
    logic [7:0]  t7;
    FPU n7M1(.A_reg(layer2_n7w1), .B_reg(neuron1_output), .Y_reg(n7Mul1), .SEL_reg(1'b1), .clk);
    FPU n7M2(.A_reg(layer2_n7w2), .B_reg(neuron2_output), .Y_reg(n7Mul2), .SEL_reg(1'b1), .clk);
    FPU n7M3(.A_reg(layer2_n7w3), .B_reg(neuron3_output), .Y_reg(n7Mul3), .SEL_reg(1'b1), .clk);
    FPU n7M4(.A_reg(layer2_n7w4), .B_reg(neuron4_output), .Y_reg(n7Mul4), .SEL_reg(1'b1), .clk);
    FPU n7M5(.A_reg(layer2_n7w5), .B_reg(neuron5_output), .Y_reg(n7Mul5), .SEL_reg(1'b1), .clk);
    FPU n7M6(.A_reg(layer2_n7w6), .B_reg(neuron6_output), .Y_reg(n7Mul6), .SEL_reg(1'b1), .clk);

    FPU n7A1(.A_reg(n7Mul1), .B_reg(n7Mul2), .Y_reg(n7Add1), .SEL_reg(1'b0), .clk);
    FPU n7A2(.A_reg(n7Mul3), .B_reg(n7Mul4), .Y_reg(n7Add2), .SEL_reg(1'b0), .clk);
    FPU n7A3(.A_reg(n7Mul5), .B_reg(n7Mul6), .Y_reg(n7Add3), .SEL_reg(1'b0), .clk);
    FPU n7A4(.A_reg(n7Add1), .B_reg(n7Add2), .Y_reg(n7Add4), .SEL_reg(1'b0), .clk);
    FPU n7A5(.A_reg(n7Add3), .B_reg(n7Add4), .Y_reg(n7Add5), .SEL_reg(1'b0), .clk);
    FPU n7A7(.A_reg(n7Add5), .B_reg(layer2_bias1), .Y_reg(n7In), .SEL_reg(1'b0), .clk);
    sigmoid n7S(n7In, t7,3'b000, neuron7_output);

    /// neuron 8
    logic [31:0] n8Mul1, n8Mul2, n8Mul3, n8Mul4, n8Mul5, n8Mul6, n8Add1, n8Add2, n8Add3, n8Add4, n8Add5, n8In;
    logic [7:0]  t8;
    FPU n8M1(.A_reg(layer2_n8w1), .B_reg(neuron1_output), .Y_reg(n8Mul1), .SEL_reg(1'b1), .clk);
    FPU n8M2(.A_reg(layer2_n8w2), .B_reg(neuron2_output), .Y_reg(n8Mul2), .SEL_reg(1'b1), .clk);
    FPU n8M3(.A_reg(layer2_n8w3), .B_reg(neuron3_output), .Y_reg(n8Mul3), .SEL_reg(1'b1), .clk);
    FPU n8M4(.A_reg(layer2_n8w4), .B_reg(neuron4_output), .Y_reg(n8Mul4), .SEL_reg(1'b1), .clk);
    FPU n8M5(.A_reg(layer2_n8w5), .B_reg(neuron5_output), .Y_reg(n8Mul5), .SEL_reg(1'b1), .clk);
    FPU n8M6(.A_reg(layer2_n8w6), .B_reg(neuron6_output), .Y_reg(n8Mul6), .SEL_reg(1'b1), .clk);

    FPU n8A1(.A_reg(n8Mul1), .B_reg(n8Mul2), .Y_reg(n8Add1), .SEL_reg(1'b0), .clk);
    FPU n8A2(.A_reg(n8Mul3), .B_reg(n8Mul4), .Y_reg(n8Add2), .SEL_reg(1'b0), .clk);
    FPU n8A3(.A_reg(n8Mul5), .B_reg(n8Mul6), .Y_reg(n8Add3), .SEL_reg(1'b0), .clk);
    FPU n8A4(.A_reg(n8Add1), .B_reg(n8Add2), .Y_reg(n8Add4), .SEL_reg(1'b0), .clk);
    FPU n8A5(.A_reg(n8Add3), .B_reg(n8Add4), .Y_reg(n8Add5), .SEL_reg(1'b0), .clk);
    FPU n8A7(.A_reg(n8Add5), .B_reg(layer2_bias2), .Y_reg(n8In), .SEL_reg(1'b0), .clk);
    sigmoid n8S(n8In, t8,3'b000, neuron8_output);

    /// neuron 9
    logic [31:0] n9Mul1, n9Mul2, n9Mul3, n9Mul4, n9Mul5, n9Mul6, n9Add1, n9Add2, n9Add3, n9Add4, n9Add5, n9In;
    logic [7:0]  t9;
    FPU n9M1(.A_reg(layer2_n9w1), .B_reg(neuron1_output), .Y_reg(n9Mul1), .SEL_reg(1'b1), .clk);
    FPU n9M2(.A_reg(layer2_n9w2), .B_reg(neuron2_output), .Y_reg(n9Mul2), .SEL_reg(1'b1), .clk);
    FPU n9M3(.A_reg(layer2_n9w3), .B_reg(neuron3_output), .Y_reg(n9Mul3), .SEL_reg(1'b1), .clk);
    FPU n9M4(.A_reg(layer2_n9w4), .B_reg(neuron4_output), .Y_reg(n9Mul4), .SEL_reg(1'b1), .clk);
    FPU n9M5(.A_reg(layer2_n9w5), .B_reg(neuron5_output), .Y_reg(n9Mul5), .SEL_reg(1'b1), .clk);
    FPU n9M6(.A_reg(layer2_n9w6), .B_reg(neuron6_output), .Y_reg(n9Mul6), .SEL_reg(1'b1), .clk);

    FPU n9A1(.A_reg(n9Mul1), .B_reg(n9Mul2), .Y_reg(n9Add1), .SEL_reg(1'b0), .clk);
    FPU n9A2(.A_reg(n9Mul3), .B_reg(n9Mul4), .Y_reg(n9Add2), .SEL_reg(1'b0), .clk);
    FPU n9A3(.A_reg(n9Mul5), .B_reg(n9Mul6), .Y_reg(n9Add3), .SEL_reg(1'b0), .clk);
    FPU n9A4(.A_reg(n9Add1), .B_reg(n9Add2), .Y_reg(n9Add4), .SEL_reg(1'b0), .clk);
    FPU n9A5(.A_reg(n9Add3), .B_reg(n9Add4), .Y_reg(n9Add5), .SEL_reg(1'b0), .clk);
    FPU n9A7(.A_reg(n9Add5), .B_reg(layer2_bias3), .Y_reg(n9In), .SEL_reg(1'b0), .clk);
    sigmoid n9S(n9In, t9,3'b000, neuron9_output);


endmodule
