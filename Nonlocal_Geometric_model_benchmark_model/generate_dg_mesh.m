function DgMesh=generate_dg_mesh(FemMesh)

nelem=size(FemMesh.topo,1); 
elemList=(1:nelem)'; 
DgMesh.topo=[4*elemList-3,4*elemList-2,4*elemList-1,4*elemList];  


end