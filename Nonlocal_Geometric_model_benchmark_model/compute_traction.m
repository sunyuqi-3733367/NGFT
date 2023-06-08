function disp_force=compute_traction(para,uNew)

bdElem=para.bdElem(1);
bdNode=bdElem.node;
N=length(bdNode);
boundaryTraction=zeros(N,1);
MAT=compute_material_tensor(para);
disp_force=zeros(2,1);

for i=1:N
    node_i=bdNode(i);
    localDisp=uNew(para.indexList.mae{node_i});
    nonlocalStrain=para.nonlocalStrain{node_i};
    s=MAT*nonlocalStrain*localDisp;
    stress=[s(1) s(3) ;s(3) s(2)];
    traction=stress*[0;1];
    boundaryTraction(i)=traction(2);
end

disp_force(1)=uNew(2*node_i);
disp_force(2)=mean(boundaryTraction);



end