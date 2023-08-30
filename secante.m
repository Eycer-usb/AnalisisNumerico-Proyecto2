% Metodo de la Secante
% Entradas:
%   f: funcion a evaluar
%   x0: valor inicial
%   x1: valor inicial
%   tol: tolerancia
%   iterMax: numero maximo de iteraciones
% Salidas:
%   x: raiz aproximada
%   error: error relativo
%   iter: numero de iteraciones
%   band: indica si se encontro la raiz

function [x, error, iter, band] = secante(f, x0, x1, tol, iterMax)
    % Inicializacion de variables
    band = 0;
    iter = 0;
    error = tol + 1;
    % Iteraciones
    while (error > tol) && (iter < iterMax)
        % Calculo de la raiz
        x = x1 - (f(x1)*(x1-x0))/(f(x1)-f(x0));
        % Calculo del error
        error = abs((x-x1)/x);
        % Actualizacion de variables
        x0 = x1;
        x1 = x;
        iter = iter + 1;
    end
    % Verificacion de la existencia de la raiz
    if (error <= tol)
        band = 1;
    end
end