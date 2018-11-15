% Função que realiza a simulação das regras de uma 
% entrada e saida fornecida por uma dada solucao.

%[M,value] = simulaRegras(navio{k,1:1},patio{k,1:1},porto{k,1:1},Rt,Rc,Rd,M,k,length(v));
    
function [Navio,value] = simulaRegras(patio,porto,RegraRetirada,RegraCarregamento,RegraDescarregamento,Navio,k)

value = 0; % Numero de movimentos realizados para carregar e descarregar
           % containeres durante a viagem de um navio por P portos.

if k==1 % Verificando se nao estamos no primeiro porto onde os conteineres sao apenas carregados !!
  [MovGeral,Navio] = Rt(patio,RegraRetirada,Navio,RegraCarregamento,porto);
  value=value+MovGeral;      
end    

if k~=1 % Do porto 2 ateh P-1, primeiro descarregado do navio e depois carrega os conteineres que tem destino os portos seguintes.           
   [MovGeral,Navio] = Rd(Navio, k, porto,RegraRetirada,RegraCarregamento,RegraDescarregamento);
    value=value+MovGeral;

   [MovGeral,Navio] = Rt(patio,RegraRetirada,Navio,RegraCarregamento,porto); % Caso retirando os cont com base no navio de destino 
   value=value+MovGeral;
end
  
end