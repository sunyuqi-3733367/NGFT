function materialTesnsor=compute_driving_energy_material_tensor(para,trE)

MU=para.MU;
LAMBDA=para.KAPPA*Heviside(trE)-2/3*para.MU;
materialTesnsor=[LAMBDA+2*MU LAMBDA 0;
                 LAMBDA LAMBDA+2*MU 0;
                 0 0 2*MU];
end