% Funcion Interpolante de Lagrange en Octave
% Autor: Eros Cedeño
% Fecha: 2023-08
%
% Uso:
%   p = lagrange(xi, yi)
%
% Parametros:
%   xi: Vector de puntos x
%   yi: Vector de puntos y
%
% Ejemplo:
%   xi = [1 2 3 4 5];
%   yi = [1 4 9 16 25];
%   p = lagrange(xi, yi)
%
%   p = 1.00000 + 0.00000x + 0.00000x^2 + 0.00000x^3 + 0.00000x^4
%
%   plot(xi, yi, 'o', linspace(1, 5), polyval(p, linspace(1, 5)))
%   grid on
%   axis([0 6 0 30])
%   xlabel('x')
%   ylabel('y')
%   title('Interpolacion de Lagrange')
%
%   print('lagrange.png', '-dpng', '-r300')

function p = lagrange(xi, yi)
    n = length(xi); % Numero de puntos
    p = zeros(1, n); % Vector de coeficientes
    Logical_Identity = logical(eye(n)); % Matriz identidad logica

    % Calculo de los coeficientes
    for i = 1:n
        p_i = poly(xi(~Logical_Identity(i, :))); % Numerador de la i-esima fraccion de Lagrange
        p_i = p_i / polyval(p_i, xi(i)); % Incorporacion del denominador
        p_i = p_i * yi(i); % Incorporacion de la imagen
        p = p + p_i; % Se agrega a los coeficientes
    endfor
endfunction
