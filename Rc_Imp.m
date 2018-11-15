%----------------------------------------------------%
%----------------------------------------------------%
% Elaboração da Regra R1 de Carregamento.            %
%----------------------------------------------------%
%----------------------------------------------------%
% Procedimento de preenchimento:                     %
%----------------------------------------------------%
%  (1) Considera-se que a ordem de preenchimento
%      das cargas no navios ->, por linha, da esquerda 
%      para a direita, de baixo para cima.  
%    m ^
%        |4 5 6
%        |1 2 3
%      1 -----> 
%        1    n
%
%  (2) Coloca um contêiner de cada vez, conforme
%      eles vão sendo retirados do pátio.
%
%  (3) Retorna a matrix que representa o navio, preenchida
%      de acordo com a regra de carregamento Rc1.
%----------------------------------------------------%
function [Patio_Transb] = Rc_Imp(Patio_Transb,conteiner) 

[linha,coluna]=size(Patio_Transb);

if  length(find(Patio_Transb(1,:)~=0)) == coluna     
    msg = 'Problema na função Rc_Imp !! Não foi possível carregar todos os containeres!! Espaco insufiente !! \n ';
    error(msg)
end

prioridade=zeros(1,coluna); % criando a lista de prioridades da baia
%Pr=zeros(m,1);
N=max(max(Patio_Transb));

for j=1:coluna %Para j de 1 ateh o número de colunas.   
    if nnz(Patio_Transb(:,j))==0 % se a coluna está vazia, entao a prioridade eh igual à maior prioridade encontrada no pátio + 1
      prioridade(1,j)=N+1;
      continue
    end
    TF=isempty(find(Patio_Transb(:,j)==0, 1)); % verifica se tem alguma posicao vazia na coluna j
    if TF==0  % só meço a prioridade das colunas não cheias 
       X=Patio_Transb(:,j);    
       x=min(X(X>0));
       prioridade(1,j)=x; % valor do menor contêiner da coluna k
    end
end












% Ordem que vai percorrer
    for i = (linha:-1:1) %corrigindo a ordem de verificação.
         for k = 1:coluna   
             if Patio_Transb(i,k) == 0
                Patio_Transb(i,k) = conteiner;                  
                conteiner=0;     
                break
             end
         end
         
         if conteiner == 0
            break
         end
         
    end  
end
