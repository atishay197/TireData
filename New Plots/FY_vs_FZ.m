% Tire data Round 5
% Atishay 21/04/14
W = 0;
g = 0; % just initializing...
% p = [8 10 12 14] {psi}
% ia = [0 2 4] {degrees}
% sa = [0 -3 -6] 
% fx = [0 1] positive negetive
% code or data (most probably) faulty for negetive fx
p = 10; ia = 4; fx = 0; %preffered value 0
k = 4;
% degree of polynomial in polyfit
minFZ = 150;
maxFZ = 1700;
%minimum and maximum value of Normal force to be plotted and evaluated
%for polyfit
polyacc = 10000; 
% polyfit accuracy
sparam = 0.9;
%accuracy of smoothened curve [0 1]
%closer to 1 is more accurate curve
fp = 0.65;
% do not change any data/code/punctuation(anything) after this....
l = W * 9.8;
% degree of polyni]omial to which the curve is fitted
% minSA and maxSA is the range of SA on X axis while plotting
t =importdata('B1464run14.dat'); 
% importing data for run 14
u =importdata('B1464run15.dat');
% importing data for run 15
names = t.textdata{2}; 
% creating names of individual matrices
t.data(89521:145199,:) = u.data(1:55679,:);
% combining data of run 14 and 15 for easy eavluation 
clear u;
%clearing up memory space
for n=1:21
   [name,names] = strtok(names);
   eval([upper(name) '=t.data(:,n);']);
end
%creating individual matrices
P = P/6.89475729;
%converting pressure into psi for easy evaluation
%no warmup data 
size = length(P);
FZ = -FZ;
for i = 8:2:14
    P(:,i) = zeros(1,size);
    y = P <= i+0.5 & P >= i-0.5;
    P(:,i) = y(:,1); 
end
% creating true false array for different values of pressure
clear i y;
for i = -4:4
    i = i+6;
    IA(:,i) = zeros(1,size);
    y = IA <= i-6+0.4 & IA >= i-6-0.4;
    IA(:,i) = y(:,1); 
    clear i y;
end
% creating true false array for different values of Camber
clear i y;
% true false matrix creation for different IA,P,FZ done...
    e1 = SA(:,1)<=-0.5 & SA(:,1)>=-1.5 ;
    e2 = SA(:,1)<=-1.5 & SA(:,1)>=-2.5 ;
    e3 = SA(:,1)<=-2.5 & SA(:,1)>=-3.5 ;
    e4 = SA(:,1)<=-3.5 & SA(:,1)>=-4.5 ;
    e5 = SA(:,1)<=-4.5 & SA(:,1)>=-5.5 ;
    e6 = SA(:,1)<=-5.5 & SA(:,1)>=-6.5 ;
    e7 = SA(:,1)<=-6.5 & SA(:,1)>=-7.5 ;
    e8 = SA(:,1)<=-7.5 & SA(:,1)>=-8.5 ;
    e9 = SA(:,1)<=-8.5 & SA(:,1)>=-9.5 ;
    e10 = SA(:,1)<=-9.5 & SA(:,1)>=-10.5 ;
    e11 = SA(:,1)<=-10.5 & SA(:,1)>=-11.5 ;
    e12 = SA(:,1)<=-11.5 & SA(:,1)>=-12.5 ;
if fx == 0
    f = FY(:,1)>= 300;
elseif fx == 1
    f = FY(:,1)<= 0;
else
    msgbox('check the value of fx','error')
end

r1 = FZ >= 190 & FZ <= 270;
r2 = FZ >= 430 & FZ <= 490;
r3 = FZ >= 630 & FZ <= 730;
r4 = FZ >= 1040 & FZ <= 1210;
r5 = FZ >= 1480 & FZ <= 1690;
range = r1 | r2 | r3 | r4 ;

[FX(:,1)] = fp * [FX(:,1)];
% Calspan friction coefficient
    if p == 8
        a = P(:,8);    
    elseif p == 10
        a = P(:,10);
    elseif p == 12;
        a = P(:,12);
    elseif p == 14
        a = P(:,14);
    else
         msgbox('check value of p','error')
    end
    if ia == 0   
        b = IA (:,6);
    elseif ia == 2   
        b = IA (:,8);
    elseif ia == 4
        b = IA (:,10);
    else
          msgbox('check value of ia','error')
    end
    
    clf;
    NFX = -NFX;
    
    d1 = a & b & f & p & e1 & range;
    x1 = [FZ(d1,1)];
    size1 = length(x1);
    y1 = [FY(d1,1)];
    p1 = polyfit(x1,y1,9);
    X11 = linspace(minFZ,maxFZ,polyacc);
    X1 = polyval(p1,X11);
    
    d2 = a & b & f & p & e2 & range;
    x2 = [FZ(d2,1)];
    size2 = length(x2);
    y2 = [FY(d2,1)];
    p2 = polyfit(x2,y2,9);
    X12 = linspace(minFZ,maxFZ,polyacc);
    X2 = polyval(p2,X12);
    
    d3 = a & b & f & e3;
    x3 = [FZ(d3,1)];
    y3 = [FY(d3,1)];
    p3 = polyfit(x3,y3,k);
    X13 = linspace(minFZ,maxFZ,polyacc);
    X3 = polyval(p3,X13);
    
    d4 = a & b & f & e4;
    x4 = [FZ(d4,1)];
    y4 = [FY(d4,1)];
    p4 = polyfit(x4,y4,k);
    X14 = linspace(minFZ,maxFZ,polyacc);
    X4 = polyval(p4,X14);
    
    d5 = a & b & f & e5;
    x5 = [FZ(d5,1)];
    y5 = [FY(d5,1)];
    p5 = polyfit(x5,y5,k);
    X15 = linspace(minFZ,maxFZ,polyacc);
    X5 = polyval(p5,X15);
    
    d6 = a & b & f & e6;
    x6 = [FZ(d6,1)];
    y6 = [FY(d6,1)];
    p6 = polyfit(x6,y6,k);
    X16 = linspace(minFZ,maxFZ,polyacc);
    X6 = polyval(p6,X16);
    
    d7 = a & b & f & e7;
    x7 = [FZ(d7,1)];
    y7 = [FY(d7,1)];
    p7 = polyfit(x7,y7,k);
    X17 = linspace(minFZ,maxFZ,polyacc);
    X7 = polyval(p7,X17);
    
    d8 = a & b & f & e8;
    x8 = [FZ(d8,1)];
    y8 = [FY(d8,1)];
    p8 = polyfit(x8,y8,k);
    X18 = linspace(minFZ,maxFZ,polyacc);
    X8 = polyval(p8,X18);
    
    d9 = a & b & f & e9;
    x9 = [FZ(d9,1)];
    y9 = [FY(d9,1)];
    p9 = polyfit(x9,y9,k);
    X19 = linspace(minFZ,maxFZ,polyacc);
    X9 = polyval(p9,X19);
    
    d10 = a & b & f & e10;
    x10 = [FZ(d10,1)];
    y10 = [FY(d10,1)];
    p10 = polyfit(x10,y10,k);
    X110 = linspace(minFZ,maxFZ,polyacc);
    X10 = polyval(p10,X110);
    
    d11 = a & b & f & e11;
    x11 = [FZ(d11,1)];
    y11 = [FY(d11,1)];
    p11 = polyfit(x11,y11,k);
    X111 = linspace(minFZ,maxFZ,polyacc);
    X11 = polyval(p11,X111);
    
    d12 = a & b & f & e12;
    x12 = [FZ(d12,1)];
    y12 = [FY(d12,1)];
    p12 = polyfit(x12,y12,k);
    X112 = linspace(minFZ,maxFZ,polyacc);
    X12 = polyval(p12,X112);
    
    hold on;
    plot (X11,X1,X12,X2,X13,X3,X14,X4,X15,X5,X16,X6,X17,X7,'--',X18,X8,'--',X19,X9,'--',X110,X10,'--',X111,X11,'--',X112,X12,'--');
    plot (x1,y1,'.',x2,y2,'.',x3,y3,'.',x4,y4,'.',x5,y5,'.',x6,y6,'.',x7,y7,'.',x8,y8,'.',x9,y9,'.',x10,y10,'.',x11,y11,'.',x12,y12,'.');
    xlim([minFZ maxFZ]);
    grid on;
    hold off;
    xlabel ('Normal Force (N)');
    ylabel ('Lateral Force (N)');
    legend ('Slip Angle 1°','Slip Angle 2°','Slip Angle 3°','Slip Angle 4°','Slip Angle 5°','Slip Angle 6°','Slip Angle 7°','Slip Angle 8°','Slip Angle 9°','Slip Angle 10°','Slip Angle 11°','Slip Angle 12°','Location','NorthWest');
    gname1 = sprintf('Actual data\nPressure:%.0fpsi Camber:%.0f°',p,ia);
    title(gname1);
    %}
    %{
    d = a & b & e & f;
    x = [FZ(d,1)];
    y = [FX(d,1)];
    p = polyfit(x,y,k);
    X1 = linspace(minFZ,maxFZ,polyacc);
    X = polyval(p,X1);
    plot (X1,X,'g');
    xlim([minFZ maxFZ]);
    grid on;
    hold off;
    xlabel ('Normal Force (N)');
    ylabel ('Longitudnal Force (N)');
    legend ('Normal Force vs Longitudnal Force','Location','NorthEast');
    gname1 = sprintf('Actual data\nPressure:%.0fpsi Camber:%.0f°',p,ia);
    title(gname1);
    %}
    clear all;    
