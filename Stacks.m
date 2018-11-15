 % If Stacks[N'] includes all S stacks or if all stacks s not in Stacks[N0] 
 % are full (i.e. they have mxHeight containers in them), let N' = N' - 1

 %Stacks[a] = conjunto das colunas onde estao os a menores conteineres 
 
 %Se bool=1, entao fazer N'=N'-1, 
 %Se bool=0, ir para o passo 4.
 
function [bool,Stacks] = Stacks(P,N_linha)
[~,coluna]=size(P);
u=unique(P)';
if u(1)==0
    u(1)=[];
end
u=u(1:N_linha); %conjunto dos u menores conteineres no patio
Stacks=zeros(1,N_linha);
for i=1:N_linha
    [~,col] = find(P==u(i)); 
    Stacks(1,i)=col;
end

Stacks=unique(Stacks);

if length(Stacks)==coluna %If Stacks[N'] includes all S stacks
    bool_1=1;
else
    bool_1=0;
end


Col=1:coluna;
Col(Stacks)=[];
if isempty(Col)==1
     bool_2=1;
else
    i=1;
    h=zeros(1,size(Col,2));
    for k=Col %If all stacks s not in Stacks[N0] are full
        h(1,i)=P(1,k);
        i=i+1;
    end
    if length(find(h(1,:)~=0)) == size(Col,2)  
         bool_2=1;
    else
         bool_2=0;
    end
end

if bool_1 || bool_2==1
    bool = 1;
else
    bool = 0;   
end

end