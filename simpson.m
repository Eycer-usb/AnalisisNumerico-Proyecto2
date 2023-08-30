% Implementacion de la regla de sipmson 1/3 compuesta para calcular la integral de una funcion
% Parametros de entrada:
% a: limite inferior de la integral
% b: limite superior de la integral
% n: numero de subintervalos
% f: funcion a integrar
% Parametros de salida:
% I: valor de la integral

function [I,error] = simpson(a,b,n,f)
  h = (b-a)/n;
  x = a:h:b;
  y = f(x);
  I = (h/3)*(y(1)+y(end)+4*sum(y(2:2:end-1))+2*sum(y(3:2:end-2)));
endfunction
