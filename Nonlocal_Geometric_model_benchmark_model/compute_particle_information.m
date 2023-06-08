function particleInform=compute_particle_information(FemMesh)

% nnode=size(FemMesh.node,1);
nnode=size(FemMesh.topo,1);
[particleVol,searchLength]=deal(zeros(nnode,1));
elemCenter=deal(zeros(nnode,2));

for i=1:nnode
    Coord=FemMesh.node(FemMesh.topo(i,:),:); 
    v1=Coord(2,:)-Coord(1,:);
    v2=Coord(4,:)-Coord(1,:);
    u1=Coord(2,:)-Coord(3,:);
    u2=Coord(4,:)-Coord(3,:);
    addArea=0.5*abs(v1(1)*v2(2)-v1(2)*v2(1))+0.5*abs(u1(1)*u2(2)-u1(2)*u2(1));
    particleVol(i)=addArea;
    elemCenter(i,:)=mean(Coord);  
    searchLength(i)=max(norm(Coord(3,:)-Coord(1,:)),norm(Coord(4,:)-Coord(2,:)));
%   [r,c]=find(FemMesh.topo==i);
%   for j=1:length(r)   
%         Coord=FemMesh.node(FemMesh.topo(r(j),:),:); 
%         elemCenter=mean(Coord); 
%         selfNode=FemMesh.topo(r(j),c(j));
%         otherNodes=setdiff(FemMesh.topo(r(j),:),selfNode);  
%         relPos1=FemMesh.node(otherNodes(1),:)-FemMesh.node(selfNode,:);
%         relPos2=FemMesh.node(otherNodes(2),:)-FemMesh.node(selfNode,:);
%         ccPos=elemCenter-FemMesh.node(selfNode,:);
%         addVol1=0.5*norm(cross(0.5*[relPos1,0],[ccPos,0]));
%         addVol2=0.5*norm(cross(0.5*[relPos2,0],[ccPos,0]));
%         particleVol(i)=particleVol(i)+addVol1+addVol2;
%         temp=max(norm(relPos1),norm(relPos2));
%         searchLength(i)=max(temp,searchLength(i));
%   end
end

particleInform.particleVol=particleVol;
particleInform.elemCenter=elemCenter;
particleInform.searchLength=sqrt(particleVol);
particleInform.particleSize=sqrt(particleVol/pi);

end



