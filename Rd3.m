% Nome: Regra de Descarregamento 3 - Rd3 

%---------------------------------------------------------------------%
%   Regra de Descarregamento do Navio (Rd3)     %
%---------------------------------------------------------------------%
%Nesta regra, quando o navio chega a um porto p, são removidos todos os
%contêineres cujo destino é p e os remanejamentos sao feitos dentro do
%navio (na mesma baia) quando este movimento nao gere um remanejamento 
%futuro. Caso contrario eh retirado do navio e depois carregado novamente.

%IMPORTANTE: a matriz porto contem na primeira linha o porto de destino de
%cada conteiner, e na segunda linha o indice de identificacao de cada
%conteiner


function [MovGeral, Navio] = Rd3(Navio,NPorto,porto,RegraRetirada,RegraCarregamento)

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
   [bool] = topo_navio(Navio,lista_descarregamento(1,:)); % verifica se eh topo ou nao
   %------------------------------------%
   % Primeiro verifica-se se existem contêineres que estão na lista l_navio que estão no topo de suas colunas e podem ser retirados sem remanejamento 

  if (bool == 1) % Está no topo(1), ou seja, não é necessário mais que uma movimentacao de conteiner
     Navio{1,lista_descarregamento(1,3)}(lista_descarregamento(1,1),lista_descarregamento(1,2))=0;  % se eh topo, entao sai.
  else % se nao eh topo, entao retirar o conteiner e quem estah acima dele

     acima = quem_acima_navio(Navio,lista_descarregamento(1,:)); %vejo quem está acima dessa posição
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
                        A=acima(contador,:);
                        row_n = A(1,1); % posicao do conteiner a ser remanejado
                        col_n = A(1,2);
                        r=Navio{1,lista_descarregamento(1,3)}(row_n,col_n); % bloco a ser movido de acordo com a política LIFO.
                        
                        [prioridade]=Prioridade(col_n,Navio{1,lista_descarregamento(1,3)},porto);
                        
                        TF = isempty(find(prioridade>NPorto, 1));
                        
                        if TF~= 1 % se existe posicao onde realocar um conteiner na mesma baia sem gerar um novo remanejamento.  
                           min_i=sort(prioridade);
                           [coluna] = find(min_i>NPorto);
                           [C] = find(prioridade==min_i(1,coluna(1))); % coluna onde posso realocar o conteiner r
                           [Nv] = trocar_Heuristica_Caserta(Navio{1,lista_descarregamento(1,3)},C(1),r,row_n,col_n); % Remanejar r
                           Navio{1,lista_descarregamento(1,3)}=Nv;
                           MovGeral=MovGeral+1;
                           acima(contador,:)=0; %transforma o valor em 0, indica que ja foi visto
                           contador=contador+1; 
                           
                        else % se nao ha onde realocar na mesma baia, entao retirar do navio
                              % [patio_transb] = Rc_Imp(patio_transb,r); % retira os contêineres que estão acima e os coloca no lugar reservado do pátio 
                               [patio_transb] = Rc_Imp_Prioridades(patio_transb,r); 
                               Navio{1,lista_descarregamento(1,3)}(row_n,col_n)=0;
                               MovGeral=MovGeral+1;                                           
                               acima(contador,:)=0; %transforma o valor em 0, indica que ja foi visto
                               contador=contador+1;   
                        end                                     

                        if sum(sum(acima))==0
                            break
                        end
                    end                            
                end
% Termina de retirar quem estava acima
%-------------------------------------------------------------------------%
% Agora pode retirar o conteiner objetivo  

     Navio{1,lista_descarregamento(1,3)}(lista_descarregamento(1,1),lista_descarregamento(1,2))=0;                               
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
     switch RegraRetirada
        case 7
                [MovGeralTransbordo,Navio] = Rt7(patio_transb,Navio,RegraCarregamento,porto);
                MovGeral=MovGeral+MovGeralTransbordo; 
        case 8
                [MovGeralTransbordo,Navio] = Rt8(patio_transb,Navio,RegraCarregamento,porto);
                MovGeral=MovGeral+MovGeralTransbordo; 
        case 9
                [MovGeralTransbordo,Navio] = Rt9(patio_transb,Navio,RegraCarregamento,porto);
                MovGeral=MovGeral+MovGeralTransbordo; 
        case 10
                [MovGeralTransbordo,Navio] = Rt10(patio_transb,Navio,RegraCarregamento,porto);
                MovGeral=MovGeral+MovGeralTransbordo; 
        otherwise      
               [MovGeralTransbordo,Navio] = Rt_descarregamento(patio_transb,RegraRetirada,Navio,RegraCarregamento,porto);
               MovGeral=MovGeral+MovGeralTransbordo;    
    end
end
 
end



