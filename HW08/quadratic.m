pkg load statistics;
clear;
clc;

xmin = -1.3;
xmax = 1.7;
n = 40;
a = [1.1, -2.2, 3.7];
s = 2.7;

X = xmin : (xmax - xmin) / (n - 1) : xmax;
y = polyval(a, X);
Y = y + s * randn(1, n);
polynom = polyfit(X, Y, 2);
Yp = polyval(polynom, X);
plot(X, Y, '+', X, y, X, Yp, 'o');
e = Yp - Y;
printf("Orthogonality check: %f\n", Yp * e');
printf("Noise assessment: %f\n", sqrt(e / (n - 3) * e'));