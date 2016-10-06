% Tire data Round 5
% Atishay 21/04/14
W = 0;
g = 0; % just initializing...
% p = [8 10 12 14] {psi}
% ia = [0 2 4] {degrees}
% sa = [0 -3 -6] 
% fx = [0 1] positive negetive
% code or data (most probably) faulty for negetive fy
p = 12; ia = 2; sa = -3; fx = 0; %preffered value 0
k = 2;
% degree of polynomial in polyfit
minFZ = 100;
maxFZ = 1800;
%minimum and maximum value of Normal force to be plotted and evaluated
%for polyfit
polyacc = 1000; 
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
% importing data for run 42
u =importdata('B1464run15.dat');
% importing data for run 43
names = t.textdata{2}; 
% creating names of individual matrices
t.data([56666:93762],:) = u.data([1:37097],:);
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
if sa == 0
    e = SA(:,1)<=0.5 & SA(:,1)>=-0.5 ;
elseif sa == -3
    e = SA(:,1)<=-2.5 & SA(:,1)>=-3.5 ;
elseif sa == -6
    e = SA(:,1)<=-5.5 & SA(:,1)>=-6.5 ;
else
    msgbox('check the value of sa','error')
end
if fx == 0
    f = FY(:,1)>= 300;
elseif fx == 1
    f = FY(:,1)<= 0;
else
    msgbox('check the value of fx','error')
end
e1 = SR(:,1)<= .05 & SR(:,1)>= -.05 ;
e2 = SR(:,1)<= .15 & SR(:,1)>= .05 ;
[FY(:,1)] = fp * [FY(:,1)];
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
    NFY = -NFY;
    d3 = a & b & f & e1;
    d4 = a & b & f & e2;
    x3 = [FZ(d3,1)];
    y3 = [FY(d3,1)];
    x4 = [FZ(d4,1)];
    y4 = [FY(d4,1)];
    p3 = polyfit(x3,y3,k);
    X13 = linspace(minFZ,maxFZ,polyacc);
    X3 = polyval(p3,X13);
    p4 = polyfit(x4,y4,k);
    X14 = linspace(minFZ,maxFZ,polyacc);
    X4 = polyval(p4,X14);
    plot (x3,y3,'b.',x4,y4,'r.');
    hold on;
    plot (X13,X3,'b',X14,X4,'r');
    xlim([minFZ maxFZ]);
    grid on;
    hold off;
    xlabel ('Normal Force (N)');
    ylabel ('Longitudnal Force (N)');
    legend ('SR lies btw -0.5 and 0.5','SR lies btw 0.5 and 1.5','Location','NorthWest');
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
