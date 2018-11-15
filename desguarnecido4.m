
%----------------------------------------%
% localiza posições vazias que são topo ou      9 6 3
% chão para a regra Rt4:                        8 5 2
%                                               7 4 1
% Funcao desguarnecido - localiza posicoes vazias nas quais um conteiner que precisa ser
% remanejado pode ser colocado. Localiza apenas as posicoes que sao topo ou
% chao. Nao faz uma lista com todas as posicoes vazias no patio. Assim eh
% mais rapido.
%----------------------------------------%

function [vazio] = desguarnecido4(patio,posicao_navio) % localiza posição e não conteúdo.

[linha,coluna]=size(patio);
%pos_altura = posicao_navio(1,1); %posição 
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

colunas_p = coluna:-1:1 ;
colunas_p = colunas_p(colunas_p~=pos_larg);
% Ordem que vai percorrer
    for k = colunas_p  %corrigindo a ordem de verificação. Começando de baixo.
         for i = (linha:-1:2)        
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
    end   
    
    if size(vazio,1)==0
       msg = 'Problema na função desguarnecido4 !! size(vazio,1)=0. ';
       error(msg) 
    end
end