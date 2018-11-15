% Nome: topo
% Objetivo: Verificar se o conteiner esta no topo

function [bool] = topo_navio(Navio,posicao_navio) % Volta se é verdadeiro ou falso.

pos_altura = posicao_navio(1,1); %posição 
pos_larg = posicao_navio(1,2);

    if ((pos_altura-1 == 0) || (Navio{1,posicao_navio(1,3)}(pos_altura-1,pos_larg) == 0)) %Verifica se é topo ou se a posição acima é vazia.
        bool = 1;
    else
        bool = 0;
    end

end