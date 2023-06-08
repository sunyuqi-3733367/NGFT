function sol=volume_correction(r,delta,ri)

if r<=delta && r>=delta-ri
   sol=-r/(2*ri)+(0.5+delta/(2*ri));
elseif r<delta-ri
    sol=1;
else
    sol=0;
end






end