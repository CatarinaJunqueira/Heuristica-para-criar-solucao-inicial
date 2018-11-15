% Nome: Regra de Descarregamento 2 - Rd2 

%---------------------------------------------------------------------%
% Regra de Descarregamento do Navio (Rd2)       %
%---------------------------------------------------------------------%
% Retira todos os contêineres do Navio para carregá-los posteriormente
% usando alguma regra de carregamento.

function [MovGeral, Navio] = Rd2(Navio,NPorto,porto,RegraRetirada,RegraCarregamento)

u=size(Navio,2);
y=0;
for b=1:u
    y1=length(find(Navio{1,b}~=0));
    y=y+y1;  % quantidade total de conteineres no navio
end
kk=length(find(porto(1,:)==NPorto)); %quantidade de conteineres que tem como destino o porto atual
MovGeral=y-kk; %quantidade de conteineres remanejados
patio_transb=zeros(6,ceil((MovGeral/6)*1.5)); % área reservada para os contêineres de transbordo
if size(patio_transb,2)==1;
    patio_transb=zeros(6,3);
end

for z=1:size(Navio,2)
    [linha,coluna]=size(Navio{1,z});
    for i=1:linha
        for j=1:coluna
            if Navio{1,z}(i,j)~=0 % se a posição é diferente de zero
               [row]=find(porto(2,:)==Navio{1,z}(i,j));            
                if porto(1,row)== NPorto % se este eh o destino final do conteiner
                   Navio{1,z}(i,j)=0; % entao retira do navio
                else % se o contêiner não vai ficar no porto em que o navio está
                       % retira e coloca na área de transbordo para depois colocar
                       % de volta no navio
                  % [patio_transb] = Rc_Imp(patio_transb,Navio{1,z}(i,j)); 
                   [patio_transb] = Rc_Imp_Prioridades(patio_transb,Navio{1,z}(i,j)); 
                   Navio{1,z}(i,j)=0;
                end
            end
        end   
    end
end
% Terminado o descarregamento
%-------------------------------------------------------------------------%
% Agora é necessário carregar de volta os contêineres que foram
% descarregados, mas que não tinham como destino final este porto.
if nnz(patio_transb) ~=0    
    switch RegraRetirada
        case 7
                [MovGeralTransbordo,Navio] = Rt7(patio_transb,Navio,RegraCarregamento,porto);
                MovGeral=MovGeral+MovGeralTransbordo; 
        case 8
                [MovGeralTransbordo,Navio] = Rt8(patio_transb,Navio,RegraCarregamento,porto);
                MovGeral=MovGeral+MovGeralTransbordo; 
        case 9
                [MovGeralTransbordo,Navio] = Rt9(patio_transb,Navio,RegraCarregamento,porto);
                MovGeral=MovGeral+MovGeralTransbordo; 
        case 10
                [MovGeralTransbordo,Navio] = Rt10(patio_transb,Navio,RegraCarregamento,porto);
                MovGeral=MovGeral+MovGeralTransbordo; 
        otherwise      
               [MovGeralTransbordo,Navio] = Rt_descarregamento(patio_transb,RegraRetirada,Navio,RegraCarregamento,porto);
               MovGeral=MovGeral+MovGeralTransbordo;    
    end
end

end