% Funcao responsavel por construir um cubo Face por Face.
% Alem disso, deve ser fornecido o ponto de referencia a
% partir do qual os containeres serao construidos, o 
% tamanho do mesmos, e o vetor de matrizes que indica onde
% esta cada container com destino a cada porto.
function drawShip(xi,yi,zi,ti,vm)

% Teste a funcao usando:
%%vm{1} = [2 2; 3 3];
%%vm{2} = [2 2; 4 4];
%%vm{3} = [3 3; 5 4];
%%drawShip(0,0,0,1,vm)

% Parametros para a criacao dos desenhos.
alpha = 0.5;
map = [ 1.0 1.0 1.0; % cor  1 
        0.0 1.0 0.8; % cor  2
        0.2 1.0 0.2; % cor  3 
        1.0 1.0 0.2; % cor  4
        1.0 0.4 0.0; % cor  5
        1.0 0.0 0.2; % cor  6
        0.2 0.4 0.8; % cor  7
        0.4 0.4 0.4; % cor  8
        0.3 0.4 0.3; % cor  9
        0.2 0.3 0.2];% cor 10

% Traduzindo a informacao contida em vm para realizar
% o desenho tridimensional do navio.
tam = ti;
x = [];
y = [];
z = [];
vc = [];

% Para cada camada do navio construir o desenho.
ncam = length(vm);
for i=1:ncam
  
  % Obter os conteiner que esta em uma camada.
  B = vm{i};
  ncol = size(B,2);
  nlin = size(B,1);
  % Desenhar a i-esima camada.
  % Representacao invertida: a primeira linha 
  % da matriz representa o topo do navio.
  for j=1:nlin
    for k=1:ncol
    
     % Rotina para desenhar cada conteiner.
     %xr = xi + tam*(ncol-k);
     xr = xi + k*tam;
     %yr = yi + tam*(ncam-i);
     yr = yi + i*tam;
     % Representacao na qual a primeira linha da
     % matriz corresponde ao porao do navio.
     %zr = zi + tam*(nlin-j); 
     % Representacao invertida.
     zr = zi + tam*j;
     
     % Pontos que irao formar as faces do cubo.
     % Pontos da face baixa.
     p1.x = xr;
     p1.y = yr+1;
     p1.z = zr;

     p2 = p1;
     p2.x = p2.x + 1;

     p3 = p2;
     p3.y = p2.y - 1;

     p4 = p3;
     p4.x = p4.x - 1;


     % Pontos da face alta.
     p5 = p1;
     p5.z = p5.z + 1;

     p6 = p5;
     p6.x = p6.x + 1;
 
     p7 = p6;
     p7.y = p7.y - 1;

     p8 = p7;
     p8.x = p8.x - 1;

     %hold on;
     % Face Baixa: P1, P2, P3, P4.
     %x1 = [xr xr+1 xr+1 xr];
     %y1 = [yr yr yr-1 yr-1];
     %z1 = [zr zr zr zr];
     x1 = [p1.x p2.x p3.x p4.x];
     y1 = [p1.y p2.y p3.y p4.y];
     z1 = [p1.z p2.z p3.z p4.z];
     %fill3(x1,y1,z1,c); 

     % Face Alta: P5, P6, P7, P8.
     x2 = [p5.x p6.x p7.x p8.x];
     y2 = [p5.y p6.y p7.y p8.y];
     z2 = [p5.z p6.z p7.z p8.z];
     %fill3(x2,y2,z2,c); 

     % Face Frontal: P1, P2, P6, P5.
     x3 = [p1.x p2.x p6.x p5.x];
     y3 = [p1.y p2.y p6.y p5.y];
     z3 = [p1.z p2.z p6.z p5.z];
     %fill3(x3,y3,z3,c); 

     % Face Traseira: P4, P3, P7, P8. 
     x4 = [p4.x p3.x p7.x p8.x];
     y4 = [p4.y p3.y p7.y p8.y];
     z4 = [p4.z p3.z p7.z p8.z];
     %fill3(x4,y4,z4,c); 

     % Face Esquerda: P1, P4, P8, P5.
     x5 = [p1.x p4.x p8.x p5.x];
     y5 = [p1.y p4.y p8.y p5.y];
     z5 = [p1.z p4.z p8.z p5.z];
     %fill3(x5,y5,z5,c); 

     % Face Direita: P2, P3, P7, P6.
     x6 = [p2.x p3.x p7.x p6.x];
     y6 = [p2.y p3.y p7.y p6.y];
     z6 = [p2.z p3.z p7.z p6.z];
     %fill3(x6,y6,z6,c); 

     %x = [p1.x p2.x p3.x p4.x p8.x p7.x p6.x p5.x];
     %y = [p1.y p2.y p3.y p4.y p8.y p7.y p6.y p5.y];
     %z = [p1.z p2.z p3.z p4.z p8.z p7.z p6.z p5.z];
     %fill3(x,y,z,c); 
     % Determinando qual cor empregar para desenhar o conteiner.
     if (B(j,k) == 0)
       %cor = 'r';
       %cor = 0.4;
       cor = 1;
     elseif (B(j,k) == 2)
       %cor = 'b';   
       %cor = 0.6;
       %cor = 2;
       cor = 2; 
     elseif (B(j,k) == 3)    
       %cor = 'y';
       %cor = 0.2;
       %cor = 3;
       cor = 3;
     elseif (B(j,k) == 4)    
       %cor = 'g';   
       %cor = 0.8;
       %cor = 4;
       cor = 4;
     elseif (B(j,k) == 5)
       %cor = 'c';   
       %cor = 1;
       %cor = 5;
       cor = 5;
     elseif (B(j,k) == 6)
       cor = 6;  
     elseif (B(j,k) == 7)
       cor = 7;  
     elseif (B(j,k) == 8)
       cor = 8;
     elseif (B(j,k) == 9)
       cor = 9;  
     else
       cor = 10;  
     end
     %vc = [vc cor];
     vc = [vc ones(1,6)*cor];
     %x = [x1 x1(1) x2 x2(1) x3 x3(1) x4 x4(1) x5 x5(1) x6 x6(1)];
     %y = [y1 y1(1) y2 y2(1) y3 y3(1) y4 y4(1) y5 y5(1) y6 y6(1)];
     %z = [z1 z1(1) z2 z2(1) z3 z3(1) z4 z4(1) z5 z5(1) z6 z6(1)];
     x = [x x1' x2' x3' x4' x5' x6'];
     y = [y y1' y2' y3' y4' y5' y6'];
     z = [z z1' z2' z3' z4' z5' z6'];
   end % Fim do K.
  end  % Fim do j.   
end    % Fim do i.     
colormap(map);

figure()
  h = fill3(x,y,z,vc,'FaceAlpha',alpha);
% h = fill(x,z,vc,'FaceAlpha',alpha);

% Laco para pintar as faces com as cores desejadas.
for i=1:length(h)
  set(h(i),'FaceColor',map(vc(i),:));
end  
h = gca;
set(h,'XTick',[]);
set(h,'XTickLabel',[]);
set(h,'YTick',[]);
set(h,'YTickLabel',[]);
set(h,'ZTick',[]);
set(h,'ZTickLabel',[]);

% % AZ = [30:10:180 -180:10:30];       % azimuth
% % EL = [30:1:48 48:-1:30];          % elevation
% % grid on;
% % for k = 1:length(AZ)
% %   fill3(x,y,z,vc,'FaceAlpha',alpha); 
% %   h = gca;
% %   set(h,'XTick',[]);
% %   set(h,'XTickLabel',[]);
% %   set(h,'YTick',[]);
% %   set(h,'YTickLabel',[]);
% %   set(h,'ZTick',[]);
% %   set(h,'ZTickLabel',[]);
% %   view(AZ(k),EL(k));  
% %   pause(0.1);
% %   %axis equal;
% %   %M(k) = getframe(gcf);
% % end
% % 
% % %clf
% % %axes('Position',[0 0 1 1])
% % %movie(M,30);
