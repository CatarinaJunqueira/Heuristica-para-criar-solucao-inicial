function [Navio,Mov_Patio,Seq_Retirada] = Rt12(P,Navio,RegraCarregamento,porto) %Heuristica Caserta 2012
%-------------------------------------------------------------%
% identificando a regra de carregamento que vai ser utilizada % 
Rc = strcat('Rc',int2str(RegraCarregamento));

if (RegraCarregamento == 2) || (RegraCarregamento == 4) % se a regra Rc é a Rc2 ou a Rc4
   [~,n]=size(Navio);
   altura_max = ceil((length(find(P~=0)) + length(find(Navio ~= 0)))/n);
end
%-------------------------------------------------------------%

l=size(P,2); % quantidade de colunas do patio
m=size(P,1); % quantidade de linhas do patio

C=find(P~=0);
Mov_Patio = cell(1,size(C,1)); %Para salvar a movimentação do pátio
Mov_Patio{1,1}=P;
Seq_Retirada=zeros(1,size(C,1));
for i=1:size(C,1)
    %-------------------------------------------------------------%
    %Esta etapa identifica os portos de destino dos
    %conteineres que estao no topo de cada coluna
    Topos = zeros(2,l);
    for col=1:l
        for lin=1:m
            if P(lin,col)~=0
                if ((P(lin,col)-1 == 0) || (P(lin-1,col) == 0)) %Verifica se é topo ou se a posição acima é vazia.
                   [row]=find(porto(2,:)==P(lin,col)); %encontrando a coluna na matriz 'porto' onde está o conteiner(i,j)
                   Topos(1,col) =  porto(1,row); %colocando o porto de destino deste conteiner (que é topo) em uma lista
                   Topos(2,col) = P(lin,col);
                   break
                end 
            end
        end    
    end
    %-------------------------------------------------------------%

    %-------------------------------------------------------------%
    %Anotado o porto de destino de cada conteiner
    %que está no topo, verificar qual conteiner vai para
    %o porto mais distante.
    porto_max=max(Topos(1,:));
    for h=1:size(Topos,2)
        if Topos(1,h)==porto_max
            conteiner_sair=Topos(2,h);
            break
        end    
    end
    %-------------------------------------------------------------%

    %-------------------------------------------------------------%
    %Retirar o conteiner do patio e carregar no navio
    [row_n,col_n]=find(P==conteiner_sair);
    P(row_n,col_n)=0; % Tira do patio
    Mov_Patio{1,i+1}=P; % Salvando a movimentação do pátio
    Seq_Retirada(1,i)=conteiner_sair;
    if (RegraCarregamento == 2) || (RegraCarregamento == 4) % Carrega no navio
       [Navio] = feval(Rc,Navio,conteiner_sair,altura_max); %chamando a regra de carregamento no navio
    else
       [Navio] = feval(Rc,Navio,conteiner_sair,porto); %chamando a regra de carregamento no navio                       
    end
    %-------------------------------------------------------------%

end
end