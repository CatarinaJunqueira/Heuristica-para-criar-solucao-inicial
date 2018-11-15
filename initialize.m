%------------------------------------------------------------------------%
%                                                                        %
%------------------------------------------------------------------------% 
% Função responsável por realizar a correta construção                   %
% da população inicial.                                                  %
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
function [population] = initialize(POPSIZE,NVARS,lbound,ubound) 

    %-------------------------------------------------------------%
    %                                                             %
    % INICIALIZACAO DE VARIAVEIS                                  % 
    %                                                             %
    %-------------------------------------------------------------%
    
    %------------------------------%
    % POPULATION INITIALIZATION !!!%
    %                              %
    %------------------------------%
    population = ([]);
   
    % Initialize population which cromossomes with np-1 genes.
    for i=1:NVARS
      % Rand initial cromossomes for GA.   
      for j=1:(POPSIZE+1)
        population(j).realfitness = 0.0;  
        population(j).fitness = 0.0;
        population(j).rfitness = 0.0;
        population(j).cfitness = 0.0;
        population(j).lower(i) = lbound;
        population(j).upper(i) = ubound;
        population(j).gene(i) = randval(population(j).lower(i),population(j).upper(i));       
      end
    end      

    %--------------------------------------------------------------%