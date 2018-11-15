% patio=[0,0,0,0,0;0,0,15,16,0;11,12,13,14,0;6,7,8,9,10;1,2,3,4,5];
% navio=[3,1,5,1,1,1,4,4,1,5,1,5,5,5,3,3,4];
% id_navio=1;

%  *___Resposta a ser obtida___*
% posicoes =
% 
%      3     1
%      4     1
%      4     4
%      5     2
%      5     4
%      5     5

%----------------------------------------%
% encontra para a regra Rt1:    1 2 3
%                               4 5 6
%                               7 8 9
%----------------------------------------%
% A funcao encontra, diferentemente da localiza, percorre a matriz de cima
% para baixo. Dessa forma, acaba-se com o problema do conteiner que estava acima, na mesma
% coluna do conteiner que ia sair, mas ia para o mesmo navio. Assim, sempre
% tiramos primeiro o conteiner que esta mais acima e diminui uma
% verificacao na regra Rt.

function [posicoes] = enc_ALL(patio) % localiza posição e não conteúdo.

Y=length(find(patio~=0)); % encontra os conteineres que vao para o navio id_navio
posicoes=zeros(Y,2);

[linha,coluna]=size(patio);
c = 1; % inicializando um contador. 

    for i = 1:linha % Ordem que vai percorrer
         for k = 1:coluna   
             if patio(i,k) ~= 0 
                posicoes(c,1) = i;
                posicoes(c,2) = k;
                c = c + 1;    % lista de vazios/contêineres (posição no pátio)                 
             end
         end
    end    
end