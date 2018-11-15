% Nome: Regra de Descarregamento - Rd 

%---------------------------------------------------------------------%
%               Regra de Descarregamento do Navio (Rd)                %
%---------------------------------------------------------------------%


function [MovGeral,Navio] = Rd(Navio, NPorto, porto,RegraRetirada,RegraCarregamento,RegraDescarregamento)

%--------------------------------------------------------------------------%
% identificando a regra que vai ser utilizada  
Rd = strcat('Rd',int2str(RegraDescarregamento));
%--------------------------------------------------------------------------%

[MovGeral,Navio] = feval(Rd,Navio,NPorto,porto,RegraRetirada,RegraCarregamento);
   

end