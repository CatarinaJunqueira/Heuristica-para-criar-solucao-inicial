%----------------------------------------------------%
%----------------------------------------------------%
% Elaboração da Regra R1 de Carregamento.            %
%----------------------------------------------------%
%----------------------------------------------------%
% Procedimento de preenchimento:                     %
%----------------------------------------------------%
%  (1) Considera-se que a ordem de preenchimento
%      das cargas no navios ->, por linha, da esquerda 
%      para a direita, de baixo para cima.  
%    m ^
%        |4 5 6
%        |1 2 3
%      1 --------> 
%        1        n
%
%  (2) Coloca um contêiner de cada vez, conforme
%       eles vão sendo retirados do pátio.
%
%  (3) Retorna a matrix que representa o navio, preenchida
%       de acordo com a regra de carregamento Rc1.
%----------------------------------------------------%
function [Navio] = Rc1(Navio,conteiner) 

%[linha,coluna]=size(Navio);

% if  length(find(Navio(1,:)~=0)) == coluna     
%     msg = 'Problema na função Rc1 !! Não foi possível carregar todos os containeres!! Espaco insufiente !! \n ';
%     error(msg)
% end
for t=1:size(Navio,2) % de 1 ateh o numero de baias
    Nv=Navio{1,t};
    [linha,coluna]=size(Nv);
    % Ordem que vai percorrer
    for i = (linha:-1:1) %corrigindo a ordem de verificação.
         for k = 1:coluna   
             if Nv(i,k) == 0
                Nv(i,k) = conteiner;                  
                conteiner=0;     
                break
             end
         end  
            if conteiner == 0
                break
            end
    end
         if conteiner == 0
             Navio{1,t}=Nv;
            break
        end
end

end

