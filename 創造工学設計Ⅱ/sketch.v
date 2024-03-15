module vgaOutput(
    input CLOCK,
    input reset,    
    input [4:0] btn,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen,
    output Hsync,
    output Vsync
    ); 
    reg [1:0]  dinCnt=0;
    reg [11:0] numCnt=0;
    reg [4:0] btnJudge;
    reg resetJudge;
    reg [1:0] divClk;
    reg [4:0] buff;
    reg resetBuff;
    reg allow;
    reg [19:0] temp_count;
    wire up,down,right,left;
    
    parameter [9:0] WIDTH = 640;
    parameter [9:0] HEIGHT = 480;
    parameter [9:0] HORIZON_START_SYNCH = 16;
    parameter [9:0] HORIZON_END_SYNCH = HORIZON_START_SYNCH + 96;
    parameter [9:0] HORIZON_START_DISP = HORIZON_END_SYNCH + 48;
    parameter [9:0] HORIZON_END_DISP = HORIZON_START_DISP + WIDTH;
    parameter [9:0] VERTICAL_START_SYNCH = 10;
    parameter [9:0] VERTICAL_END_SYNCH = VERTICAL_START_SYNCH + 2;
    parameter [9:0] VERTICAL_START_DISP = VERTICAL_END_SYNCH + 33;
    parameter [9:0] VERTICAL_END_DISP = VERTICAL_START_DISP + HEIGHT;

    reg [9:0] horiz_cnt;
    reg [9:0] vertc_cnt;
   
    initial begin
        divClk = 0;
        allow = 0;
        horiz_cnt = 0;
        vertc_cnt = 0;
    end
    
    always @(posedge CLOCK) begin
        btnJudge<=btn;
        buff <= btnJudge;
    end
    
    assign up = btnJudge[0] & ~buff[0];
	assign down = btnJudge[1] & ~buff[1];
	assign right = btnJudge[2] & ~buff[2];
	assign left = btnJudge[3] & ~buff[3];
	assign plot=btnJudge[4] & ~buff[4];
	
    
    always @(posedge CLOCK) begin
        if(divClk==3) begin
            divClk <= 0;
            allow <= 1;
        end else begin
            divClk <= divClk + 1;
            allow <= 0;
        end
    end
    
    always @(posedge CLOCK) begin
        if(allow==1) begin
            horiz_cnt <= (horiz_cnt == HORIZON_END_DISP-1) ? 0 : horiz_cnt+1;
        end
    end
    
    always @(posedge CLOCK) begin
        if(allow==1) begin
            if(horiz_cnt == HORIZON_END_DISP-1) begin
                vertc_cnt <= (vertc_cnt == VERTICAL_END_DISP-1) ? 0 : vertc_cnt+1;
            end
        end
    end
    
    parameter [9:0] HORIZON_LEFT_LINE = HORIZON_START_DISP+140;
    parameter [9:0] HORIZON_RIGHT_LINE = HORIZON_START_DISP+500;
    parameter [9:0] VERTICAL_UPPER_LINE = VERTICAL_START_DISP+60;
    parameter [9:0] VERTICAL_UNDER_LINE = VERTICAL_START_DISP+420;
    parameter [3:0] LINE_WIDTH = 1;
    parameter [9:0] FIELD_WIDTH = 360;
    parameter [9:0] FIELD_HEIGHT = 360;
    parameter [9:0] BOX_LENGTH = FIELD_WIDTH/9;
    reg [11:0] data;
    reg [11:0] colorOut;
    reg [9:0] myX=HORIZON_START_DISP+320;
    reg [9:0] myY=VERTICAL_START_DISP+400;
    reg [9:0] myXCopy1=0,myXCopy2=0,myXCopy3=0,myXCopy4=0,myXCopy5=0,myXCopy6=0,myXCopy7=0,myXCopy8=0,myXCopy9=0,myXCopy10=0,myXCopy11=0,myXCopy12=0,myXCopy13=0,myXCopy14=0,myXCopy15=0,myXCopy16=0,myXCopy17=0,myXCopy18=0,myXCopy19=0,myXCopy20=0,myXCopy21=0,myXCopy22=0,myXCopy23=0,myXCopy24=0,myXCopy25=0,myXCopy26=0,myXCopy27=0,myXCopy28=0,myXCopy29=0,myXCopy30=0,myXCopy31=0,myXCopy32=0,myXCopy33=0,myXCopy34=0,myXCopy35=0,myXCopy36=0,myXCopy37=0,myXCopy38=0,myXCopy39=0,myXCopy40=0,myXCopy41=0,myXCopy42=0,myXCopy43=0,myXCopy44=0,myXCopy45=0,myXCopy46=0,myXCopy47=0,myXCopy48=0,myXCopy49=0,myXCopy50=0,myXCopy51=0,myXCopy52=0,myXCopy53=0,myXCopy54=0,myXCopy55=0,myXCopy56=0,myXCopy57=0,myXCopy58=0,myXCopy59=0,myXCopy60=0,myXCopy61=0,myXCopy62=0,myXCopy63=0,myXCopy64=0,myXCopy65=0,myXCopy66=0,myXCopy67=0,myXCopy68=0,myXCopy69=0,myXCopy70=0,myXCopy71=0,myXCopy72=0,myXCopy73=0,myXCopy74=0,myXCopy75=0,myXCopy76=0,myXCopy77=0,myXCopy78=0,myXCopy79=0,myXCopy80=0,myXCopy81=0,myXCopy82=0,myXCopy83,myXCopy84=0,myXCopy85=0,myXCopy86=0,myXCopy87=0,myXCopy88=0,myXCopy89=0,myXCopy90=0,myXCopy91=0,myXCopy92=0,myXCopy93=0,myXCopy94=0,myXCopy95=0,myXCopy96=0,myXCopy97=0,myXCopy98=0,myXCopy99=0,myXCopy100=0;
    reg [9:0] myYCopy1=0,myYCopy2=0,myYCopy3=0,myYCopy4=0,myYCopy5=0,myYCopy6=0,myYCopy7=0,myYCopy8=0,myYCopy9=0,myYCopy10=0,myYCopy11=0,myYCopy12=0,myYCopy13=0,myYCopy14=0,myYCopy15=0,myYCopy16=0,myYCopy17=0,myYCopy18=0,myYCopy19=0,myYCopy20=0,myYCopy21=0,myYCopy22=0,myYCopy23=0,myYCopy24=0,myYCopy25=0,myYCopy26=0,myYCopy27=0,myYCopy28=0,myYCopy29=0,myYCopy30=0,myYCopy31=0,myYCopy32=0,myYCopy33=0,myYCopy34=0,myYCopy35=0,myYCopy36=0,myYCopy37=0,myYCopy38=0,myYCopy39=0,myYCopy40=0,myYCopy41=0,myYCopy42=0,myYCopy43=0,myYCopy44=0,myYCopy45=0,myYCopy46=0,myYCopy47=0,myYCopy48=0,myYCopy49=0,myYCopy50=0,myYCopy51=0,myYCopy52=0,myYCopy53=0,myYCopy54=0,myYCopy55=0,myYCopy56=0,myYCopy57=0,myYCopy58=0,myYCopy59=0,myYCopy60=0,myYCopy61=0,myYCopy62=0,myYCopy63=0,myYCopy64=0,myYCopy65=0,myYCopy66=0,myYCopy67=0,myYCopy68=0,myYCopy69=0,myYCopy70=0,myYCopy71=0,myYCopy72=0,myYCopy73=0,myYCopy74=0,myYCopy75=0,myYCopy76=0,myYCopy77=0,myYCopy78=0,myYCopy79=0,myYCopy80=0,myYCopy81=0,myYCopy82=0,myYCopy83,myYCopy84=0,myYCopy85=0,myYCopy86=0,myYCopy87=0,myYCopy88=0,myYCopy89=0,myYCopy90=0,myYCopy91=0,myYCopy92=0,myYCopy93=0,myYCopy94=0,myYCopy95=0,myYCopy96=0,myYCopy97=0,myYCopy98=0,myYCopy99=0,myYCopy100=0;
    
    reg [9:0] brushDic=5;
    parameter [11:0] BLACK = 12'b0000_0000_0000;
    parameter [11:0] WHITE = 12'b1111_1111_1111;
    wire fieldLine;
    wire myPlotCopy1,myPlotCopy2myPlotCopy3,myPlotCopy4,myPlotCopy5,myPlotCopy6,myPlotCopy7,myPlotCopy8,myPlotCopy9,myPlotCopy10,myPlotCopy11,myPlotCopy12,myPlotCopy13,myPlotCopy14,myPlotCopy15,myPlotCopy16,myPlotCopy17,myPlotCopy18,myPlotCopy19,myPlotCopy20;
    wire myLine; 
    wire horizLines[9:0], vertcLines[9:0], horizLine, vertcLine;
    
    
  
	always @(posedge CLOCK)//‚±‚±‚©‚çƒ`ƒƒƒ^ƒŠƒ“ƒOœ‹Ž
	begin
			temp_count <= temp_count + 1;
	end
	
	always @(posedge CLOCK)
		if (temp_count == 0)begin
			btnJudge<=btn;
			resetJudge<=reset;
		end
			
	always @(posedge CLOCK)
	begin
			buff <= btnJudge;
			resetBuff<=resetJudge;
	end
	
	assign res=resetJudge& ~resetBuff;

    always @(posedge CLOCK)
	begin
	myXCopy1=690;
	myYCopy1=100;
	
	myXCopy2=0;
	myYCopy2=0;
	
	myXCopy3=0;
	myYCopy3=0;
	
	myXCopy4=0;
	myYCopy4=0;
	
	myXCopy5=0;
	myYCopy5=0;
	
	myXCopy6=0;
	myYCopy6=0;
	
	myXCopy7=0;
	myYCopy7=0;
	
	myXCopy8=0;
	myYCopy8=0;
	
	myXCopy9=0;
	myYCopy9=0;
	
	myXCopy10=0;
	myYCopy10=0;
	
	myXCopy11=0;
	myYCopy11=0;
	
	myXCopy12=0;
	myYCopy12=0;
	
	myXCopy13=0;
	myYCopy13=0;
	
	myXCopy14=0;
	myYCopy14=0;
	
	myXCopy15=0;
	myYCopy15=0;
	
	myXCopy16=0;
	myYCopy16=0;
	
	myXCopy17=0;
	myYCopy17=0;
	
	myXCopy18=0;
	myYCopy18=0;
	
	myXCopy19=0;
	myYCopy19=0;
	
	myXCopy20=0;
	myYCopy20=0;
	
	myXCopy21=0;
	myYCopy21=0;
	
	myXCopy22=0;
	myYCopy22=0;
	
	myXCopy23=0;
	myYCopy23=0;
	
	myXCopy24=0;
	myYCopy24=0;
	
	myXCopy25=0;
	myYCopy25=0;
	
	myXCopy26=0;
	myYCopy26=0;
	
	myXCopy27=0;
	myYCopy27=0;
	
	myXCopy28=0;
	myYCopy28=0;
	
	myXCopy29=0;
	myYCopy29=0;
	
	myXCopy30=0;
	myYCopy30=0;
	
	myXCopy31=0;
	myYCopy31=0;
	
	myXCopy32=0;
	myYCopy32=0;
	
	myXCopy33=0;
	myYCopy33=0;
	
	myXCopy34=0;
	myYCopy34=0;
	
	myXCopy35=0;
	myYCopy35=0;
	
	myXCopy36=0;
	myYCopy36=0;
	
	myXCopy37=0;
	myYCopy37=0;
	
	myXCopy38=0;
	myYCopy38=0;
	
	myXCopy39=0;
	myYCopy39=0;
	
	myXCopy40=0;
	myYCopy40=0;
	
	myXCopy41=0;
	myYCopy41=0;
	
	myXCopy42=0;
	myYCopy42=0;
	
	myXCopy43=0;
	myYCopy43=0;
	
	myXCopy44=0;
	myYCopy44=0;
	
	myXCopy45=0;
	myYCopy45=0;
	
	myXCopy46=0;
	myYCopy46=0;
	
	myXCopy47=0;
	myYCopy47=0;
	
	myXCopy48=0;
	myYCopy48=0;
	
	myXCopy49=0;
	myYCopy49=0;
	
	myXCopy50=0;
	myYCopy50=0;
	
	myXCopy51=0;
	myYCopy51=0;
	
	myXCopy52=0;
	myYCopy52=0;
	
	myXCopy53=0;
	myYCopy53=0;
	
	myXCopy54=0;
	myYCopy54=0;
	
	myXCopy55=0;
	myYCopy55=0;
	
	myXCopy56=0;
	myYCopy56=0;
	
	myXCopy57=0;
	myYCopy57=0;
	
	myXCopy58=0;
	myYCopy58=0;
	
	myXCopy59=0;
	myYCopy59=0;
	
	myXCopy60=0;
	myYCopy60=0;
	
	myXCopy61=0;
	myYCopy61=0;
	
	myXCopy62=0;
	myYCopy62=0;
	
	myXCopy63=0;
	myYCopy63=0;
	
	myXCopy64=0;
	myYCopy64=0;
	
	myXCopy65=0;
	myYCopy65=0;
	
	myXCopy66=0;
	myYCopy66=0;
	
	myXCopy67=0;
	myYCopy67=0;
	
	myXCopy68=0;
	myYCopy68=0;
	
	myXCopy69=0;
	myYCopy69=0;
	
	myXCopy70=0;
	myYCopy70=0;
	
	myXCopy71=0;
	myYCopy71=0;
	
	myXCopy72=0;
	myYCopy72=0;
	
	myXCopy73=0;
	myYCopy73=0;
	
	myXCopy74=0;
	myYCopy74=0;
	
	myXCopy75=0;
	myYCopy75=0;
	
	myXCopy76=0;
	myYCopy76=0;
	
	myXCopy77=0;
	myYCopy77=0;
	
	myXCopy78=0;
	myYCopy78=0;
	
	myXCopy79=0;
	myYCopy79=0;
	
	myXCopy80=0;
	myYCopy80=0;
	
	myXCopy81=0;
	myYCopy81=0;
	
	myXCopy82=0;
	myYCopy82=0;
	
	myXCopy83=0;
	myYCopy83=0;
	
	myXCopy84=0;
	myYCopy84=0;
	
	myXCopy85=0;
	myYCopy85=0;
	
	myXCopy86=0;
	myYCopy86=0;
	
	myXCopy87=0;
	myYCopy87=0;
	
	myXCopy88=0;
	myYCopy88=0;
	
	myXCopy89=0;
	myYCopy89=0;
	
	myXCopy90=0;
	myYCopy90=0;
	
	myXCopy91=0;
	myYCopy91=0;
	
	myXCopy92=0;
	myYCopy92=0;
	
	myXCopy93=0;
	myYCopy93=0;
	
	myXCopy94=0;
	myYCopy94=0;
	
	myXCopy95=0;
	myYCopy95=0;
	
	myXCopy96=0;
	myYCopy96=0;
	
	myXCopy97=0;
	myYCopy97=0;
	
	myXCopy98=0;
	myYCopy98=0;
	
	myXCopy99=0;
	myYCopy99=0;
	
	myXCopy100=0;
	myYCopy100=0;

	end
	
    assign horizLine = horizLines[0] | horizLines[1] | horizLines[2] | horizLines[3] | horizLines[4] | horizLines[5] | horizLines[6] | horizLines[7] | horizLines[8] | horizLines[9];
    assign vertcLine = vertcLines[0] | vertcLines[1] | vertcLines[2] | vertcLines[3] | vertcLines[4] | vertcLines[5] | vertcLines[6] | vertcLines[7] | vertcLines[8] | vertcLines[9];
    assign fieldLine = horizLine | vertcLine;
    assign myPlotCopy1=(horiz_cnt>=myXCopy1-brushDic)&(horiz_cnt<=myXCopy1+brushDic)&(vertc_cnt>=myYCopy1-brushDic)&(vertc_cnt<=myYCopy1+brushDic);
    assign myPlotCopy2=(horiz_cnt>=myXCopy2-brushDic)&(horiz_cnt<=myXCopy2+brushDic)&(vertc_cnt>=myYCopy2-brushDic)&(vertc_cnt<=myYCopy2+brushDic);
    assign myPlotCopy3=(horiz_cnt>=myXCopy3-brushDic)&(horiz_cnt<=myXCopy3+brushDic)&(vertc_cnt>=myYCopy3-brushDic)&(vertc_cnt<=myYCopy3+brushDic);
    assign myPlotCopy4=(horiz_cnt>=myXCopy4-brushDic)&(horiz_cnt<=myXCopy4+brushDic)&(vertc_cnt>=myYCopy4-brushDic)&(vertc_cnt<=myYCopy4+brushDic);
    assign myPlotCopy5=(horiz_cnt>=myXCopy5-brushDic)&(horiz_cnt<=myXCopy5+brushDic)&(vertc_cnt>=myYCopy5-brushDic)&(vertc_cnt<=myYCopy5+brushDic);
    assign myPlotCopy6=(horiz_cnt>=myXCopy6-brushDic)&(horiz_cnt<=myXCopy6+brushDic)&(vertc_cnt>=myYCopy6-brushDic)&(vertc_cnt<=myYCopy6+brushDic);
    assign myPlotCopy7=(horiz_cnt>=myXCopy7-brushDic)&(horiz_cnt<=myXCopy7+brushDic)&(vertc_cnt>=myYCopy7-brushDic)&(vertc_cnt<=myYCopy7+brushDic);
    assign myPlotCopy8=(horiz_cnt>=myXCopy8-brushDic)&(horiz_cnt<=myXCopy8+brushDic)&(vertc_cnt>=myYCopy8-brushDic)&(vertc_cnt<=myYCopy8+brushDic);
    assign myPlotCopy9=(horiz_cnt>=myXCopy9-brushDic)&(horiz_cnt<=myXCopy9+brushDic)&(vertc_cnt>=myYCopy9-brushDic)&(vertc_cnt<=myYCopy9+brushDic);
    assign myPlotCopy10=(horiz_cnt>=myXCopy10-brushDic)&(horiz_cnt<=myXCopy10+brushDic)&(vertc_cnt>=myYCopy10-brushDic)&(vertc_cnt<=myYCopy10+brushDic);    
    assign myPlotCopy11=(horiz_cnt>=myXCopy11-brushDic)&(horiz_cnt<=myXCopy11+brushDic)&(vertc_cnt>=myYCopy11-brushDic)&(vertc_cnt<=myYCopy11+brushDic);
    assign myPlotCopy12=(horiz_cnt>=myXCopy12-brushDic)&(horiz_cnt<=myXCopy12+brushDic)&(vertc_cnt>=myYCopy12-brushDic)&(vertc_cnt<=myYCopy12+brushDic);
    assign myPlotCopy13=(horiz_cnt>=myXCopy13-brushDic)&(horiz_cnt<=myXCopy13+brushDic)&(vertc_cnt>=myYCopy13-brushDic)&(vertc_cnt<=myYCopy13+brushDic);
    assign myPlotCopy14=(horiz_cnt>=myXCopy14-brushDic)&(horiz_cnt<=myXCopy14+brushDic)&(vertc_cnt>=myYCopy14-brushDic)&(vertc_cnt<=myYCopy14+brushDic);
    assign myPlotCopy15=(horiz_cnt>=myXCopy15-brushDic)&(horiz_cnt<=myXCopy15+brushDic)&(vertc_cnt>=myYCopy15-brushDic)&(vertc_cnt<=myYCopy15+brushDic);
    assign myPlotCopy16=(horiz_cnt>=myXCopy16-brushDic)&(horiz_cnt<=myXCopy16+brushDic)&(vertc_cnt>=myYCopy16-brushDic)&(vertc_cnt<=myYCopy16+brushDic);
    assign myPlotCopy17=(horiz_cnt>=myXCopy17-brushDic)&(horiz_cnt<=myXCopy17+brushDic)&(vertc_cnt>=myYCopy17-brushDic)&(vertc_cnt<=myYCopy17+brushDic);
    assign myPlotCopy18=(horiz_cnt>=myXCopy18-brushDic)&(horiz_cnt<=myXCopy18+brushDic)&(vertc_cnt>=myYCopy18-brushDic)&(vertc_cnt<=myYCopy18+brushDic);
    assign myPlotCopy19=(horiz_cnt>=myXCopy19-brushDic)&(horiz_cnt<=myXCopy19+brushDic)&(vertc_cnt>=myYCopy19-brushDic)&(vertc_cnt<=myYCopy19+brushDic);
    assign myPlotCopy20=(horiz_cnt>=myXCopy20-brushDic)&(horiz_cnt<=myXCopy20+brushDic)&(vertc_cnt>=myYCopy20-brushDic)&(vertc_cnt<=myYCopy20+brushDic); 
    assign myPlotCopy21=(horiz_cnt>=myXCopy21-brushDic)&(horiz_cnt<=myXCopy21+brushDic)&(vertc_cnt>=myYCopy21-brushDic)&(vertc_cnt<=myYCopy21+brushDic);
    assign myPlotCopy22=(horiz_cnt>=myXCopy22-brushDic)&(horiz_cnt<=myXCopy22+brushDic)&(vertc_cnt>=myYCopy22-brushDic)&(vertc_cnt<=myYCopy22+brushDic);
    assign myPlotCopy23=(horiz_cnt>=myXCopy23-brushDic)&(horiz_cnt<=myXCopy23+brushDic)&(vertc_cnt>=myYCopy23-brushDic)&(vertc_cnt<=myYCopy23+brushDic);
    assign myPlotCopy24=(horiz_cnt>=myXCopy24-brushDic)&(horiz_cnt<=myXCopy24+brushDic)&(vertc_cnt>=myYCopy24-brushDic)&(vertc_cnt<=myYCopy24+brushDic);
    assign myPlotCopy25=(horiz_cnt>=myXCopy25-brushDic)&(horiz_cnt<=myXCopy25+brushDic)&(vertc_cnt>=myYCopy25-brushDic)&(vertc_cnt<=myYCopy25+brushDic);
    assign myPlotCopy26=(horiz_cnt>=myXCopy26-brushDic)&(horiz_cnt<=myXCopy26+brushDic)&(vertc_cnt>=myYCopy26-brushDic)&(vertc_cnt<=myYCopy26+brushDic);
    assign myPlotCopy27=(horiz_cnt>=myXCopy27-brushDic)&(horiz_cnt<=myXCopy27+brushDic)&(vertc_cnt>=myYCopy27-brushDic)&(vertc_cnt<=myYCopy27+brushDic);
    assign myPlotCopy28=(horiz_cnt>=myXCopy28-brushDic)&(horiz_cnt<=myXCopy28+brushDic)&(vertc_cnt>=myYCopy28-brushDic)&(vertc_cnt<=myYCopy28+brushDic);
    assign myPlotCopy29=(horiz_cnt>=myXCopy29-brushDic)&(horiz_cnt<=myXCopy29+brushDic)&(vertc_cnt>=myYCopy29-brushDic)&(vertc_cnt<=myYCopy29+brushDic);
    
    assign myPlotCopy30=(horiz_cnt>=myXCopy30-brushDic)&(horiz_cnt<=myXCopy30+brushDic)&(vertc_cnt>=myYCopy30-brushDic)&(vertc_cnt<=myYCopy30+brushDic);   
    assign myPlotCopy31=(horiz_cnt>=myXCopy31-brushDic)&(horiz_cnt<=myXCopy31+brushDic)&(vertc_cnt>=myYCopy31-brushDic)&(vertc_cnt<=myYCopy31+brushDic);
    assign myPlotCopy32=(horiz_cnt>=myXCopy32-brushDic)&(horiz_cnt<=myXCopy32+brushDic)&(vertc_cnt>=myYCopy32-brushDic)&(vertc_cnt<=myYCopy32+brushDic);  
    assign myPlotCopy33=(horiz_cnt>=myXCopy33-brushDic)&(horiz_cnt<=myXCopy33+brushDic)&(vertc_cnt>=myYCopy33-brushDic)&(vertc_cnt<=myYCopy33+brushDic);   
    assign myPlotCopy34=(horiz_cnt>=myXCopy34-brushDic)&(horiz_cnt<=myXCopy34+brushDic)&(vertc_cnt>=myYCopy34-brushDic)&(vertc_cnt<=myYCopy34+brushDic);
    assign myPlotCopy35=(horiz_cnt>=myXCopy35-brushDic)&(horiz_cnt<=myXCopy35+brushDic)&(vertc_cnt>=myYCopy35-brushDic)&(vertc_cnt<=myYCopy35+brushDic); 
    assign myPlotCopy36=(horiz_cnt>=myXCopy36-brushDic)&(horiz_cnt<=myXCopy36+brushDic)&(vertc_cnt>=myYCopy36-brushDic)&(vertc_cnt<=myYCopy36+brushDic);   
    assign myPlotCopy37=(horiz_cnt>=myXCopy37-brushDic)&(horiz_cnt<=myXCopy37+brushDic)&(vertc_cnt>=myYCopy37-brushDic)&(vertc_cnt<=myYCopy37+brushDic);
    assign myPlotCopy38=(horiz_cnt>=myXCopy38-brushDic)&(horiz_cnt<=myXCopy38+brushDic)&(vertc_cnt>=myYCopy38-brushDic)&(vertc_cnt<=myYCopy38+brushDic); 
    assign myPlotCopy39=(horiz_cnt>=myXCopy39-brushDic)&(horiz_cnt<=myXCopy39+brushDic)&(vertc_cnt>=myYCopy39-brushDic)&(vertc_cnt<=myYCopy39+brushDic);   
    assign myPlotCopy40=(horiz_cnt>=myXCopy40-brushDic)&(horiz_cnt<=myXCopy40+brushDic)&(vertc_cnt>=myYCopy40-brushDic)&(vertc_cnt<=myYCopy40+brushDic);
    
    assign myPlotCopy41=(horiz_cnt>=myXCopy41-brushDic)&(horiz_cnt<=myXCopy41+brushDic)&(vertc_cnt>=myYCopy41-brushDic)&(vertc_cnt<=myYCopy41+brushDic);
    assign myPlotCopy42=(horiz_cnt>=myXCopy42-brushDic)&(horiz_cnt<=myXCopy42+brushDic)&(vertc_cnt>=myYCopy42-brushDic)&(vertc_cnt<=myYCopy42+brushDic);  
    assign myPlotCopy43=(horiz_cnt>=myXCopy43-brushDic)&(horiz_cnt<=myXCopy43+brushDic)&(vertc_cnt>=myYCopy43-brushDic)&(vertc_cnt<=myYCopy43+brushDic);   
    assign myPlotCopy44=(horiz_cnt>=myXCopy44-brushDic)&(horiz_cnt<=myXCopy44+brushDic)&(vertc_cnt>=myYCopy44-brushDic)&(vertc_cnt<=myYCopy44+brushDic);
    assign myPlotCopy45=(horiz_cnt>=myXCopy45-brushDic)&(horiz_cnt<=myXCopy45+brushDic)&(vertc_cnt>=myYCopy45-brushDic)&(vertc_cnt<=myYCopy45+brushDic); 
    assign myPlotCopy46=(horiz_cnt>=myXCopy46-brushDic)&(horiz_cnt<=myXCopy46+brushDic)&(vertc_cnt>=myYCopy46-brushDic)&(vertc_cnt<=myYCopy46+brushDic);   
    assign myPlotCopy47=(horiz_cnt>=myXCopy47-brushDic)&(horiz_cnt<=myXCopy47+brushDic)&(vertc_cnt>=myYCopy47-brushDic)&(vertc_cnt<=myYCopy47+brushDic);
    assign myPlotCopy48=(horiz_cnt>=myXCopy48-brushDic)&(horiz_cnt<=myXCopy48+brushDic)&(vertc_cnt>=myYCopy48-brushDic)&(vertc_cnt<=myYCopy48+brushDic); 
    assign myPlotCopy49=(horiz_cnt>=myXCopy49-brushDic)&(horiz_cnt<=myXCopy49+brushDic)&(vertc_cnt>=myYCopy49-brushDic)&(vertc_cnt<=myYCopy49+brushDic);   
    assign myPlotCopy50=(horiz_cnt>=myXCopy50-brushDic)&(horiz_cnt<=myXCopy50+brushDic)&(vertc_cnt>=myYCopy50-brushDic)&(vertc_cnt<=myYCopy50+brushDic);
    
    assign myPlotCopy51=(horiz_cnt>=myXCopy51-brushDic)&(horiz_cnt<=myXCopy51+brushDic)&(vertc_cnt>=myYCopy51-brushDic)&(vertc_cnt<=myYCopy51+brushDic);
    assign myPlotCopy52=(horiz_cnt>=myXCopy52-brushDic)&(horiz_cnt<=myXCopy52+brushDic)&(vertc_cnt>=myYCopy52-brushDic)&(vertc_cnt<=myYCopy52+brushDic);  
    assign myPlotCopy53=(horiz_cnt>=myXCopy53-brushDic)&(horiz_cnt<=myXCopy53+brushDic)&(vertc_cnt>=myYCopy53-brushDic)&(vertc_cnt<=myYCopy53+brushDic);   
    assign myPlotCopy54=(horiz_cnt>=myXCopy54-brushDic)&(horiz_cnt<=myXCopy54+brushDic)&(vertc_cnt>=myYCopy54-brushDic)&(vertc_cnt<=myYCopy54+brushDic);
    assign myPlotCopy55=(horiz_cnt>=myXCopy55-brushDic)&(horiz_cnt<=myXCopy55+brushDic)&(vertc_cnt>=myYCopy55-brushDic)&(vertc_cnt<=myYCopy55+brushDic); 
    assign myPlotCopy56=(horiz_cnt>=myXCopy56-brushDic)&(horiz_cnt<=myXCopy56+brushDic)&(vertc_cnt>=myYCopy56-brushDic)&(vertc_cnt<=myYCopy56+brushDic);   
    assign myPlotCopy57=(horiz_cnt>=myXCopy57-brushDic)&(horiz_cnt<=myXCopy57+brushDic)&(vertc_cnt>=myYCopy57-brushDic)&(vertc_cnt<=myYCopy57+brushDic);
    assign myPlotCopy58=(horiz_cnt>=myXCopy58-brushDic)&(horiz_cnt<=myXCopy58+brushDic)&(vertc_cnt>=myYCopy58-brushDic)&(vertc_cnt<=myYCopy58+brushDic); 
    assign myPlotCopy59=(horiz_cnt>=myXCopy59-brushDic)&(horiz_cnt<=myXCopy59+brushDic)&(vertc_cnt>=myYCopy59-brushDic)&(vertc_cnt<=myYCopy59+brushDic);   
    assign myPlotCopy60=(horiz_cnt>=myXCopy60-brushDic)&(horiz_cnt<=myXCopy60+brushDic)&(vertc_cnt>=myYCopy60-brushDic)&(vertc_cnt<=myYCopy60+brushDic);
    
    assign myPlotCopy61=(horiz_cnt>=myXCopy61-brushDic)&(horiz_cnt<=myXCopy61+brushDic)&(vertc_cnt>=myYCopy61-brushDic)&(vertc_cnt<=myYCopy61+brushDic);
    assign myPlotCopy62=(horiz_cnt>=myXCopy62-brushDic)&(horiz_cnt<=myXCopy62+brushDic)&(vertc_cnt>=myYCopy62-brushDic)&(vertc_cnt<=myYCopy62+brushDic);  
    assign myPlotCopy63=(horiz_cnt>=myXCopy63-brushDic)&(horiz_cnt<=myXCopy63+brushDic)&(vertc_cnt>=myYCopy63-brushDic)&(vertc_cnt<=myYCopy63+brushDic);   
    assign myPlotCopy64=(horiz_cnt>=myXCopy64-brushDic)&(horiz_cnt<=myXCopy64+brushDic)&(vertc_cnt>=myYCopy64-brushDic)&(vertc_cnt<=myYCopy64+brushDic);
    assign myPlotCopy65=(horiz_cnt>=myXCopy65-brushDic)&(horiz_cnt<=myXCopy65+brushDic)&(vertc_cnt>=myYCopy65-brushDic)&(vertc_cnt<=myYCopy65+brushDic); 
    assign myPlotCopy66=(horiz_cnt>=myXCopy66-brushDic)&(horiz_cnt<=myXCopy66+brushDic)&(vertc_cnt>=myYCopy66-brushDic)&(vertc_cnt<=myYCopy66+brushDic);   
    assign myPlotCopy67=(horiz_cnt>=myXCopy67-brushDic)&(horiz_cnt<=myXCopy67+brushDic)&(vertc_cnt>=myYCopy67-brushDic)&(vertc_cnt<=myYCopy67+brushDic);
    assign myPlotCopy68=(horiz_cnt>=myXCopy68-brushDic)&(horiz_cnt<=myXCopy68+brushDic)&(vertc_cnt>=myYCopy68-brushDic)&(vertc_cnt<=myYCopy68+brushDic); 
    assign myPlotCopy69=(horiz_cnt>=myXCopy69-brushDic)&(horiz_cnt<=myXCopy69+brushDic)&(vertc_cnt>=myYCopy69-brushDic)&(vertc_cnt<=myYCopy69+brushDic);   
    assign myPlotCopy70=(horiz_cnt>=myXCopy70-brushDic)&(horiz_cnt<=myXCopy70+brushDic)&(vertc_cnt>=myYCopy70-brushDic)&(vertc_cnt<=myYCopy70+brushDic);
    
    assign myPlotCopy61=(horiz_cnt>=myXCopy61-brushDic)&(horiz_cnt<=myXCopy61+brushDic)&(vertc_cnt>=myYCopy61-brushDic)&(vertc_cnt<=myYCopy61+brushDic);
    assign myPlotCopy62=(horiz_cnt>=myXCopy62-brushDic)&(horiz_cnt<=myXCopy62+brushDic)&(vertc_cnt>=myYCopy62-brushDic)&(vertc_cnt<=myYCopy62+brushDic);  
    assign myPlotCopy63=(horiz_cnt>=myXCopy63-brushDic)&(horiz_cnt<=myXCopy63+brushDic)&(vertc_cnt>=myYCopy63-brushDic)&(vertc_cnt<=myYCopy63+brushDic);   
    assign myPlotCopy64=(horiz_cnt>=myXCopy64-brushDic)&(horiz_cnt<=myXCopy64+brushDic)&(vertc_cnt>=myYCopy64-brushDic)&(vertc_cnt<=myYCopy64+brushDic);
    assign myPlotCopy65=(horiz_cnt>=myXCopy65-brushDic)&(horiz_cnt<=myXCopy65+brushDic)&(vertc_cnt>=myYCopy65-brushDic)&(vertc_cnt<=myYCopy65+brushDic); 
    assign myPlotCopy66=(horiz_cnt>=myXCopy66-brushDic)&(horiz_cnt<=myXCopy66+brushDic)&(vertc_cnt>=myYCopy66-brushDic)&(vertc_cnt<=myYCopy66+brushDic);   
    assign myPlotCopy67=(horiz_cnt>=myXCopy67-brushDic)&(horiz_cnt<=myXCopy67+brushDic)&(vertc_cnt>=myYCopy67-brushDic)&(vertc_cnt<=myYCopy67+brushDic);
    assign myPlotCopy68=(horiz_cnt>=myXCopy68-brushDic)&(horiz_cnt<=myXCopy68+brushDic)&(vertc_cnt>=myYCopy68-brushDic)&(vertc_cnt<=myYCopy68+brushDic); 
    assign myPlotCopy69=(horiz_cnt>=myXCopy69-brushDic)&(horiz_cnt<=myXCopy69+brushDic)&(vertc_cnt>=myYCopy69-brushDic)&(vertc_cnt<=myYCopy69+brushDic);   
    assign myPlotCopy70=(horiz_cnt>=myXCopy70-brushDic)&(horiz_cnt<=myXCopy70+brushDic)&(vertc_cnt>=myYCopy70-brushDic)&(vertc_cnt<=myYCopy70+brushDic);
    
    assign myPlotCopy71=(horiz_cnt>=myXCopy71-brushDic)&(horiz_cnt<=myXCopy71+brushDic)&(vertc_cnt>=myYCopy71-brushDic)&(vertc_cnt<=myYCopy71+brushDic);
    assign myPlotCopy72=(horiz_cnt>=myXCopy72-brushDic)&(horiz_cnt<=myXCopy72+brushDic)&(vertc_cnt>=myYCopy72-brushDic)&(vertc_cnt<=myYCopy72+brushDic);  
    assign myPlotCopy73=(horiz_cnt>=myXCopy73-brushDic)&(horiz_cnt<=myXCopy73+brushDic)&(vertc_cnt>=myYCopy73-brushDic)&(vertc_cnt<=myYCopy73+brushDic);   
    assign myPlotCopy74=(horiz_cnt>=myXCopy74-brushDic)&(horiz_cnt<=myXCopy74+brushDic)&(vertc_cnt>=myYCopy74-brushDic)&(vertc_cnt<=myYCopy74+brushDic);
    assign myPlotCopy75=(horiz_cnt>=myXCopy75-brushDic)&(horiz_cnt<=myXCopy75+brushDic)&(vertc_cnt>=myYCopy75-brushDic)&(vertc_cnt<=myYCopy75+brushDic); 
    assign myPlotCopy76=(horiz_cnt>=myXCopy76-brushDic)&(horiz_cnt<=myXCopy76+brushDic)&(vertc_cnt>=myYCopy76-brushDic)&(vertc_cnt<=myYCopy76+brushDic);   
    assign myPlotCopy77=(horiz_cnt>=myXCopy77-brushDic)&(horiz_cnt<=myXCopy77+brushDic)&(vertc_cnt>=myYCopy77-brushDic)&(vertc_cnt<=myYCopy77+brushDic);
    assign myPlotCopy78=(horiz_cnt>=myXCopy78-brushDic)&(horiz_cnt<=myXCopy78+brushDic)&(vertc_cnt>=myYCopy78-brushDic)&(vertc_cnt<=myYCopy78+brushDic); 
    assign myPlotCopy79=(horiz_cnt>=myXCopy79-brushDic)&(horiz_cnt<=myXCopy79+brushDic)&(vertc_cnt>=myYCopy79-brushDic)&(vertc_cnt<=myYCopy79+brushDic);   
    assign myPlotCopy80=(horiz_cnt>=myXCopy80-brushDic)&(horiz_cnt<=myXCopy80+brushDic)&(vertc_cnt>=myYCopy80-brushDic)&(vertc_cnt<=myYCopy80+brushDic);
    
    assign myPlotCopy81=(horiz_cnt>=myXCopy81-brushDic)&(horiz_cnt<=myXCopy81+brushDic)&(vertc_cnt>=myYCopy81-brushDic)&(vertc_cnt<=myYCopy81+brushDic);
    assign myPlotCopy82=(horiz_cnt>=myXCopy82-brushDic)&(horiz_cnt<=myXCopy82+brushDic)&(vertc_cnt>=myYCopy82-brushDic)&(vertc_cnt<=myYCopy82+brushDic);  
    assign myPlotCopy83=(horiz_cnt>=myXCopy83-brushDic)&(horiz_cnt<=myXCopy83+brushDic)&(vertc_cnt>=myYCopy83-brushDic)&(vertc_cnt<=myYCopy83+brushDic);   
    assign myPlotCopy84=(horiz_cnt>=myXCopy84-brushDic)&(horiz_cnt<=myXCopy84+brushDic)&(vertc_cnt>=myYCopy84-brushDic)&(vertc_cnt<=myYCopy84+brushDic);
    assign myPlotCopy85=(horiz_cnt>=myXCopy85-brushDic)&(horiz_cnt<=myXCopy85+brushDic)&(vertc_cnt>=myYCopy85-brushDic)&(vertc_cnt<=myYCopy85+brushDic); 
    assign myPlotCopy86=(horiz_cnt>=myXCopy86-brushDic)&(horiz_cnt<=myXCopy86+brushDic)&(vertc_cnt>=myYCopy86-brushDic)&(vertc_cnt<=myYCopy86+brushDic);   
    assign myPlotCopy87=(horiz_cnt>=myXCopy87-brushDic)&(horiz_cnt<=myXCopy87+brushDic)&(vertc_cnt>=myYCopy87-brushDic)&(vertc_cnt<=myYCopy87+brushDic);
    assign myPlotCopy88=(horiz_cnt>=myXCopy88-brushDic)&(horiz_cnt<=myXCopy88+brushDic)&(vertc_cnt>=myYCopy88-brushDic)&(vertc_cnt<=myYCopy88+brushDic); 
    assign myPlotCopy89=(horiz_cnt>=myXCopy89-brushDic)&(horiz_cnt<=myXCopy89+brushDic)&(vertc_cnt>=myYCopy89-brushDic)&(vertc_cnt<=myYCopy89+brushDic);   
    assign myPlotCopy90=(horiz_cnt>=myXCopy90-brushDic)&(horiz_cnt<=myXCopy90+brushDic)&(vertc_cnt>=myYCopy90-brushDic)&(vertc_cnt<=myYCopy90+brushDic);
    
    assign myPlotCopy91=(horiz_cnt>=myXCopy91-brushDic)&(horiz_cnt<=myXCopy91+brushDic)&(vertc_cnt>=myYCopy91-brushDic)&(vertc_cnt<=myYCopy91+brushDic);
    assign myPlotCopy92=(horiz_cnt>=myXCopy92-brushDic)&(horiz_cnt<=myXCopy92+brushDic)&(vertc_cnt>=myYCopy92-brushDic)&(vertc_cnt<=myYCopy92+brushDic);  
    assign myPlotCopy93=(horiz_cnt>=myXCopy93-brushDic)&(horiz_cnt<=myXCopy93+brushDic)&(vertc_cnt>=myYCopy93-brushDic)&(vertc_cnt<=myYCopy93+brushDic);   
    assign myPlotCopy94=(horiz_cnt>=myXCopy94-brushDic)&(horiz_cnt<=myXCopy94+brushDic)&(vertc_cnt>=myYCopy94-brushDic)&(vertc_cnt<=myYCopy94+brushDic);
    assign myPlotCopy95=(horiz_cnt>=myXCopy95-brushDic)&(horiz_cnt<=myXCopy95+brushDic)&(vertc_cnt>=myYCopy95-brushDic)&(vertc_cnt<=myYCopy95+brushDic); 
    assign myPlotCopy96=(horiz_cnt>=myXCopy96-brushDic)&(horiz_cnt<=myXCopy96+brushDic)&(vertc_cnt>=myYCopy96-brushDic)&(vertc_cnt<=myYCopy96+brushDic);   
    assign myPlotCopy97=(horiz_cnt>=myXCopy97-brushDic)&(horiz_cnt<=myXCopy97+brushDic)&(vertc_cnt>=myYCopy97-brushDic)&(vertc_cnt<=myYCopy97+brushDic);
    assign myPlotCopy98=(horiz_cnt>=myXCopy98-brushDic)&(horiz_cnt<=myXCopy98+brushDic)&(vertc_cnt>=myYCopy98-brushDic)&(vertc_cnt<=myYCopy98+brushDic); 
    assign myPlotCopy99=(horiz_cnt>=myXCopy99-brushDic)&(horiz_cnt<=myXCopy99+brushDic)&(vertc_cnt>=myYCopy99-brushDic)&(vertc_cnt<=myYCopy99+brushDic);   
    assign myPlotCopy100=(horiz_cnt>=myXCopy100-brushDic)&(horiz_cnt<=myXCopy100+brushDic)&(vertc_cnt>=myYCopy100-brushDic)&(vertc_cnt<=myYCopy100+brushDic);
    
    always @(posedge CLOCK) begin
        if((horiz_cnt >= HORIZON_START_DISP) & (vertc_cnt >= VERTICAL_START_DISP)) begin
            if(fieldLine|myLine|myPlotCopy1|myPlotCopy2|myPlotCopy3|myPlotCopy4|myPlotCopy5|myPlotCopy6|myPlotCopy7|myPlotCopy8|myPlotCopy9|myPlotCopy10|myPlotCopy11|myPlotCopy12|myPlotCopy13|myPlotCopy14|myPlotCopy15|myPlotCopy16|myPlotCopy17|myPlotCopy18|myPlotCopy19|myPlotCopy20|myPlotCopy21|myPlotCopy22|myPlotCopy23|myPlotCopy24|myPlotCopy25|myPlotCopy26|myPlotCopy27|myPlotCopy28|myPlotCopy29|myPlotCopy30|myPlotCopy31|myPlotCopy32|myPlotCopy33|myPlotCopy34|myPlotCopy35|myPlotCopy36|myPlotCopy37|myPlotCopy38|myPlotCopy39|myPlotCopy40|myPlotCopy41|myPlotCopy42|myPlotCopy43|myPlotCopy44|myPlotCopy45|myPlotCopy46|myPlotCopy47|myPlotCopy48|myPlotCopy49|myPlotCopy50|myPlotCopy51|myPlotCopy52|myPlotCopy53|myPlotCopy54|myPlotCopy55|myPlotCopy56|myPlotCopy57|myPlotCopy58|myPlotCopy59|myPlotCopy60|myPlotCopy61|myPlotCopy62|myPlotCopy63|myPlotCopy64|myPlotCopy65|myPlotCopy66|myPlotCopy67|myPlotCopy68|myPlotCopy69|myPlotCopy70|myPlotCopy71|myPlotCopy72|myPlotCopy73|myPlotCopy74|myPlotCopy75|myPlotCopy76|myPlotCopy77|myPlotCopy78|myPlotCopy79|myPlotCopy80|myPlotCopy81|myPlotCopy82|myPlotCopy83|myPlotCopy84|myPlotCopy85|myPlotCopy86|myPlotCopy87|myPlotCopy88|myPlotCopy89|myPlotCopy90|myPlotCopy91|myPlotCopy92|myPlotCopy93|myPlotCopy94|myPlotCopy95|myPlotCopy96|myPlotCopy97|myPlotCopy98|myPlotCopy99|myPlotCopy100) begin
                data = BLACK;
            end else if(horiz_cnt==HORIZON_END_DISP-1) begin
                data = BLACK;
            end else begin
                data = WHITE;
            end
        end
    end 
    
    assign {vgaRed, vgaGreen, vgaBlue} = data;
    assign Hsync = ~((HORIZON_START_SYNCH <= horiz_cnt) & (horiz_cnt < HORIZON_END_SYNCH));
    assign Vsync = ~((VERTICAL_START_SYNCH <= vertc_cnt) & (vertc_cnt < VERTICAL_END_SYNCH));

endmodule
