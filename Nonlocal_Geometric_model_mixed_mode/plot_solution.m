function plot_solution(kStep,uNum,damNum,para)

FemMesh=para.FemMesh;
nelem=size(FemMesh.topo,1);
[dispAmp,dispX,dispY,damPlot]=deal( cell(nelem,1) );
uPlot=uNum;
uM=sqrt(uPlot(:,1).^2+ uPlot(:,2).^2);

for k=1:nelem
       ElemIndex=FemMesh.topo(k,:);
       elemCoord=FemMesh.node(FemMesh.topo(k,:),:);
       dispAmp{k}=[elemCoord(:,1)+uPlot(ElemIndex,1),elemCoord(:,2)+uPlot(ElemIndex,2),uM(ElemIndex)];
       dispX{k}=[elemCoord(:,1)+uPlot(ElemIndex,1),elemCoord(:,2)+uPlot(ElemIndex,2),uPlot(ElemIndex,1)];
       dispY{k}=[elemCoord(:,1)+uPlot(ElemIndex,1),elemCoord(:,2)+uPlot(ElemIndex,2),uPlot(ElemIndex,2)];
       damPlot{k}=[elemCoord(:,1)+uPlot(ElemIndex,1),elemCoord(:,2)+uPlot(ElemIndex,2),damNum(ElemIndex)];     
end

figure
mypatch=@(v) patch(v(:,1),v(:,2),v(:,3)); 
subplot(2,2,1);
colormap jet
title(['disp-Amp-step-',num2str(kStep)])
cellfun(mypatch,dispAmp); colorbar; axis tight; xlabel('x(mm)'); ylabel('y(mm)')
subplot(2,2,2);
colormap jet
title(['disp-X-step-',num2str(kStep)])
cellfun(mypatch,dispX); colorbar; axis tight; xlabel('x(mm)'); ylabel('y(mm)')
subplot(2,2,3);
colormap jet
title(['disp-Y-step-',num2str(kStep)])
cellfun(mypatch,dispY); colorbar; axis tight; xlabel('x(mm)'); ylabel('y(mm)')
subplot(2,2,4);
colormap jet
title(['damage-step-',num2str(kStep)])
cellfun(mypatch, damPlot); colorbar; axis tight; xlabel('x(mm)'); ylabel('y(mm)')
pause(0.2)

end