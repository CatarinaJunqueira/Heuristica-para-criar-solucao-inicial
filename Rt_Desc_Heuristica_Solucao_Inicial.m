function [Navio,Mov_Geral,q_o,q_d,q_r,q_c] = Rt_Desc_Heuristica_Solucao_Inicial(P,Navio,NPorto)
q_o = [];
q_d = [];
q_r = [];
q_c = [];

Mov_Geral=0;
%-------------------------------------------------------------%
[linha,n]=size(Navio);
altura_max = ceil((length(find(P~=0)) + length(find(Navio ~= 0)))/n);
%-------------------------------------------------------------%

l=size(P,2); % quantidade de colunas do patio
m=size(P,1); % quantidade de linhas do patio

C=find(P~=0);
%Mov_Patio = cell(1,size(C,1)); %Para salvar a movimentação do pátio
%Mov_Patio{1,1}=P;
%Seq_Retirada=zeros(1,size(C,1));


C=find(P~=0);
for x=1:size(C,1)
    Topos = zeros(1,l);
    for j=1:l
        i=find(P(:,j)>0); % em cada coluna, traz a linha dos elementos diferentes de 0
        if isempty(i)~=1
             Topos(1,j) =  P(i(1),j); %colocando o porto de destino em uma lista
        end

    end

    %-------------------------------------------------------------%
    %Anotado o porto de destino de cada conteiner que está no topo,
    % verificar qual conteiner vai para o porto mais distante.
    porto_max=max(Topos);
    for h=1:l
        if Topos(1,h)==porto_max
            conteiner_carregar=Topos(1,h);
            i=find(P(:,h)>0);
            P(i(1),h)=0;
            [Navio,q_d,q_r,q_c] = Rc_Desc_Heuristica_Solucao_Inicial(Navio,conteiner_carregar,altura_max,q_d,q_r,q_c);%chamando a regra de carregamento no navio   
            break
        end    
    end
end



%------------------------------------------------------------------------------------------------------%
% Verificar se, por acaso, algum contêiner ficou acima da altura_máxima
% permitida neste porto.
%------------------------------------------------------------------------------------------------------%

r=isempty(find(Navio(linha - altura_max,:), 1));

if  r==0 % se tem contêineres acima da altura máxima permitida, mover
%------------------------------------------------------------------------------------------------------%
% identificar os contêineres a serem movidos
%------------------------------------------------------------------------------------------------------%  
u=length(find(Navio(linha - altura_max,:)~=0));
lista_mover=zeros(u,3);
contador=1;
    for i=1:(altura_max-1) % percorrer as linhas acima da altura máxima
        for j=1:n
            if Navio(i,j)~=0
                lista_mover(contador,1)= Navio(i,j);
                lista_mover(contador,2)=i;
                lista_mover(contador,3)=j;
                contador=contador+1;
            end
        end
    end
    
    prioridade=zeros(1,n); % criando a lista de prioridades da baia
    N=max(max(Navio));
    for y=1:u  %% y de 1 até o número de contêineres acima da altura máxima
        %------------------------------------------------------------------------------------------------------%
        % criar o vetor de prioridades
        %------------------------------------------------------------------------------------------------------%
        for j=1:n % de 1 ao número de colunas no navio 
            if nnz(Navio(:,j))==0 % se a coluna está vazia, entao a prioridade eh igual ao ultimo porto + 1
               prioridade(1,j)=N+1;
               continue
            end
            TF=isempty(find(Navio(:,j)==0, 1));
            if TF==0 % só meço a prioridade das colunas não cheias.  
               X=Navio(:,j);    
               p=min(X(X>0));
               prioridade(j)=p;
            end
        end

       %------------------------------------------------------------------------------------------------------%
       %------------------------------------------------------------------------------------------------------%
        min_i=sort(prioridade);
        max_i=max(prioridade);
        marcador=1;
        for h=1:n
             if min_i(h)>=lista_mover(y,1) && min_i(h)~=0% se satisfeita a condição, então colocar o conteiner nessa coluna não vai gerar nenhum movimento adicional.
                [~,col1] = find(prioridade==min_i(h));
                for i=1:size(col1,2)
                     col=col1(i);
                     [row]=find(Navio(:,col)==0);
                     lin=row(end);         
                     if lin> linha - altura_max %se a posicao estiver abaixo da altura máxima, carregue
                        Navio(lin,col) = lista_mover(y,1); %carregue
                        Navio(lista_mover(y,2),lista_mover(y,3))=0;
                        q_o=[q_o,NPorto];
                        q_d = [q_d,lista_mover(y,1)];
                        q_r = [q_r,lin];
                        q_c = [q_c,col];
                        Mov_Geral=Mov_Geral+1;
                        marcador=0;
                        break 
                     end
                end
             end
                if marcador==0
                    break
                end
        end

        if marcador==1 % caso em que nenhuma das prioridades eh maior do que 'conteiner'. Escolher a menos pior. 
            [~,col1] = find(prioridade==max_i);
            for i=1:size(col1,2)
                col=col1(i);
                [row]=find(Navio(:,col)==0);
                lin=row(end);
                if  lin > linha - altura_max % se houver posicao abaixo da altura maxima, entao coloque
                    Navio(lin,col) = lista_mover(y,1); %carregue
                    Mov_Geral=Mov_Geral+1;
                    q_o=[q_o,NPorto];
                    q_d = [q_d,lista_mover(y,1)];
                    q_r = [q_r,lin];
                    q_c = [q_c,col];
                    break
                end
            end      
        end        
    end    
end


end