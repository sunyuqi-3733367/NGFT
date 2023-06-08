function nonlocalStrain=compute_nonlolocal_strain(para)

nnode=size(para.FemMesh.topo,1);
% nnode=size(para.FemMesh.node,1);
nonlocalStrain=cell(nnode,1);

for k=1:nnode
    Member=para.familyInform.member{k};        
    memberNum=length(Member);
    nonlocalStrain{k}=zeros(3,2*memberNum);
    for kk=1:memberNum
        MemberNo=Member(kk);
        % MemVol=para.particleInform.particleVol(MemberNo);
        relPos=para.particleInform.elemCenter(MemberNo,:)-para.particleInform.elemCenter(k,:);
        r=norm(relPos);
        MemVol=volume_correction(para.particleInform.particleVol(MemberNo),r,para.DELTA(MemberNo),para.particleInform.particleSize(MemberNo));
        alpha=relPos*para.kernelFunction.Phi(r,k);
        
        nonlocalStrain{k}(1,2*kk-1)=nonlocalStrain{k}(1,2*kk-1)+alpha(1)*MemVol;
        nonlocalStrain{k}(1,end-1)=nonlocalStrain{k}(1,end-1)+(-alpha(1)*MemVol);
        
        nonlocalStrain{k}(2,2*kk)=nonlocalStrain{k}(2,2*kk)+alpha(2)*MemVol;
        nonlocalStrain{k}(2,end)=nonlocalStrain{k}(2,end)+(-alpha(2)*MemVol);
        
        nonlocalStrain{k}(3,2*kk-1)=nonlocalStrain{k}(3,2*kk-1)+alpha(2)*MemVol;
        nonlocalStrain{k}(3,end-1)=nonlocalStrain{k}(3,end-1)+(-alpha(2)*MemVol);
        
        nonlocalStrain{k}(3,2*kk)=nonlocalStrain{k}(3,2*kk)+alpha(1)*MemVol;
        nonlocalStrain{k}(3,end)=nonlocalStrain{k}(3,end)+(-alpha(1)*MemVol);
    end
    nonlocalStrain{k}(3,:)=0.5*nonlocalStrain{k}(3,:);
      
end

end