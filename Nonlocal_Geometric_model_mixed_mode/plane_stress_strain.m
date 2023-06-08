function [LAMBDA,MU,KAPPA]=plane_stress_strain(NU,E,cond)

if strcmp(cond,'plane_stress')
    C1111=E/(1-NU^2);
    C1122=E*NU/(1-NU^2);
elseif strcmp(cond,'plane_strain') % or 3D
    C1111=E*(1-NU)/((1+NU)*(1-2*NU));
    C1122=E*NU/((1+NU)*(1-2*NU));   
end

LAMBDA=C1122;
MU=1/2*(C1111-C1122);
KAPPA=LAMBDA+MU;

end