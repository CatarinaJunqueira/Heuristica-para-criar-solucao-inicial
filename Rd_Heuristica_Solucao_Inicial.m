% Nome: Regra de Descarregamento 1 - Rd1 

%---------------------------------------------------------------------%
%              Regra de Descarregamento do Navio (Rd1)                %
%---------------------------------------------------------------------%
%Nesta regra, quando o navio chega a um porto p, são removidos todos os
%contêineres cujo destino é p e todos os contêineres que estão acima dos
%contêineres do porto p e cujos destinos são os portos p+j

%IMPORTANTE: a matriz porto contem na primeira linha o porto de destino de
%cada conteiner, e na segunda linha o indice de identificacao de cada
%conteiner


function [MovGeral, Navio,q_o,q_d,q_r,q_c] = Rd_Heuristica_Solucao_Inicial(Navio,NPorto,porto)

q_o=[];
q_d = [];
q_r = [];
q_c = [];
MovGeral=0;
kk=length(find(porto(1,:)==NPorto)); %quantidade de conteineres que serao desembarcados neste porto (o porto NPorto)
kk=kk*5;
patio_transb=zeros(6,ceil((kk/6)*1.5)); % área reservada para os contêineres de transbordo
if size(patio_transb,2)==1;
    patio_transb=zeros(6,3);
end
[lista_descarregamento] = Quem_Sai(Navio,porto,NPorto);


u=isempty(lista_descarregamento);
while u~=1
   [bool] = topo(Navio,lista_descarregamento(1,:)); % verifica se eh topo ou nao
   %------------------------------------%
   % Primeiro verifica-se se existem contêineres que estão na lista l_navio que estão no topo de suas colunas e podem ser retirados sem remanejamento 

  if (bool == 1) % Está no topo(1), ou seja, não é necessário mais que uma movimentacao de conteiner
     Navio(lista_descarregamento(1,1),lista_descarregamento(1,2))=0;  % se eh topo, entao sai.

  else % se nao eh topo, entao retirar o conteiner e quem estah acima dele

     acima = quem_acima(Navio,lista_descarregamento(1,:)); %vejo quem está acima dessa posição
     qtde_troca = 1;
     trocas =0;

    while(qtde_troca > 0)
         qtde_troca = 0; %Condicao de parada
         max_acima = size(acima,1);

            if (trocas == max_acima) 
                break
            else
                trocas = trocas +1;
            end

               t = size(acima,1); %quantidade de contêineres acima
               contador=1;

                for k = (1:t) % de 1 até quantidade de contêineres acima
                    if (acima(contador)~=0)
                       [patio_transb] = Rc_Imp(patio_transb,Navio(acima(contador,1),acima(contador,2))); % retira os contêineres que estão acima e colocá-os no lugar reservado do pátio
                       q_o = [q_o, NPorto];
                       Navio(acima(contador,1),acima(contador,2))=0;
                       MovGeral=MovGeral+1;                                           
                       acima(contador,:)=0; %transforma o valor em 0, indica que ja foi visto
                       contador=contador+1;                                        

                        if sum(sum(acima))==0
                            break
                        end
                    end                            
                end
% Termina de retirar quem estava acima
%-------------------------------------------------------------------------%
% Agora pode retirar o conteiner objetivo  

     Navio(lista_descarregamento(1,1),lista_descarregamento(1,2))=0; 
     %MovGeral=MovGeral+1;                                  
    end
  end
 [lista_descarregamento] = Quem_Sai(Navio,porto,NPorto);
 u=isempty(lista_descarregamento);
 uu= unique(lista_descarregamento);
    if uu==0
        u=1;
    end    
end

% Terminado o descarregamento
%-------------------------------------------------------------------------%
% Agora é necessário carregar de volta os contêineres que foram
% descarregados, mas que não tinham como destino final este porto.
 if nnz(patio_transb) ~=0
    [Navio,Mov,o,q_d,q_r,q_c] = Rt_Desc_Heuristica_Solucao_Inicial(patio_transb,Navio,NPorto);
     q_o = [q_o, o];
    MovGeral=MovGeral+Mov;
 end
end



