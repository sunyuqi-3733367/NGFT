function nonlocalDamMat=compute_nonlocal_damage_stiffnes_mat(para)

nnode=size(para.FemMesh.topo,1);
% nnode=size(para.FemMesh.node,1);
H=[1 -1];
assembleList=cell(nnode,1);

for k=1:nnode
    Member=para.familyInform.member{k};        
    memberNum=length(Member);
    SelfVol=para.particleInform.particleVol(k);
    assembleListlocal=cell(memberNum,1);
    for j=1:memberNum
        MemberNo=Member(j);
        MemVol=para.particleInform.particleVol(MemberNo);
        % relPos=para.FemMesh.node(MemberNo,:)-para.FemMesh.node(k,:);
        relPos=para.particleInform.elemCenter(MemberNo,:)-para.particleInform.elemCenter(k,:);
        r=norm(relPos);
        coef=0.5*para.DELTA(k)^2*para.kernelFunction.omega(r,k)*SelfVol*MemVol;
        B=coef*(H'*H);
        assembleListlocal{j}=matrix2list(B,para.indexList.dam{k}(j,:),para.indexList.dam{k}(j,:));
    end
    assembleList{k}=cell2mat(assembleListlocal);   
end

assembleList=cell2mat(assembleList);
nonlocalDamMat=sparse(assembleList(:,1),assembleList(:,2),assembleList(:,3),nnode,nnode);

end