%/***************************************************************/
%/* Report function: Reports progress of the simulation. Data   */
%/* dumped into the output file are separated by commas         */
%/***************************************************************/

function [xrep] = report(POPSIZE, population)
  
   % Inicialização de variáveis.
   sum = 0.0;
   sum_square = 0.0;
   
   % Iniciando os cálculos para as estatísticas relativas
   % ao valor da função objetivo (fitness).
   for i=1:POPSIZE
     sum = sum + population(i).fitness;
     sum_square = sum_square + population(i).fitness*population(i).fitness;  
   end
   
   avg = sum/POPSIZE;
   square_sum = avg*avg*POPSIZE;
   stddev = sqrt((sum_square - square_sum)/(POPSIZE-1));
   best_val = population(POPSIZE+1).fitness;
   %best_val = 1/population(POPSIZE+1).fitness - 1;
   
%    % Iniciando os cálculos para as estatísticas relativas
%    % a violação das restrições (unfitness).
%    sum = 0.0;
%    sum_square = 0.0;
%    for i=1:POPSIZE
%      sum = sum + population(i).unfitness;
%      sum_square = sum_square + population(i).unfitness*population(i).unfitness;  
%    end
%    
%    avgu = sum/POPSIZE;
%    square_sumu = avg*avg*POPSIZE;
%    stddevu = sqrt((sum_square - square_sum)/(POPSIZE-1));
%    best_valu = population(POPSIZE+1).unfitness;


   % Vector with essential information about population information. 
   %xrep = [best_val avg stddev best_valu avgu stddevu];    
   xrep = [best_val avg stddev];    
