pkg load statistics;
clear;
clc;

function draw_plot(n, a, b, u)
  x = sort(unifrnd(a, b, n, 1));
  F_n = 1 / n : 1 / n : 1; 
  [L, R] = stairs(x, F_n);

  t = 0 : 0.5 : 50;
  F_real = unifcdf(t, a, b);
  delta = u / sqrt(n);
  plot(L, R, t, F_real, L, max(0, R - delta), L, min(1, R + delta))
endfunction

function ans = kolmogorov_test(n, m, a, b, u)
  x = sort(unifrnd(a, b, n, m));
  res = 0.0;
  
  for i = 1:n
    F_x_i = unifcdf(x(i, :), a, b);
    res = max(res, abs(F_x_i - i / n));
    res = max(res, abs(F_x_i - (i - 1) / n));
  endfor
  
  ans = mean((sqrt(n) * res) > u);
endfunction

function ans = smirnov_test(n, m, a, b, w)
  x = sort(unifrnd(a, b, n, m));
  sum = 1 / (12 * n);
  
  for i = 1:n
    F_x_i = unifcdf(x(i, :), a, b);
    sum = sum + (F_x_i - (2 * i - 1) / (2 * n)).^2;
  endfor
  
  ans = mean(sum > w);
endfunction

n = 100;
a = 13;
b = 37;
u = 1.36;
w = 0.4614;
draw_plot(n, a, b, u);
m1 = 10^4;
m2 = 10^6;

printf("Kolmogorov's test: n = %d, alpha = %g\n\n", m1, kolmogorov_test(n, m1, a, b, u));
printf("Smirnov's test: n = %d, alpha = %g\n\n", m1, smirnov_test(n, m1, a, b, w));
printf("Kolmogorov's test: n = %d, alpha = %g\n\n", m2, kolmogorov_test(n, m2, a, b, u));
printf("Smirnov's test: n = %d, alpha = %g\n\n", m2, smirnov_test(n, m2, a, b, w));
