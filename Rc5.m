

function [Navio] = Rc5(Navio,conteiner) 

for t=1:size(Navio,2) % de 1 ateh o numero de baias
    if isempty(find(Navio{1,t}==0, 1)) ~=1     % Se ainda tem posicao disponivel na baia t para alocar o conteiner, entao coloque nesta baia
    [Nv] = Rc_Imp_Prioridades(Navio{1,t},conteiner) ; % Ordem que vai percorrer    
     Navio{1,t}=Nv;  
     break
    end
end

end