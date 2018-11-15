% Let Top_r[Q] = the rth highest element in set
% Top[Q], i.e. the container with the rth highest number among the
% containers on the tops of the stacks in set Q.

function [Top_r] = Top_r(P,Stacks)

Top_r=zeros(1,size(Stacks,2));

for i=1:size(Stacks,2)
    Top_r(1,i)=max(P(:,Stacks(1,i)));
end

end