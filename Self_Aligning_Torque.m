% Tire data Round 5
% Atishay 05/09/14
% MZ vs SA for different pressure, camber and loads
W = 20;
g = 0; % just initializing...
% Types of plotting that can be done
% g=1 P FZ and IA constant single plot              g=2 IA FZ constant P variable
% g=3 P FZ constant IA variable                     g=4 IA P constant FZ variable
% remove % from any one of the following
% DO NOT CHANGE g change other parameters as desired
% p = [8 10 12 14] {psi}
% ia = [0 1 2 3 4] {degrees}
% W > 5kg , W < 180kg
 g = 1, ia = 4, W = 110;
% g = 2, p = 10, W = 60;
k = 8;
% degree of polynomial in polyfit
minSA = -8;
maxSA = 8;
%minimum and maximum value of SA to be plotted and evaluated
%for polyfit
polyacc = 100; 
% polyfit accuracy
sparam = 0.9;
%accuracy of smoothened curve [0 1]
%closer to 1 is more accurate curve
fp = 0.65 ;
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
P(1:9298,1) = 0;
P(61549:66168,1) = 0;
%removing warmup
grbg1 = SA <= -3.93 & SA >= -3.95;
grbg2 = SA <= 0.08 & SA >= 0.06;
grbg = grbg1 | grbg2 ;
grbg = ~grbg;
%removing garbage values 
size = length(P);
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
FZ = -FZ;
for i = 1:7
    FZ(:,i+1) = zeros(1,size);
    y = FZ <= 225*i+105 & FZ >= 225*i-105;
    FZ(:,i+1) = y(:,1);
    clear i;
end
% creating true false array for different values of Vertical load
clear i y;
% true false matrix creation for different IA,P,FZ done...
if l >= 50 & l < 330
        c = FZ(:,2);
    elseif l >= 330 & l < 580
        c = FZ(:,3);
    elseif l >= 580 & l < 905
        c = FZ(:,4);
    elseif l >= 905 & l < 1355
        c = FZ(:,6);
    elseif l >= 1355 & l < 1800
        c = FZ(:,8);
    else
      msgbox('check value of W','error')  
end
l = -l;
% SAE convention
MZ(:,1) = fp * MZ(:,1);
% Calspan friction coefficient
% Identifation of type of graph to be plotted
      
if g==1
    if ia == -4 
        b = IA (:,2);
    elseif ia == -3
        b = IA (:,3);
    elseif ia == -2  
        b = IA (:,4);
    elseif ia == -1  
        b = IA (:,5);
    elseif ia == 0   
        b = IA (:,6);
    elseif ia == 1   
        b = IA (:,7);
    elseif ia == 2   
        b = IA (:,8);
    elseif ia == 3
        b = IA (:,9);
    elseif ia == 4
        b = IA (:,10);
    else
          msgbox('check value of ia','error')
    end
    a8 = P(:,8);
    a10 = P(:,10);
    a12 = P(:,12);
    a14 = P(:,14);
    d8 = a8 & b & c & grbg;
    d10 = a10 & b & c & grbg;
    d12 = a12 & b & c & grbg;
    d14 = a14 & b & c & grbg;
    x8 = [SA(d8,1)];
    y8 = [MZ(d8,1)];
    x10 = [SA(d10,1)];
    y10 = [MZ(d10,1)];
    x12 = [SA(d12,1)];
    y12 = [MZ(d12,1)];
    x14 = [SA(d14,1)];
    y14 = [MZ(d14,1)];
    p8 = hyrem(x8,y8,k,minSA,maxSA);
    X8_1 = linspace(minSA,maxSA,polyacc);
    X8 = polyval(p8,X8_1);
    p10 = hyrem(x10,y10,k,minSA,maxSA);
    X10_1 = linspace(minSA,maxSA,polyacc);
    X10 = polyval(p10,X10_1);
    p12 = hyrem(x12,y12,k,minSA,maxSA);
    X12_1 = linspace(minSA,maxSA,polyacc);
    X12 = polyval(p12,X12_1);
    p14 = hyrem(x14,y14,k,minSA,maxSA);
    X14_1 = linspace(minSA,maxSA,polyacc);
    X14 = polyval(p14,X14_1);
    
      plot (X8_1,X8,'b',X10_1,X10,'g',X12_1,X12,'y',X14_1,X14,'r');
      legend('8 psi','10 psi','12 psi','14 psi','Location','NorthEast');
      grid on;
      xlim([minSA maxSA]);
      hold off;
      xlabel ('Self Aligning Torque (MZ) (N-m)');
      ylabel ('Lateral Force (FY) (N)');
      gname1 = sprintf('Actual data\n Load:%.0fkg Camber:%.0f°',W,ia);
      title(gname1);
      
elseif g==2
    if p == 8
        a = P(:,8);    
    elseif p == 10
        a = P(:,10);
    elseif p == 12
        a = P(:,12);
    elseif p == 14
        a = P(:,14);
    else
         msgbox('check value of p','error')
    end
    b0 = IA(:,6);
    b1 = IA(:,7);
    b2 = IA(:,8);
    b3 = IA(:,9);
    b4 = IA(:,10);
    d0 = a & b0 & c & grbg;
    d1 = a & b1 & c & grbg;
    d2 = a & b2 & c & grbg;
    d3 = a & b3 & c & grbg;
    d4 = a & b4 & c & grbg;
    x0 = [SA(d0,1)];
    x1 = [SA(d1,1)];
    x2 = [SA(d2,1)];
    x3 = [SA(d3,1)];
    x4 = [SA(d4,1)];
    y0 = [MZ(d0,1)];
    y1 = [MZ(d1,1)];
    y2 = [MZ(d2,1)];
    y3 = [MZ(d3,1)];
    y4 = [MZ(d4,1)];
    
    ia0 = hyrem(x0,y0,k,minSA,maxSA);
    X0_1 = linspace(minSA,maxSA,polyacc);
    X0 = polyval(ia0,X0_1);
    ia1 = hyrem(x1,y1,k,minSA,maxSA);
    X1_1 = linspace(minSA,maxSA,polyacc);
    X1 = polyval(ia1,X1_1);
    ia2 = hyrem(x2,y2,k,minSA,maxSA);
    X2_1 = linspace(minSA,maxSA,polyacc);
    X2 = polyval(ia2,X2_1);
    ia3 = hyrem(x3,y3,k,minSA,maxSA);
    X3_1 = linspace(minSA,maxSA,polyacc);
    X3 = polyval(ia3,X3_1);
    ia4 = hyrem(x4,y4,k,minSA,maxSA);
    X4_1 = linspace(minSA,maxSA,polyacc);
    X4 = polyval(ia4,X4_1);
    
    plot (X4_1,X4,'r',X3_1, X3,'y',X2_1, X2,'g',X1_1, X1,'c',X0_1, X0,'b');
    hold off;
    %plot(x0,y0,'.',x1,y1,'.',x2,y2,'.',x3,y3,'.',x4,y4,'.');
    legend('4° camber','3° camber','2° camber','1° camber','0° camber','Location','NorthEast');
    grid on;
    xlim([minSA maxSA]);
    xlabel ('Self Aligning Torque (MZ) (N-m)');
    ylabel ('Lateral Force (FY) (N)');
    gname1 = sprintf('Potyfit\nActual data\n Load:%.0fkg Pressure:%.0fpsi',W,p);
    title(gname1);
    
else
    msgbox('check value of g','error') 
end
clear all;    
