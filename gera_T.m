function [T] = gera_T(patio,porto,np)

T=zeros(np-1,np);

for k=1:size(patio,1)
    P=patio{k,1};
    [linha,coluna]=size(P);
    for i=1:linha
        for j=1:coluna
            if P(i,j)~=0
               [~,col]=find(porto(2,:)==P(i,j));
               h=porto(1,col);               
               T(k,h)= T(k,h)+1;
            end            
        end
    end           
end
end