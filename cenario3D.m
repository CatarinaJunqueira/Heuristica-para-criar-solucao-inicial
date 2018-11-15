% m = input('Número de linhas do pátio = ');   
% n = input('Número de colunas do pátio = ');  
% q = input('Quantidade de contêineres = ');   
function[Navio,porto,patio,Qntd_Conteineres] = cenario3D(NP,n,ocupacao,matriz_de_transporte)
m=6; %Número de linhas do pátio
patio=cell(NP-1,1);
%porto=zeros(NP-1,1);
MC=zeros(NP-1,1);

switch ocupacao %Quantidade de contêineres
    case 1
        q=ceil(m*n*0.30);
    case 2
        q=ceil(m*n*0.60);
    case 3
        q=ceil(m*n*0.90);
end

switch matriz_de_transporte 
 %-----------------------------------------------------------------------------------------------------------------------------%    
 %Inicio caso 1
 %-----------------------------------------------------------------------------------------------------------------------------%
    case 1 % mista
        XX=2;
            for y=1:NP-1
                 MC(y)=q;
                 if y==1
                     A=1;
                     B=q;
                     [ppatio,pporto] = gera_patio(m,n,q,XX,NP,A,B);
                     %XX e np indicam o intervalo dos portos de destino dos conteineres. XX eh o
                     %primeiro porto onde os conteineres comecam a descer e np eh o
                     %ultimo porto. Para uma matriz de longa distancia, colocar XX
                     %mais proximo do porto final (que eh np).
                 else
                     A=B+1;
                     B=B+q;
                     XX=XX+1;
                     [ppatio,pporto] = gera_patio(m,n,q,XX,NP,A,B);         
                 end    
                    patio{y,1}=ppatio;                   
                    if y==1;
                        porto=pporto;
                    else
                        porto=[porto,pporto];
                    end
            end 
            f=ceil((max(max(patio{NP-1,1}))/108));
            Navio=cell(1,f);
            for i=1:f
                Navio{1,i}=zeros(6,18);                
            end
        
%-----------------------------------------------------------------------------------------------------------------------------%    
%Inicio caso 2
%-----------------------------------------------------------------------------------------------------------------------------%       
    case 2 % curta distancia
        XX=2;
        np=XX+1;
            for y=1:NP-1
                 MC(y)=q;
                 if y==1
                     A=1;
                     B=q;
                     [ppatio,pporto] = gera_patio(m,n,q,XX,np,A,B);
                     %XX e np indicam o intervalo dos portos de destino dos conteineres. XX eh o
                     %primeiro porto onde os conteineres comecam a descer e np eh o
                     %ultimo porto. Para uma matriz de longa distancia, colocar XX
                     %mais proximo do porto final (que eh np).
                 else
                     if y==NP-1
                        np=NP;
                     end
                     A=B+1;
                     B=B+q;
                     XX=XX+1;
                     if y<NP-1
                           np=np+1;
                     end
                     [ppatio,pporto] = gera_patio(m,n,q,XX,np,A,B);         
                 end    
                    patio{y,1}=ppatio;
                    if y==1;
                        porto=pporto;
                    else
                        porto=[porto,pporto];
                    end
            end         
            f=ceil((max(max(patio{NP-1,1}))/108));
            Navio=cell(1,f);
            for i=1:f
                Navio{1,i}=zeros(6,18);                
            end   
 %-----------------------------------------------------------------------------------------------------------------------------%    
 %Inicio caso 3
 %-----------------------------------------------------------------------------------------------------------------------------%
    case 3 % longa distancia
         XX=ceil(NP/2); %os conteineres comecam a descer da metade para frente
            for y=1:NP-1
                 MC(y)=q;
                 if y==1
                     A=1;
                     B=q;
                     [ppatio,pporto] = gera_patio(m,n,q,XX,NP,A,B);
                     %XX e np indicam o intervalo dos portos de destino dos conteineres. XX eh o
                     %primeiro porto onde os conteineres comecam a descer e np eh o
                     %ultimo porto. Para uma matriz de longa distancia, colocar XX
                     %mais proximo do porto final (que eh np).
                 else
                     A=B+1;
                     B=B+q;
                     XX=XX+1;
                     [ppatio,pporto] = gera_patio(m,n,q,XX,NP,A,B);         
                 end    
                    patio{y,1}=ppatio;
                    if y==1;
                        porto=pporto;
                    else
                        porto=[porto,pporto];
                    end
            end  
            
            f=ceil((max(max(patio{NP-1,1}))/108));
            Navio=cell(1,f);
            for i=1:f
                Navio{1,i}=zeros(6,18);                
            end            

end
    Qntd_Conteineres=max(max(patio{NP-1,1}));
end