function [Navio,value,Seq_Navio,Seq_Patio,Seq_Retirada] = Simulador(patio,porto,R,C)
q_o = [];
q_d = [];
q_r = [];
q_c = [];  
Navio=zeros(R,C);

value = 0; % Numero de movimentos realizados para carregar e descarregar
           % containeres durante a viagem de um navio por P portos.
Seq_Navio=cell(1,size(patio,1));
Seq_Patio=cell(1,size(patio,1));
Seq_Retirada=cell(1,size(patio,1));

           
    for k=1:size(patio,1) % Do primeiro ao último porto
        if k==1 % Verificando se nao estamos no primeiro porto onde os conteineres sao apenas carregados !!
           [Navio,Mov_Patio,Mov_Retirada] = Rt_Heuristica_Solucao_Inicial(patio{k,1},Navio,porto); 
           Seq_Navio{1,k}=Navio;
           Seq_Patio{1,k}=Mov_Patio;
           Seq_Retirada{1,k}=Mov_Retirada;
        end    

        if k~=1 % Do porto 2 ateh P-1, primeiro descarregado do navio e depois carrega os conteineres que tem destino os portos seguintes.          
            y=find(Navio==k, 1);
            if isempty(y) == 1 % se não há contêineres que vão descer nesse porto, ir para o próximo porto e pular o descarregamento
                  [Navio,Mov_Patio,Mov_Retirada] = Rt_Heuristica_Solucao_Inicial(patio{k,1},Navio,porto); % Retirar do pátio e carregar no navio
                  Seq_Navio{1,k}=Navio;
                  Seq_Patio{1,k}=Mov_Patio;
                  Seq_Retirada{1,k}=Mov_Retirada;
            else
                  [MovGeral, Navio,o,d,r,c] = Rd_Heuristica_Solucao_Inicial(Navio,k,porto);
                  q_o = [q_o,o];
                  q_d = [q_d,d];
                  q_r = [q_r,r];
                  q_c = [q_c,c];  
                  value=value+MovGeral;

                  [Navio,Mov_Patio,Mov_Retirada] = Rt_Heuristica_Solucao_Inicial(patio{k,1},Navio,porto); % Retirar do pátio e carregar no navio
                  Seq_Navio{1,k}=Navio;
                  Seq_Patio{1,k}=Mov_Patio;
                  Seq_Retirada{1,k}=Mov_Retirada;
            end
        end       
    end  
    save('SolucaoInicial_Instancia_66.mat','value','Seq_Navio','Seq_Patio','Seq_Retirada','R','C','patio','q_o','q_d','q_r','q_c');
end