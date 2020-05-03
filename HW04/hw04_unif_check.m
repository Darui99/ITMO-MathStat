pkg load statistics;
clear;
clc;

a = 13;
b = 37;

n = 10^4;
m = 22;
k = 10^3;

er1 = 0;
for j = 1:k
  X = sort(unifrnd(a, b, n, 1));
  Y = hist(X, m);
  Len = (X(n) - X(1)) / m;
  sum = 0;
  for i = 1:m
    P = unifcdf(X(1) + Len * i, a, b) - unifcdf(X(1) + Len * (i - 1), a, b);
    sum += (Y(i) - n * P)^2 / (n * P);
  endfor
  er1 += (sum > chi2inv(0.95, m - 1));
endfor
er1 /= k;
printf("Ошибка первого рода: %f\n", er1);

er2 = 0;
eps = 0.23;
for j = 1:k
  X = sort(unifrnd(a - eps, b + eps, n, 1));
  Y = hist(X, m);
  Len = (X(n) - X(1)) / m;
  sum = 0;
  for i = 1:m
    P = unifcdf(X(1) + Len * i, a, b) - unifcdf(X(1) + Len * (i - 1), a, b);
    sum += (Y(i) - n * P)^2 / (n * P);
  endfor
  er2 += (sum < chi2inv(0.95, m - 1));
endfor
er2 /= k;
printf("Ошибка второго рода: %f\n", er2);