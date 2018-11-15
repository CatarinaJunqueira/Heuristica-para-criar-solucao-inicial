% Nome: Gera Cenário

%-------------------------------------------------------------------------%
% Gera cenários de teste para serem utilizados pelo programa de simulação %
%-------------------------------------------------------------------------%
% m = input('Número de linhas do pátio = ');   
% n = input('Número de colunas do pátio = ');  
% q = input('Quantidade de contêineres = ');   
% X = input('Número de navios = ');
% NP = input('Número de portos percorridos = ');
% [patio,navio,porto,Navio,np,lista_descarregamento,MC] = gera_cenario(7,10,6,4)

% Instancia I, II e III: gera_cenario(10,200,5,3)
% Instancia IV, V e VI: gera_cenario(10,200,5,5)
% Instancia VII, VIII e IX: gera_cenario(10,200,5,10)


m = input('Número de linhas do pátio = '); 
n = input('Número de colunas do pátio = ');
NP = input('Número de portos percorridos = ');
(Navio,porto,patio,np,lbound,ubound) = gera_cenario(m,n,X,NP);
NomeInstancia=strcat('Instancia',int2str(a),'-','Resultados','.mat');
save(NomeInstancia,'nmov','Pt','Navio','tempo');
display(tempo);


function[patio,navio,porto,Navio,np,lista_descarregamento,NumMinMov] = gera_cenario(m,n,X,NP)
y=1;
patio=cell(NP-1,1);
navio=cell(NP-1,1);
porto=cell(NP-1,1);
MC=zeros(NP-1,1);
np=NP;
%XX=4;
    while y<=NP-1
     q=randi([ceil(m*n*0.50),ceil(m*n*0.90)],1); %Quantidade de contêineres ocupam de 0.49 a 0.89 de cada patio
     MC(y)=q;
         if y==1
             A=1;
             B=q;
             [ppatio,nnavio,pporto] = gera_patio(m,n,q,2,X,3,A,B);
             %[ppatio,nnavio,pporto] = gera_patio(m,n,q,XX,X,np,A,B);
         end

         if y==2
             A=B+1;
             B=B+q;
            % XX=XX+1;
             [ppatio,nnavio,pporto] = gera_patio(m,n,q,3,X,4,A,B);         
         end

         if y==3
             A=B+1;
             B=B+q;
             %XX=XX+1;
             [ppatio,nnavio,pporto] = gera_patio(m,n,q,4,X,np,A,B);
         end
         
         if y==4
             A=B+1;
             B=B+q;
             %XX=XX+1;
             [ppatio,nnavio,pporto] = gera_patio(m,n,q,5,X,np,A,B);
         end
         
%          if y==5
%              A=B+1;
%              B=B+q;
%              %XX=XX+1;
%              [ppatio,nnavio,pporto] = gera_patio(m,n,q,6,X,7,A,B);
%          end
% 
%          if y==6
%              A=B+1;
%              B=B+q;
%              %XX=XX+1;
%              [ppatio,nnavio,pporto] = gera_patio(m,n,q,7,X,8,A,B);
%          end
%          
%          if y==7
%              A=B+1;
%              B=B+q;
%              %XX=XX+1;
%              [ppatio,nnavio,pporto] = gera_patio(m,n,q,8,X,9,A,B);
%          end         
%          
%          if y==8
%              A=B+1;
%              B=B+q;
%              %XX=XX+1;
%              [ppatio,nnavio,pporto] = gera_patio(m,n,q,9,X,10,A,B);
%          end
%          
%          if y==9
%              A=B+1;
%              B=B+q;
%              %XX=XX+1;
%              [ppatio,nnavio,pporto] = gera_patio(m,n,q,10,X,np,A,B);
%          end         
         
        
            patio{y,1}=ppatio;
            navio{y,1}=nnavio;
            porto{y,1}=pporto;
            y=y+1;
    end 
    
    tam=0;
    for i= 1:NP-1 % contando a qntd de cont que serao embarcados no navio ao longo da viagem toda 
    u=length(find(navio{i,1}(1,:)==1)); % é =1 porque eu rodo a simulacao tirando do patio
                                   % os conteineres que tem destino o navio
                                   % 1
    tam=tam+u; % 'tam' me da a qntd de cont que serao embarcados no navio ao longo da viagem por todos os portos 
    end
    lista_descarregamento=zeros(tam*np,2);
    %Sabendo quantos conteineres serao embarcados, crio um Navio (matriz de
    %ocupacao que tenha capacidade para embarcar todos os conteineres.
    Navio=zeros((ceil((sqrt(tam)/2)*1.1)),ceil(tam*1.1/(ceil(sqrt(tam)/2))));
    MC=sum(MC); % número total de contêineres no problema
    NumMinMov=tam*3; % número mínimo de movimentos
  %  save('Instancia_VI.mat','patio','navio','porto','Navio','np','lista_descarregamento','MC','NumMinMov');
    
end