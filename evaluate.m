% Funcao responsavel por realizar a avaliacao das solucoes 
% propostas pelo algoritmo genetico.
function [population,melhor_fitness,melhor_regra] = evaluate(POPSIZE,population,Navio,porto,patio)
         
   %--------------------------------------------//   
   % Calculation of costs by the rules for      //
   % each member in the population !!!          // 
   %--------------------------------------------//
   
   fitness = zeros(POPSIZE,1);
%   ultima_geracao = zeros(POPSIZE,1);
    
 %  parfor mem=1:POPSIZE    
   for mem=1:POPSIZE    
%         if (mem == POPSIZE && generation == MAXGENS)
%         ultima_geracao(mem) = 1;
%         end
           
     [fitness(mem)] = sol2fo(population(mem).gene,patio,Navio,porto); 
                                               
     % Considerando a medida de infactibilidade no fitness, pois 
     % como o problema é de minimização quanto maior o fitness
     % e a infactibilidade, pior é a solução.
     population(mem).fitness = 1/(1 + fitness(mem));
   end 
   melhor_fitness=min(fitness);
   [r,~]=find(fitness==melhor_fitness);
   melhor_regra=population(r).gene;
end
      
       