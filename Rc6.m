function [Navio] = Rc6(Navio,conteiner)  %Regra da menor coluna 

for t=1:size(Navio,2) % de 1 ateh o numero de baias
    if isempty(find(Navio{1,t}==0, 1)) ~=1     % Se ainda tem posicao disponivel na baia t para alocar o conteiner, entao coloque nesta baia
      Nv=Navio{1,t};
      prioridade=zeros(1,size(Nv,2));
      for k=1:size(Nv,2) %Para k de 1 até o número de colunas.
           prioridade(1,k)=nnz(Nv(:,k));  % Para determinar onde r deve ser realocado, é feita uma medida de da altura de cada coluna     
      end
      min_i=unique(prioridade);
      for h=1:size(min_i,2)
          if  min_i(h)~=size(Nv,1) % se a coluna nao estah cheia
             [~,col] = find(prioridade==min_i(h));
             col=col(1);             
             [row]=find(Nv(:,col)==0);
             linha=row(end);
             Nv(linha,col)=conteiner; % Colocando-o na posicao vazia
             conteiner=0;
             break
          end 
      end
      if conteiner == 0
              Navio{1,t}=Nv;
            break         
      end       
    end
end
end