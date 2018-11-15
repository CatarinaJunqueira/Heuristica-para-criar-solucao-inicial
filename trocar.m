% Nome: Trocar
% Objetivo: Troca o conteiner de posicao

function [patio] = trocar(patio,posicao_conteiner,posicao_vazia) 

I1 = patio(posicao_conteiner(1,1),posicao_conteiner(1,2)); %identificando no patio o conteiner que esta na lista_navio
patio(posicao_vazia(1,1),posicao_vazia(1,2))=I1; % Colocando-o na prosicao vazio
patio(posicao_conteiner(1,1),posicao_conteiner(1,2))=0; %zerando a posicao em que ele estava antes

end