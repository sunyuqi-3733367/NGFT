function list=matrix2list(matrix,locaList1,locaList2)

locaListNum1=length(locaList1);
locaListNum2=length(locaList2);
list=zeros(locaListNum1*locaListNum2,3); 
index=1;
for i=1:locaListNum1
    for j=1:locaListNum2
         list(index,:)=[locaList1(i),locaList2(j),matrix(i,j)];
         index=index+1;
         
    end
end



end