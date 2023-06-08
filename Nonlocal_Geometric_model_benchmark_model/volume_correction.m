function sol=volume_correction(Vol,r,delta,rj)

if r<delta-rj
   sol=Vol;
end

if r>=delta+rj
   sol=0;
end

if r<=delta+rj && r>=delta-rj
   sol=rj^2*acos((r^2+rj^2-delta^2)/(2*r*rj))+delta^2*acos((r^2-rj^2+delta^2)/(2*r*delta))...
   -0.5*((-r+rj+delta)*(r+rj-delta)*(r-rj+delta)*(r+rj+delta))^0.5;
end
    
    
    


end