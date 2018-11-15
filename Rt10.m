function [move_counter,Navio] = Rt10(P,Navio,RegraCarregamento,porto) %Regra da coluna mais próxima
%--------------------------------------------------------------------------------------------------------------------------------------%
% identificando a regra de carregamento que vai ser utilizada % 
Rc = strcat('Rc',int2str(RegraCarregamento));
l=size(Navio,2); %numero de baias
altura_max=zeros(1,l);
for t=1:l
    if (RegraCarregamento == 2) || (RegraCarregamento == 4) % se a regra Rc é a Rc2 ou a Rc4
     [m,n]=size(Navio{1,t});
      g= ceil(nnz(P)/l); % quantidade total de conteineres a serem embarcados
      H = ceil((g+ length(find(Navio{1,t} ~= 0)))/n); %altura maxima por baia (qntd total de conteineres que vao subir + qntd de conteineres que jah estao no navio, tudo isso dividido pelo numero de baias)
         if H>m
             altura_max(1,t)=m;
         else
             altura_max(1,t)=H;
         end          
    end
end
%-------------------------------------------------------------------------------------------------------------------------------------%

move_counter=0;
n=0;
o=unique(P)';
if o(1)==0
    o(1)=[];
end
[linha_P,coluna_P]=size(P);
for y=o
    n=n+1;
    [row_n,col_n] = find(P==y); % linha e coluna onde está o contêiner objetivo y
   if ((row_n-1 == 0) || (P(row_n-1,col_n) == 0)) % se y está no topo ou se a posição acima é vazia.         

   else
        R = quem_acima_Heuristica_Caserta(P,y); % Definindo a quantidade de blocos acima de n.
        for j=1:length(R) % começando a movimentação dos blocos que devem ser remanejados.
            r=R(j); % bloco a ser movido de acordo com a política LIFO.
            [linha_r,coluna_r]=find(P==r);
            contador=1;
            for f=1:coluna_P
                if f~=col_n
                   i=col_n-contador;
                   ii=col_n+contador;
                   contador=contador+1;
                   if i>=1 && i<col_n % se a posicao existe
                       if nnz(P(:,i))<linha_P %se tem espaço disponivel nesta coluna
                           [P] = trocar_Heuristica_Caserta(P,i,r,linha_r,coluna_r); % Remanejar r
                           move_counter=move_counter+1;
                           break
                       end                       
                   end
                   
                   if ii<=coluna_P &&  ii>col_n
                        if nnz(P(:,ii))<linha_P %se tem espaço disponivel nesta coluna
                            [P] = trocar_Heuristica_Caserta(P,ii,r,linha_r,coluna_r); % Remanejar r
                           move_counter=move_counter+1;
                           break                                                    
                        end                       
                   end                   
                end
            end
        end   
    end
    % Depois de realocar todos os contêineres que estavam acima do
    % contêiner n, n pode ser retirado.
       P(row_n,col_n)=0; % Tira do patio
%-------------------------------------------------------------------------------------------------------------------------------------% 
%    Carregar no navio
        switch RegraCarregamento %chamando a regra de carregamento no navio
            case 2
                    [Navio] = feval(Rc,Navio,y,altura_max);
            case 4
                    [Navio] = feval(Rc,Navio,y,altura_max);
            case 7
                    [Navio] = feval(Rc,Navio,y,porto);
            otherwise
                    [Navio] = feval(Rc,Navio,y);
        end   
       
    uu=unique(P);
    a=size(uu,1);
    if a==1 
        if uu==0 % se o patio esta zerado, entao sair
           break
        end
    end

end

end