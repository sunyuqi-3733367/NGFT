function materialTesnsor=compute_degrade_material_tensor(para,d,trE)

g=degrade_func(d);
damMU=g*para.MU;
damLAMBDA=g*(para.KAPPA*Heviside(trE)-2/3*para.MU)+para.KAPPA*Heviside(-trE);

materialTesnsor=[damLAMBDA+2*damMU damLAMBDA 0;
                 damLAMBDA damLAMBDA+2*damMU 0;
                 0 0 2*damMU];
end