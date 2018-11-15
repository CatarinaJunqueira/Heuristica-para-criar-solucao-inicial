%/***************************************************************/
%/* Crossover: performs crossover of the two selected parents.  */
%/***************************************************************/

function population = Xover(one, two, NVARS, population)
  
  % select crossover point
  if (NVARS > 1)
    if (NVARS == 2)
       point = 1;       
    else
       point = round(rand()*(NVARS - 1)) + 1;            
    end   
    
    % Esta parte corresponde ao operador de crossover OX.
    for i=1:point
       %swap(population[one].gene[i], population[two].gene[i]);    
       aux = population(one).gene(i);
       population(one).gene(i) = population(two).gene(i);
       population(two).gene(i) = aux;
    end    

  end  
  