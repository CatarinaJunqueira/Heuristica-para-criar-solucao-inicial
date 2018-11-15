%Como os contêineres já tem uma ordem específica para sair, não importa a
%ordem que eu percorro. Apenas localizo sua posição na matriz e coloco na
%lista 'posicoes'.

function [posicoes] = encontraCasertaDescarregamento(P) % localiza posição e não conteúdo.

o=unique(P)';
if o(1)==0
    o(1)=[];
end
i=1;
 for j=o
     [row(i),col(i)]=find(P==j);
     i=i+1;
 end
posicoes=zeros(size(o,2),2);
posicoes(:,1)=row;
posicoes(:,2)=col;
   
end

