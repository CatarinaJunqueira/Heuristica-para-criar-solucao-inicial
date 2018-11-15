function [Nv] = Rc_Heuristica_Solucao_Inicial(Nv,conteiner,porto,altura_max)  %usando o porto de destino como prioridade!

%------------------------------------------------------------------------------------------------------%
% criando o vetor de prioridades com base no porto de destino dos
% conteineres que jah estao no navio
%------------------------------------------------------------------------------------------------------%
[linha,coluna]=size(Nv);

if  length(find(Nv(1,:)~=0)) == coluna     
    msg = 'Problema na função de carregamento!! Não foi possível carregar todos os containeres!! Espaco insufiente !! \n ';
    error(msg)
end

%------------------------------------------------------------------------------------------------------%
% criando o vetor de prioridades com base no porto de destino dos
% conteineres que jah estao no navio
%------------------------------------------------------------------------------------------------------%
prioridade=zeros(1,coluna); % criando a lista de prioridades da baia
N=max(max(porto(1,:)));

for j=1:coluna
    if nnz(Nv(:,j))==0 % se a coluna está vazia, entao a prioridade eh igual ao ultimo porto + 1
       prioridade(1,j)=N+1;
       continue
    end
    TF=isempty(find(Nv(:,j)==0, 1));
    if TF==0 % só meço a prioridade das colunas não cheias.  
       X=Nv(:,j);    
       p=min(X(X>0));
       prioridade(j)=p;
    end

end

%------------------------------------------------------------------------------------------------------%
%------------------------------------------------------------------------------------------------------%
        
    min_i=sort(prioridade);
    max_i=max(prioridade);
    marcador=1;
    marcador_2=1;
    marcador_3=1;
    [row2]=find(porto(2,:)==conteiner);
    prioridade_conteiner= porto(1,row2); 
    for h=1:coluna
        if min_i(h)>=prioridade_conteiner && min_i(h)~=0% se satisfeita a condição, então colocar o conteiner nessa coluna não vai gerar nenhum movimento adicional.
           [~,col1] = find(prioridade==min_i(h));
           for i=1:size(col1,2)
               col=col1(i);
               [row]=find(Nv(:,col)==0);
               lin=row(end);           
               if lin > linha - altura_max %se a posicao estiver abaixo da altura máxima, carregue
             %----------------------------------------------------%
             % Nv(lin,col) = conteiner;
                 [ROW]=find(porto(2,:)==conteiner);
                 Nv(lin,col) = porto(1,ROW); %embarcando no navio o numero do porto de destino, ao invés do id do conteiner, para ficar como está no modelo matemático
             %----------------------------------------------------%  
                 marcador=0;
                 marcador_2=0;
                 marcador_3=0;
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
            if  lin > linha - altura_max % se houver posicao abaixo da altura maxima, entao coloque
             %----------------------------------------------------%
             % Nv(lin,col) = conteiner;
                 [ROW]=find(porto(2,:)==conteiner);
                 Nv(lin,col) = porto(1,ROW); %embarcando no navio o numero do porto de destino, ao invés do id do conteiner, para ficar como está no modelo matemático
             %----------------------------------------------------%
                marcador_2=0;
                marcador_3=0;
                break
            end
        end      
    end
    
%------------------------------------------------------------------------------------------------------%
% Verificar se, por acaso, ainda existem posicoes disponíneis abaixo da
% altura máxima que ainda não foram preenchidas.
%------------------------------------------------------------------------------------------------------%
                                                                                                                % se o nº de posições diferentes de zero na linha imediamente abaixo da altura máxima
if  length(find(Nv(linha - altura_max + 1,:)~=0)) ~= coluna && marcador_3==1; % não é o mesmo do nº de colunas, significa que ainda existem posições vazias abaixo da altura máxima
    s=sort(min_i,'descend');
    for h=2:coluna
    [~,col1] = find(prioridade==s(h)); %escolher a segunda posição menos pior
       for i=1:size(col1,2)
           col=col1(i);
           [row]=find(Nv(:,col)==0);
           lin=row(end);           
           if lin > linha - altura_max %se a posicao estiver abaixo da altura máxima, carregue
         %----------------------------------------------------%
         % Nv(lin,col) = conteiner;
             [ROW]=find(porto(2,:)==conteiner);
             Nv(lin,col) = porto(1,ROW); %embarcando no navio o numero do porto de destino, ao invés do id do conteiner, para ficar como está no modelo matemático
         %----------------------------------------------------%  
             marcador_2=0;
             marcador_3=0;
             break       
           end   
       end
           if marcador_3==0;
               break
          end
    end
end    
%------------------------------------------------------------------------------------------------------%
        %Agora tratar os casos acima da altura maxima%
%------------------------------------------------------------------------------------------------------%
        

    if marcador_2~=0 %se marcador_2~=0 significa que o conteiner ainda nao foi colocado em nenhuma posicao abaixo da altura máxima
        for h=1:coluna
            if min_i(h)>=prioridade_conteiner && min_i(h)~=0% se satisfeita a condição, então colocar o conteiner nessa coluna não vai gerar nenhum movimento adicional.
               [~,col] = find(prioridade==min_i(h));
               col=col(1);
               [row]=find(Nv(:,col)==0);
               lin=row(end);
               %length(find(Nv(linha-altura_max(1,t)+1,:)~=0)) == coluna % se todas as linhas abaixo da altura máxima estabelecida tiverem sido preenchidas, vá para as linhas de cima.
               if lin <= linha - altura_max %se a posicao estiver abaixo da altura máxima, carregue
             %----------------------------------------------------%
             % Nv(lin,col) = conteiner;
                 [ROW]=find(porto(2,:)==conteiner);
                 Nv(lin,col) = porto(1,ROW); %embarcando no navio o numero do porto de destino, ao invés do id do conteiner, para ficar como está no modelo matemático
             %----------------------------------------------------% 
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
                if  lin <= linha - altura_max % se houver posicao abaixo da altura maxima, entao coloque
             %----------------------------------------------------%
             % Nv(lin,col) = conteiner;
                 [ROW]=find(porto(2,:)==conteiner);
                 Nv(lin,col) = porto(1,ROW); %embarcando no navio o numero do porto de destino, ao invés do id do conteiner, para ficar como está no modelo matemático
             %----------------------------------------------------%
                    break
                end
            end       
        end
    end      

end