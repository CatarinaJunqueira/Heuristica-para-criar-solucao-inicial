function l_patio = gera_patio2()


	x = 10;                % Definição do número de linhas da matriz.
	y = 10;             % Definição do número de colunas da matriz.
	l_patio = cell(x,y);  % Definição do tamanho do pátio.
	A = 18;                % Número do último navio
	B = 1;                % Número do primeiro navio (Para gerar valores entre 1 e 5)
	C = 11;               % Número do último porto + 1
	D = 10;                % Número do primeiro porto
	zero_navio = {l_patio(1),(2)};
	
%CASO 2  - define quantos por coluna 
	for coluna = (1:y)
        
			vazios = floor((round(x/2)-1).*rand(1) + 1);
			%pelo menos metade estara ocupado
		
		for linha = (1:x)    
			
			l_patio(linha,coluna)= {[floor((A-B).*rand(1) + B), floor((C-D).*rand(1) + D)]};
        end
    end  
	
%Fim caso 2
% ----------------------------------------------------------------------
end