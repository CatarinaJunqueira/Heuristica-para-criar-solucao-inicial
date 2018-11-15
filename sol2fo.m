% Funcao que calcula o valor de uma dada solucao
% de carregamento e descarregamento para um navio
% que passa em n portos (observe que o numero de 
% regras eh sempre n-1, pois no ultimo porto so 
% resta realizar o descarregamento !). 
%  [fitness] = sol2fo(population(mem).gene,patio,Navio,navio,porto,ultima_geracao); 
function [fo] = sol2fo(v,patio,M,porto)
  % M = Navio
  total = 0;
  
  % Laço para transformar os índices k do vetor
  % em regras de entrada e saida para o porto k
  % e depois testar estas regras de entrada e saida.
  for k=1:length(v)
      
    % Obter regras para a i-esima componente da 
    % solucao contida no vetor v.
    %[fre,frs] = num2Rules(v(k));
    [Rt,Rc,Rd] = num2Rules2D(v(k));
    
%          if (ultima_geracao == 1)
%         
%          vm = {M};
%          drawShip(0,0,0,1,vm);
%              
%         end
    % Empregar as regras para uma dada linha i da 
    % matriz de demandas (corresponde as demandas
    % de containeres para um dado porto i).

    [M,value] = simulaRegras(patio{k,1:1},porto,Rt,Rc,Rd,M,k);   
    % Contabilizando o numero total de movimentos.
    total = total + value;
  
  end
  
  % Qualquer que seja a regra do ultimo para o ultimo porto, sempre sera
  % contabilizado o mesmo numero de movimentos que corresponde ao numero de
  % containeres cujo destino eh o ultimo porto. Este numero eh a quantidade
  % de conteineres que restam no navio quando o mesmo chega ao ultimo porto
  %  total = total + length(find(M~=0)); %conferir -> nao eh movimento de
  %  remanejamento
    
  fo = total;
end