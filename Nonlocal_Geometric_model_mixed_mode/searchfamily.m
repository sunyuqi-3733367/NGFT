function familyInform=searchfamily(para)

nodeCenter=para.particleInform.elemCenter;
% nodeCenter=para.FemMesh.node;
nnode=size(nodeCenter,1);
nNF=zeros(nnode,1);
NF=cell(nnode,1);

h=waitbar(0,'please wait');
for i=1:nnode
    iNF=[];
    for j=1:nnode
        if j~=i 
           d=norm(nodeCenter(i,:)-nodeCenter(j,:)); 
           if d<para.DELTA(i)
              % modify crack_index to break bonds
              % crack_index=0;
              crack_index=nodeCenter(i,1)<10.5 && nodeCenter(j,1)<10.5 && (nodeCenter(i,2)-12)*(nodeCenter(j,2)-12)<0;
              if crack_index==1
                 continue;
              end
           iNF=[iNF,j]; 
           end
        end
    end
    iNF=[iNF,i];
    NF{i}=iNF;
    nNF(i)=length(NF{i});
    str=[num2str(i/nnode*100),'%'];
    waitbar(i/nnode,h,str);
end
delete(h);

familyInform.nfam=nNF;
familyInform.member=NF;

if min(familyInform.nfam)<=1
   warning('Too less family members!!!')
end

end