% Tire data Round 5
% Atishay 12/06/14
% MZ vs SA for different pressure,camber and loads along with hysteresis removal
g = 0; % just initializing...
% Types of plotting that can be done
% g=1 P FZ and IA constant single plot
% g=2 IA FZ constant P variable
% g=3 P FZ constant IA variable
% remove % from any one of the following
% DO NOT CHANGE g change other parameters as desired
% p = [8 10 12 14] {psi}
% ia = [0 1 2 3 4] {degrees}
% W > 5kg , W < 180kg
% g = 1 , p = 10  , ia = 1, W = 150
 g = 2, ia = 4, W = 45;
% g = 3, p = 12, W = 60;
k = 9;
% hysteresis removal factor (0 1)
hy = 0.4;
% degree of polynomial in polyfit
minSA = -8;
maxSA = 8;
%minimum and maximum value of SA to be plotted and evaluated
%for polyfit
polyacc = 1000; 
% polyfit accuracy
fp = 0.65
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
t.data([89521:145199],:) = u.data([1:55679],:);
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
[MZ(:,1)] = fp * [MZ(:,1)];
% Identifation of type of graph to be plotted
if g==1
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
    d = a & b & c;
    x = [SA(d,1)];
    y = [MZ(d,1)];
    p1 = polyfit(x,y,k);
    X1 = linspace(minSA,maxSA,polyacc);
    X = polyval(p1,X1);
      plot (x,y,'g.',X1,X,'k');
      grid on;
      xlim([minSA maxSA]);
      hold off;
      xlabel ('Slip Angle (degrees)');
      ylabel ('Self aligning torque (Nm)');
      lname = sprintf('Self aligning torque vs Slip Angle');
      legend(lname,'Location','NorthWest');
      gname1 = sprintf('Actual data\nPressure:%.0fpsi Load:%.0fkg Camber:%.0f°',p,W,ia);
      title(gname1);
      
      
elseif g==2
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
     plot (x8,y8,'r.');
    hold on;
    p8_ = polyfit(x8,y8,k);
    Y1 = linspace(minSA,maxSA,polyacc);
    Y = polyval(p8_,Y1);
    plot (Y1,Y,'k-')
    hold on;
    c8_0 = (p8_(k+1))/2;
    m = length(x8);
    c8_ = ones(m,1);
    c8_ = c8_ * c8_0;
    y8 = y8 - c8_;
    p8_ = polyfit(x8,y8,k);
    Y8_1 = linspace(minSA,maxSA,polyacc);
    Y8 = polyval(p8_,Y8_1);
    plot (Y8_1,Y8,'b');
    x = -8 : 0.01 : 8;
    y1 = p8_(1) * x.^9 + p8_(2) * x.^8 + p8_(3) * x.^7 + p8_(4) * x.^6 + p8_(5) * x.^5 + p8_(6) * x.^4 + p8_(7) * x.^3 + p8_(8) * x.^2 + p8_(9) * x + p8_(10);
    idx = find(y1==0)
        if isempty(idx)
           idx = find(diff(sign(y1-0)),1)
        end
     px = x(idx);
     py = y1(idx);
     plot(px,py,'mo');
     c8_ = ones(m,1);
     c8_ = c8_ * px ;
     x8 = x8 - c8_;
     p8__ = polyfit(x8,y8,k);
     X8_1 = linspace(minSA,maxSA,polyacc);
     X8 = polyval(p8__,X8_1);
     plot (X8_1,X8,'g');
      legend('Raw Data','Orignally fitted curve','Y hysteresis removed','X hysteresis','Hysteresis completely removed','Location','NorthWest');
    %{
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
      %plot(x8,y8,'b.',x10,y10,'g.',x12,y12,'y.',x14,y14,'r.');
      hold on;
      plot (X8_1,X8,'b',X10_1,X10,'g',X12_1,X12,'y',X14_1,X14,'r');
      legend('8 psi','10 psi','12 psi','14 psi','Location','NorthWest');
    %}
      grid on;
      xlim([minSA maxSA]);
      hold off;
      xlabel ('Slip Angle (degrees)');
      ylabel ('Self aligning torque(Nm)');
      gname1 = sprintf('Actual data\n Load:%.0fkg Camber:%.0f°',W,ia);
      title(gname1);
      %{
  p10 = polyfit(x10,y10,k);
    X10_1 = linspace(minSA,maxSA,polyacc);
    X10 = polyval(p10,X10_1);
    p12 = polyfit(x12,y12,k);
    X12_1 = linspace(minSA,maxSA,polyacc);
    X12 = polyval(p12,X12_1);
    p14 = polyfit(x14,y14,k);
    X14_1 = linspace(minSA,maxSA,polyacc);
    X14 = polyval(p14,X14_1);
    %}
            
elseif g==3
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
    d0 = a & b0 & c;
    d1 = a & b1 & c;
    d2 = a & b2 & c;
    d3 = a & b3 & c;
    d4 = a & b4 & c;
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
    ia0 = polyfit(x0,y0,k);
    X0_1 = linspace(minSA,maxSA,polyacc);
    X0 = polyval(ia0,X0_1);
    ia1 = polyfit(x1,y1,k);
    X1_1 = linspace(minSA,maxSA,polyacc);
    X1 = polyval(ia1,X1_1);
    ia2 = polyfit(x2,y2,k);
    ia2 = polyfit(x2,y2,k);
    X2_1 = linspace(minSA,maxSA,polyacc);
    X2 = polyval(ia2,X2_1);
    ia3 = polyfit(x3,y3,k);
    X3_1 = linspace(minSA,maxSA,polyacc);
    X3 = polyval(ia3,X3_1);
    ia4 = polyfit(x4,y4,k);
    X4_1 = linspace(minSA,maxSA,polyacc);
    X4 = polyval(ia4,X4_1);
    
    plot (X4_1,X4,X3_1, X3,X2_1, X2,X1_1, X1,X0_1, X0);
    hold off;
    %plot(x0,y0,'.',x1,y1,'.',x2,y2,'.',x3,y3,'.',x4,y4,'.');
    hold on;
    %-----------plot for points in tire data
    legend('4° camber','3° camber','2° camber','1° camber','0° camber','Location','NorthWest');
    grid on;
    xlim([minSA maxSA]);
    xlabel ('Slip Angle (degrees)');
    ylabel ('Self aligning torque(Nm)');
    gname1 = sprintf('Potyfit\nActual data\n Load:%.0fkg Pressure:%.0fpsi',W,p);
    title(gname1);
else
    msgbox('check value of g','error') 
end
% clear all;   
hold off;
%plot (ET,SA,'b');
