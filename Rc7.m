function [Nv] = Rc7(Nv,conteiner,porto)  %usando o porto de destino como prioridade!

%for t=1:size(Navio,2) % de 1 ateh o numero de baias
   % if isempty(find(Navio{1,t}==0, 1)) ~=1     % Se ainda tem posicao disponivel na baia t para alocar o conteiner, entao coloque nesta baia
   % Nv=Navio{1,t};
    
%------------------------------------------------------------------------------------------------------%
% criando o vetor de prioridades com base no porto de destino dos
% conteineres que jah estao no navio
%------------------------------------------------------------------------------------------------------%
l=size(Nv,2); % quantidade de colunas desta baia
m=size(Nv,1); % quantidade de linhas desta baia
prioridade=zeros(1,l); % criando a lista de prioridades da baia
Pr=zeros(m,1);
N=max(max(porto(1,:)));

for j=1:l %Para j de 1 até o número de colunas.   
    if nnz(Nv(:,j))==0 % se a coluna está vazia, entao a prioridade eh igual ao ultimo porto + 1
      prioridade(1,j)=N+1;
      continue
    end
    TF=isempty(find(Nv(:,j)==0, 1));
    if TF==0 % só meço a prioridade das colunas não cheias.  
       contador=1;
       for i = 1:m
           if Nv(i,j) ~=0
               [row]=find(porto(2,:)==Nv(i,j)); %encontrando a coluna na matriz 'porto' onde esta o conteiner(i,j)
               Pr(contador) =  porto(1,row); %colocando os portos de destino dos conteineres desta coluna em uma lista              
              contador=contador+1;
           end
       end
            %agora deve-se encontrar qual a maior prioridade desta coluna,
            %ou seja, o porto de destino mais próximo
            prioridade(1,j)=min(Pr(Pr>0)); 
            Pr=zeros(m,1);
    end
end           
%------------------------------------------------------------------------------------------------------%
%------------------------------------------------------------------------------------------------------%       
        
    min_i=sort(prioridade);
    max_i=max(prioridade);
    marcador=1;
    [row2]=find(porto(2,:)==conteiner);
    prioridade_conteiner= porto(1,row2); 
    for h=1:l
        if min_i(h)>=prioridade_conteiner && min_i(h)~=0% se satisfeita a condição, então colocar o conteiner nessa coluna não vai gerar nenhum movimento adicional.
           [~,col] = find(prioridade==min_i(h));
           col=col(1);
           [row]=find(Nv(:,col)==0);
           lin=row(end);
           Nv(lin,col) = conteiner; 
           marcador=0;
           break
        end 
    end

    if marcador==1 % caso em que nenhuma das prioridades eh maior do que 'conteiner'. Escolher a menos pior. 
        [~,col] = find(prioridade==max_i);
        col=col(1);
        [row]=find(Nv(:,col)==0);
        lin=row(end);
        Nv(lin,col) = conteiner; 
    end        
        
%     Navio{1,t}=Nv;  
  %   break
   % end
%end
end