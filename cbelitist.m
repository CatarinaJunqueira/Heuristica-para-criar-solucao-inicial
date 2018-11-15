%/*****************************************************************/
%/* Elistist function: The best member of the previous generation */
%/* is stored as the last in the array. If the best member of     */
%/* the current generation is worse then the best member of the   */
%/* previous generation, the latter one would replace the worst   */
%/* member of the current population                              */
%/*****************************************************************/

function population = cbelitist(POPSIZE,NVARS,population)
   
   best = population(1).fitness;
   best_mem = 1;
   worst = population(1).fitness;
%   worst_mem = 1;
   for i=2:POPSIZE
%     if ((population(i).fitness > population(i+1).fitness)&(population(i).unfitness == 0))
      if (population(i).fitness > population(i+1).fitness)
       if (population(i).fitness >= best)                                 
         best = population(i).fitness;
         best_mem = i;                                 
       end
       if (population(i+1).fitness <= worst)
         worst = population(i+1).fitness;
         worst_mem = i + 1;                                    
       end    
     else    
       if (population(i).fitness <= worst)
         worst = population(i).fitness;
         worst_mem = i;                                   
       end      
       %if (population(i+1).fitness >= best)&(population(i+1).unfitness == 0)
       if (population(i+1).fitness >= best)
         best = population(i+1).fitness;
         best_mem = i + 1;                                    
       end
     end
   end
     
   %/* if best individual from the new population is better than */
   %/* the best individual from the previous population, then    */
   %/* copy the best from the new population; else replace the   */
   %/* worst individual from the current population with the     */
   %/* best one from the previous generation                     */ 
   
   if (best >= population(POPSIZE+1).fitness)
     for i=1:NVARS
       population(POPSIZE+1).gene(i) = population(best_mem).gene(i);
     end  
     population(POPSIZE+1).realfitness = population(best_mem).realfitness;
     population(POPSIZE+1).fitness = population(best_mem).fitness;          
     %population(POPSIZE+1).unfitness = population(best_mem).unfitness;          
     %fprintf(1,'Fitness: %8.4f | Unfitness: %8.4f \n',population(best_mem).fitness,population(best_mem).unfitness)
   end  
   
   
   