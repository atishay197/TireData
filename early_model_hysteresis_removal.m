%{
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
    x = -8 : 0.01 : 8;
    y1 = p8_(1) * x.^9 + p8_(2) * x.^8 + p8_(3) * x.^7 + p8_(4) * x.^6 + p8_(5) * x.^5 + p8_(6) * x.^4 + p8_(7) * x.^3 + p8_(8) * x.^2 + p8_(9) * x + p8_(10);
    idx = find(y1==0)
        if isempty(idx)
           idx = find(diff(sign(y1-0)),1)
        end
     px = x(idx);
     py = y1(idx);
     c8_ = ones(m,1);
     c8_ = c8_ * px ;
     x8 = x8 - c8_;
     p8__ = polyfit(x8,y8,k);
    
    XYK8(:,1) = x8;
    XYK8(:,2) = y8;
    XYK8(1,3) = k;
    XYK8(2,3) = minSA;
    XYK8(3,3) = maxSA;
    %}