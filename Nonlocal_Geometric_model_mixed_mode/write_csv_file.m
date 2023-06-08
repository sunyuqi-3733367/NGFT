function write_csv_file(kStep,uNum,damNum,para)

outputpath=para.outputpath;
FemMesh=para.FemMesh;
nelem=size(para.FemMesh.topo,1);
[ux,uy,currentCoord,damage]=deal( cell(nelem,1) );
uPlot=uNum;
for kk=1:nelem
       ElemIndex=FemMesh.topo(kk,:);
       elemCoord=FemMesh.node(FemMesh.topo(kk,:),:);
       z=zeros( size( elemCoord(:,1) ) );
       currentCoord{kk}=[elemCoord(:,1)+uPlot(ElemIndex,1),elemCoord(:,2)+uPlot(ElemIndex,2),z];
       ux{kk}=uPlot(ElemIndex,1);
       uy{kk}=uPlot(ElemIndex,2);
       damage{kk}=damNum(ElemIndex);
end 

currentCoord=cell2mat(currentCoord);
ux=cell2mat(ux);
uy=cell2mat(uy);
damage=cell2mat(damage);

x=currentCoord(:,1);
y=currentCoord(:,2);
z=currentCoord(:,3);

T=table(x,y,z,damage,ux,uy);
writetable(T,[outputpath,'result',num2str(kStep),'.csv'])


end