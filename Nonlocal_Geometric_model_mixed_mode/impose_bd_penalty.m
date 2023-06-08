function [K,F]=impose_bd_penalty(K,F,para)

bdElem=para.bdElem;
N=length(bdElem);
penalty=1e3*max(max(abs(K)));

for i=1:N     
    bdNode=bdElem(i).node;
    Val=bdElem(i).value;
    for nn=1:length(bdNode)
        for j=1:length(Val)
            if ~isnan(Val(j))
                if j==1
                    K(2*bdNode(nn)-1,2*bdNode(nn)-1)=penalty;
                    F(2*bdNode(nn)-1)=para.kStep*penalty*Val(j);
                elseif j==2
                    K(2*bdNode(nn),2*bdNode(nn))=penalty;
                    F(2*bdNode(nn))=para.kStep*penalty*Val(j);
                end
            end
        end             
    end

end

end