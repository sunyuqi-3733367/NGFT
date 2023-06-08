function disp=recover_disp(T,para)

nelem=size(para.FemMesh.topo,1);
disp=zeros(2*nelem,1);
for k=1:nelem
    elemNode=para.DgMesh.topo(k,:);
    elemDisp=[T.ux(elemNode),T.uy(elemNode)];
    elemDisp=mean(elemDisp);
    disp([2*k-1,2*k])=elemDisp;
end

end