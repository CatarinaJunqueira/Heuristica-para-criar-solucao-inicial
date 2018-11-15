function  [Nv,q_d,q_r,q_c] = Rc_Desc_Heuristica_Solucao_Inicial(Nv,c,altura_max,q_d,q_r,q_c)

[linha,coluna]=size(Nv);

if  length(find(Nv(1,:)~=0)) == coluna     
    msg = 'Problema na fun��o de carregamento!! N�o foi poss�vel carregar todos os containeres!! Espaco insufiente !! \n ';
    error(msg)
end

%------------------------------------------------------------------------------------------------------%
% criando o vetor de prioridades com base no porto de destino dos
% conteineres que jah estao no navio
%------------------------------------------------------------------------------------------------------%
prioridade=zeros(1,coluna); % criando a lista de prioridades da baia
N=max(max(Nv));

for j=1:coluna
    if nnz(Nv(:,j))==0 % se a coluna est� vazia, entao a prioridade eh igual ao ultimo porto + 1
       prioridade(1,j)=N+1;
       continue
    end
    TF=isempty(find(Nv(:,j)==0, 1));
    if TF==0 % s� me�o a prioridade das colunas n�o cheias.  
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
for h=1:coluna
     if min_i(h)>=c && min_i(h)~=0% se satisfeita a condi��o, ent�o colocar o conteiner nessa coluna n�o vai gerar nenhum movimento adicional.
        [~,col1] = find(prioridade==min_i(h));
        for i=1:size(col1,2)
             col=col1(i);
             [row]=find(Nv(:,col)==0);
             lin=row(end);         
             if lin> linha - altura_max %se a posicao estiver abaixo da altura m�xima, carregue
                Nv(lin,col) = c; %carregue
                q_d = [q_d,c];
                q_r = [q_r,lin];
                q_c = [q_c,col];
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
            Nv(lin,col) = c; %carregue
            q_d = [q_d,c];
            q_r = [q_r,lin];
            q_c = [q_c,col];
            marcador_2=0;
            marcador_3=0;
            break
        end
    end      
end

%------------------------------------------------------------------------------------------------------%
% Verificar se, por acaso, ainda existem posicoes dispon�neis abaixo da
% altura m�xima que ainda n�o foram preenchidas.
%------------------------------------------------------------------------------------------------------%
                                                                                                                % se o n� de posi��es diferentes de zero na linha imediamente abaixo da altura m�xima
if  length(find(Nv(linha - altura_max + 1,:)~=0)) ~= coluna && marcador_3==1; % n�o � o mesmo do n� de colunas, significa que ainda existem posi��es vazias abaixo da altura m�xima
    s=sort(min_i,'descend');
    for h=2:coluna
    [~,col1] = find(prioridade==s(h)); %escolher a segunda posi��o menos pior
       for i=1:size(col1,2)
           col=col1(i);
           [row]=find(Nv(:,col)==0);
           lin=row(end);           
           if lin > linha - altura_max %se a posicao estiver abaixo da altura m�xima, carregue
             Nv(lin,col) = c;
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
        
if marcador_2~=0 %se marcador_2~=0 significa que o conteiner ainda nao foi colocado em nenhuma posicao abaixo da altura m�xima
    for h=1:coluna
        if min_i(h)>=c && min_i(h)~=0% se satisfeita a condi��o, ent�o colocar o conteiner nessa coluna n�o vai gerar nenhum movimento adicional.
           [~,col] = find(prioridade==min_i(h));
           col=col(1);
           [row]=find(Nv(:,col)==0);
           lin=row(end);
           if lin <= linha - altura_max %se a posicao estiver abaixo da altura m�xima, carregue
             Nv(lin,col) = c;
            q_d = [q_d,c];
            q_r = [q_r,lin];
            q_c = [q_c,col];             
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
                Nv(lin,col) = c;
                q_d = [q_d,c];
                q_r = [q_r,lin];
                q_c = [q_c,col];             
                break
            end
        end       
    end
end    

end