function W=computue_driving_energy(uNew,WeInput,para)

nnode=size(para.FemMesh.topo,1);
% nnode=size(para.FemMesh.node,1);
W=zeros(nnode,1);

for k=1:nnode
    localDisp=uNew(para.indexList.mae{k});
    nonlocalStrain=para.nonlocalStrain{k};
    epsilon=nonlocalStrain*localDisp;
    trE=epsilon(1)+epsilon(2);
    MAT=compute_driving_energy_material_tensor(para,trE);
    W(k)=0.5*(nonlocalStrain*localDisp)'*MAT*(nonlocalStrain*localDisp);
    W(k)=max(W(k),WeInput(k));
end

end