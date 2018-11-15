%/***************************************************************/
%/* Crossover selection: selects two parents that take part in  */
%/* the crossover. Implements a single point crossover          */
%/***************************************************************/

function population = crossover(POPSIZE, PXOVER, NVARS, population)
   
   first = 0;
   % Calculando o fitness maximo da funcao.
  % fmax = max([population.fitness]);
   % Calculando o fitness medio.
   %fmean = mean([population.fitness]);
  % k1 = 0.5;
   % Calculando a taxa de crossover de acordo com a populacao.
   for mem=1:POPSIZE
      x = rand;
   %   fm = max(population(mem).fitness,population(mem+1).fitness);
      %PXOVER = k1*(fmax-fm)/(fmax-fmean);
      if (x < PXOVER)
        first = first + 1;
        if (rem(first,2) == 0)
            population = Xover(one, mem, NVARS, population);
        else
            one = mem;  
        end
      end   
   end  
