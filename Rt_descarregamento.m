
% Nome: Regra de Retirada para os conteineres de transbordo, que sao os
% conteineres que foram descarregados do navio durante o uso da Rd, mas que
% nao tinham este porto como destino final

%---------------------------------------------------------------------%
%                  Regra de Retirada do Pátio (Rt)                    %
%---------------------------------------------------------------------%
   
   
function [MovGeral,Navio] = Rt_descarregamento(patio,RegraRetirada,Navio,RegraCarregamento,porto)

MovGeral=0;
%----------------------------------%
% identificando a regra que vai ser utilizada (qual localiza e qual vazio) 
%localiza = strcat('encontra',int2str(i));
vzio = strcat('desguarnecido',int2str(RegraRetirada));
%----------------------------------%

[l_navio] = encontraCasertaDescarregamento(patio); % Chamando o localiza, traz uma lista das posições dos contêineres que vão ser retirados.

[mov_total,Navio] = mover_Novo_Genetico_Descarregamento(patio,l_navio,vzio,RegraCarregamento,Navio,porto);
MovGeral=MovGeral+mov_total;

end 
   
   
 