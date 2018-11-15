function[lista_descarregamento] = Quem_Sai(Navio,~,NPorto)

[row,col]=find(Navio==NPorto);
if isempty(row)==1 &&  isempty(col)==1 
     lista_descarregamento=row;    
else
    N=size(row,1);
    lista_descarregamento=zeros(N,2);
    lista_descarregamento(:,1)=row;
    lista_descarregamento(:,2)=col;
end



% N=length(find(porto(1,:)==NPorto));
% lista_descarregamento=zeros(N,2);
% [k,l]=size(Navio);
% contador=1;
% for i=1:k
%     for j=1:l
%         if Navio(i,j)~=0
%             [row]=find(porto(2,:)==Navio(i,j));
%             if porto(1,row)==NPorto
%                lista_descarregamento(contador,1)=i;
%                lista_descarregamento(contador,2)=j;
%                contador=contador+1;
%             end            
%         end
%     end
% end
end