% Metodos de diferencias divididas en un punto con intervalos regulares
% Entrada: y, h, i
% Salida: d
% Ejemplo:
%          y=[1 2 3 4 5 6 7 8 9 10 11];
%          h = 1;
%          i=5;
%          d=difdiv(x,y,i)

function d = difdiv(y,h,i)
    n = length(y);
    % Diferencias Centrales
    if i > 1 && i < n
        d = (y(i+1)-y(i-1))/(2*h);
    
    % Diferecias hacia adelante
    elseif i == 1 && n >= 3
        d = (-3*y(1)+4*y(2)-y(3))/(2*h);
    
    % Diferencias hacia atras
    elseif i == n && n >= 3
        d = (3*y(n)-4*y(n-1)+y(n-2))/(2*h);

    % Error
    else
        printf("Error estimando la derivada\n");
    endif

endfunction