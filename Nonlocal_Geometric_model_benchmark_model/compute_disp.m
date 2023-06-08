function uNew=compute_disp(uPre,damPre,para)

nnode=size(para.FemMesh.topo,1);
% nnode=size(para.FemMesh.node,1);
assembleList=cell(nnode,1);
particleVol=para.particleInform.particleVol;
indexListMae=para.indexList.mae;
ParaNonlocalStrain=para.nonlocalStrain;

for k=1:nnode
    uParallel=uPre;
    SelfVol=particleVol(k);
    localDisp=uParallel(indexListMae{k});
    nonlocalStrain=ParaNonlocalStrain{k};
    epsilon=nonlocalStrain*localDisp;
    trE=epsilon(1)+epsilon(2);
    MAT=compute_degrade_material_tensor(para,damPre(k),trE);
    B=nonlocalStrain'*MAT*nonlocalStrain*SelfVol;
    assembleList{k}=matrix2list(B,indexListMae{k},indexListMae{k});   
end

assembleList=cell2mat(assembleList);
K=sparse(assembleList(:,1),assembleList(:,2),assembleList(:,3),2*nnode,2*nnode);
F=zeros(2*nnode,1); % if there are nonlocal traction boundaries, you need to modify this line
[K,F]=impose_bd_penalty(K,F,para); 
uNew=K\F;

end

