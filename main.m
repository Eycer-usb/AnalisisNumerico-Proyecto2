% Universidad Simon Bolivar
% Autor: Eros Cedeño, Carnet: 16-10216
%
% Archivo principal del proyecto
%

% Se limpia la pantalla y las variables
clear
clc

% Para el Primer Punto
% Encontramos el polinomio interpolador de Lagrange para F(x)
% y procedemos a graficarlo

% Se define el vector de puntos a interpolar (Distancias en el eje x)
x = [0      0.86    2.96    5.08    6   5.178   3.09    0.96];
% Se define el vector de valores de la funcion a interpolar (Fuerza Aplicada)
y = [9     5.1       0.02    4.35    9   4.8     0.02    4.7 ];

% Se encuentran los coeficientes del polinomio interpolador de Lagrange
p = lagrange(x, y);

% Se grafica el polinomio interpolador de Lagrange y lo puntos a interpolar
plot(x, y, 'o', linspace(0, 6), polyval(p, linspace(0, 6)))
grid on
xlabel('X - Distancia desde Origen')
ylabel('F(x) - Fuerza Aplicada)')
title('Interpolacion de F(x) Mediante Polinomio de Lagrange')
print('images/lagrange.png', '-dpng', '-r300')
printf("Polinomio Interpolador de Lagrange para F(x):\n")
p

% Para el Segundo Punto
% Graficamos la funcion de X(t)
y = x;
x = 0:1:7;
plot(x, y, 'o', linspace(0, 16), -3*cos(0.78*linspace(0, 16)) + 3 )
grid on
axis([0 16 0 6])
xlabel('t - tiempo en segundos')
ylabel('X(t) - Posicion en el eje x')
title('Funcion de X(t)')
print('images/funcion_x(t).png', '-dpng', '-r300')


% Para el Tercer Punto
% Aplicamos el metodo de la secante sobre la ecuacion 3*cos(0.78*t) = 0

% Se define la funcion a la cual se le aplicara el metodo de la secante
f = @(t) 3*cos(0.78*t);

% Se define el intervalo inicial para el metodo de la secante
a = 2;
b = 5;

% Se aplica el metodo de la secante sobre la funcion f
[t, err, iter] = secante(f, a, b, 1e-6, 100);
printf('El metodo de la secante encontro la raiz en t = %f seg\nen %d iteraciones con un error de 1e-6\n', t, iter);

% Se grafica la funcion f y el punto encontrado por el metodo de la secante
plot(linspace(0, 16), f(linspace(0, 16)), t, f(t), 'o')
grid on
xlabel('t - tiempo en segundos')
ylabel('y - Posicion en el eje x con referencia en 3 ')
axis([0 7 -3 3])
title('Funcion de X(t) y Metodo de la Secante')
print('images/secante.png', '-dpng', '-r300')

% Para el Cuarto Punto
% encontramos el polinomio interpolador de Lagrange para Theta(x)

% Se define el vector de puntos a interpolar (Distancias en el eje x)
x = [0          0.86         2.96       5.08    6       5.178   3.09    0.96];
% Se define el vector de valores de la funcion a interpolar (Angulo en radianes)
y = [1.047      1.3089       1.5707     1.832   2.0943  1.85   1.58    1.3251];

% Se encuentran los coeficientes del polinomio interpolador de Lagrange
theta = lagrange(x, y);

% Se grafica el polinomio interpolador de Lagrange y lo puntos a interpolar
plot(x, y, 'o', linspace(0, 6), polyval(theta, linspace(0, 6)))
grid on
xlabel('X - Distancia desde Origen')
ylabel('Theta(x) - Angulo')
title('Interpolacion de Theta(x) Mediante Polinomio de Lagrange')
print('images/lagrange_theta.png', '-dpng', '-r300')
printf("Polinomio Interpolador de Lagrange para Theta(x):\n")
theta

% Luego se estudia la funcion de F(x)*Cos(Theta(x)) y se estudia su integral
% Se define la funcion a la cual se le aplicara la regla de Simpson
f = @(x) polyval(p, x).*cos(polyval(theta, x));

% Se define el intervalo inicial para la regla de Simpson
a = 0;
b = 6;

% Se aplica la regla de Simpson 1/3 compuesta sobre la funcion f
I = simpson(a, b, 100, f);

% Se grafica la funcion f y se sombrea el area bajo la curva
plot(linspace(0, 6), f(linspace(0, 6)), linspace(0, 6), 0, 'r', [a a], [0 f(a)], 'r', [b b], [0 f(b)], 'r')
grid on
% axis([0 6 0 10])
xlabel('X - Distancia desde Origen')
ylabel('F(x)*Cos(Theta(x)) - Fuerza Aplicada por Angulo')
title('Funcion de F(x)*Cos(Theta(x)) y Area Bajo la Curva')
print('images/simpson.png', '-dpng', '-r300')
printf('La estimacion del trabajo realizado por F es : %f J\n', I);

% Para el Quinto Punto
% se utiliza el metodo de diferencias finitas para estimar la derivada en cada punto
% luego sabiendo que la derivada real es 2.355*Sen(0.785t) se calcula el error relativo en cada punto

% Se define el vector de puntos a derivar (Distancias en el eje x)
t = 0:1:8;
y = [0      0.86    2.96    5.08    6   5.178   3.09    0.96    0];

% Aplicamos el metodo de diferencias finitas para estimar la derivada en cada punto
% y se calcula el error absoluto en cada punto
d = zeros(1, length(y));
der = @(t) 2.355*sin(0.785*t);
for i = 1:length(y)
  % Se calcula la derivada en el punto i-esimo
  d(i) = difdiv(y, 1, i);
  % Se calcula el error absoluto en el punto x(i)
  err(i) = abs( der(t(i)) - d(i) );
endfor

% Se imprime el valor estimado en cada punto, el valor real y el error absoluto en cada punto
printf("\nValor Estimado\tValor Real\tError absoluto\n")
for i = 1:length(y)
    printf("%f\t%f\t%f\n", d(i), der(t(i)), err(i))
endfor

