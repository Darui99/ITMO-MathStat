pkg load statistics;
clear;
clc;

xmin = -1.3;
xmax = 1.7;
n = 40;
c = [1.1, 2.5];
s = 2.7;

X = xmin : (xmax - xmin) / (n - 1) : xmax;
y = polyval(c, X);
Y = y + s * randn(1, n);

xn = mean(X);
yn = mean(Y);
cov = (X - xn) * (Y - yn)' / (n - 1);
b = cov / (std(X)^2);
Yp1 = yn + b * (X - xn);

polynom = polyfit(X, Y, 1);
printf("Check coef. diff: %f\n", polynom(1) - b);
Yp2 = polyval(polynom, X);

e = Yp1 - Y;
printf("Orthogonality check: %f\n", Yp1 * e');
sn = sqrt(e / (n - 2) * e');
printf("Noise assessment: %f\n", sn);

t = 1.96;
h = t * (sn / sqrt(n));
d = h * (1 + (X - xn).^2 / (std(X)^2)).^(1 / 2);
Yl = Yp1 - d;
Yr = Yp1 + d;

plot(X, Y, '+', X, y, X, Yp1, 'o', X, Yp2, '*', X, Yl, X, Yr);
