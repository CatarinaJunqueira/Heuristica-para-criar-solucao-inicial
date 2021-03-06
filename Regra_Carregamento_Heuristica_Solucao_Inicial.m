function [Nv] = Regra_Carregamento_Heuristica_Solucao_Inicial(Nv,conteiner,porto,altura_max)  %usando o porto de destino como prioridade!

%------------------------------------------------------------------------------------------------------%
% criando o vetor de prioridades com base no porto de destino dos
% conteineres que jah estao no navio
%------------------------------------------------------------------------------------------------------%
[~,coluna]=size(Nv);

if  length(find(Nv(1,:)~=0)) == coluna     
    msg = 'Problema na fun��o de carregamento!! N�o foi poss�vel carregar todos os containeres!! Espaco insufiente !! \n ';
    error(msg)
end

l=size(Nv,2); % quantidade de colunas desta baia
m=size(Nv,1); % quantidade de linhas desta baia
prioridade=zeros(1,l); % criando a lista de prioridades da baia
Pr=zeros(m,1);
N=max(max(porto(1,:)));

for j=1:l %Para j de 1 at� o n�mero de colunas.   
    if nnz(Nv(:,j))==0 % se a coluna est� vazia, entao a prioridade eh igual ao ultimo porto + 1
      prioridade(1,j)=N+1;
      continue
    end
    TF=isempty(find(Nv(:,j)==0, 1));
    if TF==0 % s� me�o a prioridade das colunas n�o cheias.  
       contador=1;
       for i = 1:m
           if Nv(i,j) ~=0
               [row]=find(porto(2,:)==Nv(i,j)); %encontrando a coluna na matriz 'porto' onde esta o conteiner(i,j)
               Pr(contador) =  porto(1,row); %colocando os portos de destino dos conteineres desta coluna em uma lista              
              contador=contador+1;
           end
       end
            %agora deve-se encontrar qual a maior prioridade desta coluna,
            %ou seja, o porto de destino mais pr�ximo
            prioridade(1,j)=min(Pr(Pr>0)); 
            Pr=zeros(m,1);
    end
end           
%------------------------------------------------------------------------------------------------------%
%------------------------------------------------------------------------------------------------------%       
        
    min_i=sort(prioridade);
    max_i=max(prioridade);
    marcador=1;
    marcador_2=1;
    [row2]=find(porto(2,:)==conteiner);
    prioridade_conteiner= porto(1,row2); 
    for h=1:l
        if min_i(h)>=prioridade_conteiner && min_i(h)~=0% se satisfeita a condi��o, ent�o colocar o conteiner nessa coluna n�o vai gerar nenhum movimento adicional.
           [~,col1] = find(prioridade==min_i(h));
           for i=1:size(col1,2)
               col=col1(i);
               [row]=find(Nv(:,col)==0);
               lin=row(end);           
               if lin >= altura_max %se a posicao estiver abaixo da altura m�xima, carregue
                 Nv(lin,col) = conteiner; 
                 marcador=0;
                 marcador_2=0;
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
            [row]=find(Nv(:,col)==0);
            lin=row(end);
            if  lin >= altura_max % se houver posicao abaixo da altura maxima, entao coloque
                Nv(lin,col) = conteiner;
                marcador_2=0;
                break
            end
        end      
    end
        
        %Agora tratar os casos acima da altura maxima
    if marcador_2~=0 %se marcador_2~=0 significa que o conteiner ainda nao foi colocado em nenhuma posicao abaixo da altura m�xima
        for h=1:l
            if min_i(h)>=prioridade_conteiner && min_i(h)~=0% se satisfeita a condi��o, ent�o colocar o conteiner nessa coluna n�o vai gerar nenhum movimento adicional.
               [~,col] = find(prioridade==min_i(h));
               col=col(1);
               [row]=find(Nv(:,col)==0);
               lin=row(end);
               %length(find(Nv(linha-altura_max(1,t)+1,:)~=0)) == coluna % se todas as linhas abaixo da altura m�xima estabelecida tiverem sido preenchidas, v� para as linhas de cima.
               if lin < altura_max %se a posicao estiver abaixo da altura m�xima, carregue
                 Nv(lin,col) = conteiner; 
                 marcador_2=0;
                 break          
               end
            end 
        end

        if marcador_2~=0 % caso em que nenhuma das prioridades eh maior do que 'conteiner'. Escolher a menos pior. 
            [~,col] = find(prioridade==max_i);
            for i=1:size(col,1)
                col=col(i);
                [row]=find(Nv(:,col)==0);
                lin=row(end);
                if  lin < altura_max % se houver posicao abaixo da altura maxima, entao coloque
                    Nv(lin,col) = conteiner;
                    break
                end
            end       
        end
    end      
            

end