% Nome: topo
% Objetivo: Verificar se o conteiner esta no topo

function [bool] = topo(P,posicao_navio) % Volta se � verdadeiro ou falso.

lin = posicao_navio(1,1); %posi��o 
col = posicao_navio(1,2);

    if  ((lin-1 == 0) || (P(lin-1,col) == 0))%Verifica se � topo ou se a posi��o acima � vazia.
        bool = 1;
    else
        bool = 0;
    end

end