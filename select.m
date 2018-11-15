%/***************************************************************/
%/* Selection function: Standard proportional selection for     */
%/* maximization problems incorporating elitist model - makes   */
%/* sure that the best member survives                          */
%/***************************************************************/
function newpopulation = select(POPSIZE,population) 
    
    % Find total fitness of the population
    sum = 0;
    for mem=1:POPSIZE
      sum = sum + population(mem).fitness;  
    end
    
    % Calculate relative fitness
    for mem=1:POPSIZE
      population(mem).rfitness = population(mem).fitness/sum;  
    end
    
    
    % Calculate cumulative fitness
    population(1).cfitness = population(1).rfitness;
    for mem=2:POPSIZE
      population(mem).cfitness = population(mem-1).cfitness + population(mem).rfitness;  
    end
    
    % Finally select survivors using cumulative fitness.
    for i=1:POPSIZE
      p = rand();
      if (p < population(1).cfitness)
        newpopulation(i) = population(1);
      else
        for j=1:POPSIZE
          if ((p >= population(j).cfitness) && (p < population(j+1).cfitness))
            newpopulation(i) = population(j+1);  
          end 
        end
      end  
    end
    
    % once a new population is created, copy it back.
    for i=1:POPSIZE
      population(i) = newpopulation(i);   
    end
end
