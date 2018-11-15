

function [patio,conteiner] = remover(patio,posicao_navio) %tira do patio

linha = posicao_navio(1,1); %posição 
coluna = posicao_navio(1,2);

conteiner = patio(linha,coluna); % salvando o número (identificação) do contêiner na variável 'ind' 
patio(linha,coluna)=0;  % substitui o conteúdo do conteiner retirado por 0.

end