        

function [Topo] = TopoRt8(P)

for i=1:size(P,1)
   if P(i,1)~=0 % se a posicao eh diferente de zero
      Topo = P(i,1);
      break
   end  
end
end

