function materialTesnsor=compute_material_tensor(para)

MU=para.MU;
LAMBDA=para.KAPPA-2/3*para.MU;
materialTesnsor=[LAMBDA+2*MU LAMBDA 0;
                 LAMBDA LAMBDA+2*MU 0;
                 0 0 2*MU];
end