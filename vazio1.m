%patio=[0,0,0,0,0;0,0,15,16,0;11,12,13,14,0;6,7,8,9,10;1,2,3,4,5];
%  *___Resposta a ser obtida___*
% vazio =
% 
%      3     5
%      2     1
%      2     2
%      2     5
%      1     1
%      1     2
%      1     3
%      1     4
%      1     5

%----------------------------------------%
% localiza posições vazias para a regra Rt1:    7 8 9
%                                               4 5 6
%                                               1 2 3
%----------------------------------------%

function [vazio] = vazio1(patio) % localiza posição e não conteúdo.

[altura,largura]=size(patio);
c_local = 1; % inicializando um contador. 
X=sum(patio(:) == 0);
vazio = zeros(X,2);

% Ordem que vai percorrer
    for k = (-altura:-1)  %corrigindo a ordem de verificação. Começando de baixo.
        i=k*(-1);

        for j = (1:largura)
        
            if (patio(i,j) == 0) 
                
                vazio(c_local,1) = i;
                vazio(c_local,2) = j;
                c_local = c_local + 1;    % lista de vazios/contêineres (posição no pátio)
            end
            
        end
   
    end
   
end