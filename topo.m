% Nome: topo
% Objetivo: Verificar se o conteiner esta no topo

function [bool] = topo(P,posicao_navio) % Volta se é verdadeiro ou falso.

lin = posicao_navio(1,1); %posição 
col = posicao_navio(1,2);

    if  ((lin-1 == 0) || (P(lin-1,col) == 0))%Verifica se é topo ou se a posição acima é vazia.
        bool = 1;
    else
        bool = 0;
    end

end