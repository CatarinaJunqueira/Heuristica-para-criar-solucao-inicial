
function patio=shuffle(patio)
i=0;
 for i=1:10
     patio=patio(randperm(length(patio)));
     i=i+1;
 end
     
 end