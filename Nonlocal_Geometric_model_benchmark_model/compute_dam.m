function [damNew,WeNew]=compute_dam(uNew,WeInput,para)

% nnode=size(para.FemMesh.node,1);
nnode=size(para.FemMesh.topo,1);
WeNew=computue_driving_energy(uNew,WeInput,para);

SelfVol=para.particleInform.particleVol;
E=WeNew./(para.Gc./(2*para.DELTA));
assembleList=[(1:nnode)',(1:nnode)',(1+E).*SelfVol];
F=E.*SelfVol; 

K=para.nonlocalDamMat+sparse(assembleList(:,1),assembleList(:,2),assembleList(:,3),nnode,nnode);
damNew=K\F;


end