% Nome: dist
% Objetivo: Calcula a distancia percorrida entre os conteineres

function [distancia] = dist(m,n)

distancia=m-n;

if distancia <0
    distancia = distancia*(-1);
end


end