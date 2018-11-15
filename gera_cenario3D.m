s% Nome: Gera Cenário 3D

%-------------------------------------------------------------------------%
% Gera cenários de teste para serem utilizados pelo programa de simulação %
%-------------------------------------------------------------------------%

a = input('Numero da Instancia = ');
np = input('Número de portos percorridos = ');
n = input('Número de colunas do pátio = ');
ocupacao = input('Taxa de ocupacao dos patios (1 para 0.30, 2 para 0.60 e 3 para 0.90) = ');
matriz_de_transporte = input('Matriz de transporte (1 para Mista, 2 para Curta Distancia e 3 para Longa Distancia) = ');
[Navio,porto,patio,Qntd_Conteineres] = cenario3D(np,n,ocupacao,matriz_de_transporte);
NomeInstancia=strcat('Instancia3D-',int2str(a),'-Ocupacao-',int2str(ocupacao),'-Tipo-',int2str(matriz_de_transporte),'.mat');
lbound=1;
ubound=180; %10 regras Rt, 6 regras Rc e 3 regras Rd.
save(NomeInstancia,'NomeInstancia','Navio','porto','patio','np','lbound','ubound','Qntd_Conteineres');

