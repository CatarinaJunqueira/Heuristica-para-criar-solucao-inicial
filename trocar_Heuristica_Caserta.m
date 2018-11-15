% Nome: Trocar
% Objetivo: Trocar o conteiner de posicao dentro do patio.

function [P] = trocar_Heuristica_Caserta(P,coluna,r,linha_r,coluna_r) 

[row]=find(P(:,coluna)==0);
linha=row(end);
P(linha,coluna)=r; % Colocando-o na posicao vazia
P(linha_r,coluna_r)=0; %zerando a posicao em que r estava antes

end