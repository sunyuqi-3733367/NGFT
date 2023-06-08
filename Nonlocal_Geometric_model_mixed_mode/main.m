% Nonlocal Geometric model benchmark model
% Yuqi Sun Tongji Universirty& Nanyang Technology University
clc
clear

%% 
path='C:\Research_coding\Nonlocal_Geometric_model_mixed_mode\';
para.NU=1/3; 
para.E=7.14e7;  
para.Gc=3000;
para.cond='plane_stress';
[para.LAMBDA,para.MU,para.KAPPA]=plane_stress_strain(para.NU,para.E,para.cond);

para.outputpath=[path,'outputdata\']; 
para.meshpath=[path,'mesh\']; 
para.post_path=[path,'vtk_file\'];
para.FemMesh=readinp([para.meshpath,'mesh.inp']); 
para.DgMesh=generate_dg_mesh(para.FemMesh);  
para.particleInform=compute_particle_information(para.FemMesh);

para.DELTA=3*para.particleInform.particleSize;
para.kernelFunction.Phi=@(r,i) compute_kernel_function_Phi(para,r,i); 
para.kernelFunction.omega=@(r,i) compute_kernel_function_Omega(para,r,i); 

para.totalDisp=0.3; 
para.totalStep=500; 
para.addDisp=para.totalDisp/para.totalStep;  

bdEelem1.node=cell2mat(struct2cell(load([para.meshpath,'bd1.mat'])));
bdEelem2.node=cell2mat(struct2cell(load([para.meshpath,'bd2.mat']))); 
bdEelem3.node=cell2mat(struct2cell(load([para.meshpath,'bd3.mat']))); 
bdEelem1.type=1;  
bdEelem2.type=1;
bdEelem3.type=1;
bdEelem1.value=[NaN;para.addDisp]; 
bdEelem2.value=[NaN;0];
bdEelem3.value=[0;NaN];
para.bdElem=[bdEelem1,bdEelem2,bdEelem3]; 

%% 
para.familyInform=searchfamily(para);
para.indexList=compute_member_index_list(para); 
para.nonlocalStrain=compute_nonlolocal_strain(para);
para.nonlocalDamMat=compute_nonlocal_damage_stiffnes_mat(para);

%%
[uPre,damPre,WePre]=initialization_varibles(para);
for kStep=1:para.totalStep
    para.kStep=kStep;
    fprintf('STEP-%d\n',kStep);
    [uNew,damNew,WeNew]=time_stepping(uPre,damPre,WePre,para);
    uPre=uNew;
    damPre=damNew;
    WePre=WeNew;
    [uPlot,damPlot]=post_processing(uNew,damNew,para);
%     if kStep==1 
%        plot_solution(kStep,uPlot,damPlot,para); 
%     end
    write_csv_file(kStep,uPlot,damPlot,para);
end

for kStep=1:2:para.totalStep
 write_vtk_file(kStep,'Nonlocal_Geometric_Fracture',para);   
end
