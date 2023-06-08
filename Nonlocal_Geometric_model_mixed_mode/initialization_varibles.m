function [uPre,damPre,WePre]=initialization_varibles(para)

nnode=size(para.FemMesh.topo,1);
% nnode=size(para.FemMesh.node,1);
uPre=zeros(2*nnode,1);
damPre=zeros(nnode,1);
WePre=zeros(nnode,1);

end