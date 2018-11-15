

% porto: 1� linha = porto de destino
%           2� linha = id do cont�iner

NPatios = size(phi,1); % n�mero de p�tios
NPortos = size(phi,2); % n�mero de portos
porto=[];
contador=1;
for i=1:NPatios
    for j =1:NPortos
        if isempty(phi{i,j}) == 0 % se n�o � vazio
          n = size(phi{i,j},2);
          for k=1:n
              p=phi{i,j}(1,k);
              porto(1,contador)=j;
              porto(2,contador)=p;
              contador=contador+1;
          end
        end
    end  
end

patio=Patios;

tic;
[Navio,value,Seq_Navio,Seq_Patio,Seq_Retirada] = Simulador(patio,porto,R,C)
tempo=toc;
 fprintf('Tempo de execucao %d', tempo);
display(toc);