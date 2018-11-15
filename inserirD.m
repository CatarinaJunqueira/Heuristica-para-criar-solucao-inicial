

function [D] = inserirD(D,patio,posicao_navio,porto)
linha = posicao_navio(1,1); %posição 
coluna = posicao_navio(1,2);

u=patio(linha,coluna);
v=porto(u);
x=length(D);
D_aux=zeros(1,x);
D_aux(v)=1;
D=D+D_aux;
end