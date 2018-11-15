%patio=[0,0,0,0,0;0,0,15,16,0;11,12,13,14,0;6,7,8,9,10;1,2,3,4,5];
% posicao_navio=[5,5];
%  *___Resposta a ser obtida___*

%----------------------------------------%
% localiza posições vazias que são topo ou      7 8 9
% chão para a regra Rt5:                                  6 5 4
%                                                                   1 2 3
% Funcao desguarnecido - localiza posicoes vazias nas quais um conteiner que precisa ser
% remanejado pode ser colocado. Localiza apenas as posicoes que sao topo ou
% chao. Nao faz uma lista com todas as posicoes vazias no patio. Assim eh
% mais rapido.
%----------------------------------------%

function [vazio] = desguarnecido5(patio,posicao_navio) % localiza posição e não conteúdo.

[linha,coluna]=size(patio);
pos_larg = posicao_navio(1,2);
c_local = 1; % inicializando um contador. 

%Criando o vetor vazio
T=length(find(patio(:,pos_larg)~=0)); % T é a qntd de cont existentes na coluna do cont que eu quero tirar
if T == coluna
   % se a coluna do cont que eu quero tirar está completa
   vazio = zeros(length(find(patio(1,:)==0)),2); 
else
    % se a coluna do cont que eu quero tirar não está completa
   vazio = zeros(length(find(patio(1,:)==0))-1,2);
end

colunas_p = 1:coluna;
colunas_p = colunas_p(colunas_p~=pos_larg);

colunas_pp = coluna:-1:1;
colunas_pp = colunas_pp(colunas_pp~=pos_larg);

% Ordem que vai percorrer
    for i = (linha:-1:2)  %corrigindo a ordem de verificação.
        if mod(i,2) ~= 0 % se a linha for impar
            for k = colunas_p   
               if patio(i,k)~= 0 % se a posicao eh diferente de zero
                   if patio(i-1,k)== 0 % se a posicao acima eh zero
                    vazio(c_local,1) = i-1; % então insere
                    vazio(c_local,2) = k;
                    colunas_p = colunas_p(colunas_p~=k) ;
                    c_local = c_local + 1;    % lista de vazios/contêineres (posição no pátio)                   
                   end

               else
                    if (i==linha) % se eh chao
                        vazio(c_local,1) = i;
                        vazio(c_local,2) = k;
                        colunas_p = colunas_p(colunas_p~=k) ;
                        c_local = c_local + 1;    % lista de vazios/contêineres (posição no pátio)
                    end
               end
            end
        else % se a linha for par
            for k = colunas_pp
                if patio(i,k)~= 0 % se a posicao eh diferente de zero
                   if patio(i-1,k)== 0 % se a posicao acima eh zero
                    vazio(c_local,1) = i-1; % então insere
                    vazio(c_local,2) = k;
                    colunas_pp = colunas_pp(colunas_pp~=k) ;
                    c_local = c_local + 1;    % lista de vazios/contêineres (posição no pátio)                   
                   end

               else
                    if (i==linha) % se eh chao
                        vazio(c_local,1) = i;
                        vazio(c_local,2) = k;
                        colunas_pp = colunas_pp(colunas_pp~=k) ;
                        c_local = c_local + 1;    % lista de vazios/contêineres (posição no pátio)
                    end
                end                
            end            
        end   
    end   
    if size(vazio,1)==0
       msg = 'Problema na função desguarnecido5 !! size(vazio,1)=0. ';
       error(msg) 
    end
end