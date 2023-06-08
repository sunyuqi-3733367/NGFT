function [uPlot,damPlot]=post_processing(uNew,damNew,para)

nnode=size(para.FemMesh.node,1);
nelem=size(para.FemMesh.topo,1);
uNew=[uNew(1:2:end),uNew(2:2:end)];
uPlot=zeros(nnode,2);
damPlot=zeros(nnode,1);

for i=1:nnode
    [r,~]=find(para.FemMesh.topo==i);
    uPlot(i,:)=sum(uNew(r,:),1)/length(r);
    damPlot(i)=sum(damNew(r))/length(r);
end

% for i=1:nelem
%     elemNodes=para.FemMesh.topo(i,:);
%     uPlot(elemNodes,:)=[uNew(i,:);uNew(i,:);uNew(i,:);uNew(i,:)];
%     damPlot(elemNodes)=damNew(i);
% end

end