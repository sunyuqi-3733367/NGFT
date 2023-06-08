function write_vtk_file(kStep,vtkName,para)


T=readtable([para.outputpath,'result',num2str(kStep),'.csv']);

%% part-1
filename=[para.post_path,'result',num2str(kStep),'.vtk'];
fid = fopen(filename, 'w'); 
fprintf(fid,'# vtk DataFile Version 2.0\n');
fprintf(fid,[vtkName,'\n']);
fprintf(fid,'ASCII\n');

%% part-2
fprintf(fid,'DATASET UNSTRUCTURED_GRID\n');
fprintf(fid,['POINTS',' ',num2str(length(T.x)),' ','double\n']');
for k=1:length(T.x)
    fprintf(fid,[num2str(T.x(k)),' ',num2str(T.y(k)),' ',num2str(T.z(k)),'\n']');
end
fprintf(fid,'\n');

nelem=size(para.DgMesh.topo,1);
fprintf(fid,['CELLS',' ',num2str(nelem),' ',num2str(nelem*5),'\n']);
for k=1:nelem
    elem=para.DgMesh.topo(k,:);
    fprintf(fid,['4',' ',num2str(elem(1)-1),' ',num2str(elem(2)-1),' ',num2str(elem(3)-1),' ',num2str(elem(4)-1),'\n']');
end
fprintf(fid,'\n');

fprintf(fid,['CELL_TYPES',' ',num2str(nelem),'\n']);
for k=1:nelem
    fprintf(fid,'9\n');
end

%% part-3
fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,['POINT_DATA',' ',num2str(length(T.x)),'\n']);
fprintf(fid,'SCALARS ux double 1\n');
fprintf(fid,'LOOKUP_TABLE default\n');
for k=1:length(T.x)
    fprintf(fid,[num2str(T.ux(k)),'\n']');
end
fprintf(fid,'\n');

fprintf(fid,'SCALARS uy double 1\n');
fprintf(fid,'LOOKUP_TABLE default\n');
for k=1:length(T.x)
    fprintf(fid,[num2str(T.uy(k)),'\n']');
end
fprintf(fid,'\n');

fprintf(fid,'SCALARS damage double 1\n');
fprintf(fid,'LOOKUP_TABLE default\n');
for k=1:length(T.x)
    fprintf(fid,[num2str(T.damage(k)),'\n']');
end
fclose(fid);
end