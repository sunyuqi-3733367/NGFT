function indexList=compute_member_index_list(para)

nnode=size(para.FemMesh.topo,1);
% nnode=size(para.FemMesh.node,1);
[indexList.mae,indexList.dam]=deal(cell(nnode,1));

for k=1:nnode
      Member=para.familyInform.member{k};        
      memberNum=length(Member);
      indexList.mae{k}=zeros(1,2*memberNum);
      indexList.mae{k}(1:2:end)=2*Member-1;
      indexList.mae{k}(2:2:end)=2*Member;
      indexList.dam{k}=zeros(memberNum,2);
        for j=1:memberNum    
            indexList.dam{k}(j,:)=[Member(j),Member(end)];
        end
end     
 
end

