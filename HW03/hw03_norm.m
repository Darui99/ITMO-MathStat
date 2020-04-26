pkg load statistics;
clear;
clc;

function draw_plot(n, a, s, u)
  x = sort(normrnd(a, s, n, 1));
  F_n = 1 / n : 1 / n : 1; 
  [L, R] = stairs(x, F_n);

  t = (a - 3 * s) : 0.5 : a + 3 * s;
  F_real = normcdf(t, a, s);
  delta = u / sqrt(n);
  plot(L, R, t, F_real, L, max(0, R - delta), L, min(1, R + delta))
endfunction

function ans = kolmogorov_test(n, m, a, s, u)
  x = sort(normrnd(a, s, n, m));
  res = 0.0;
  
  for i = 1:n
    F_x_i = normcdf(x(i, :), a, s);
    res = max(res, abs(F_x_i - i / n));
    res = max(res, abs(F_x_i - (i - 1) / n));
  endfor
  
  ans = mean((sqrt(n) * res) > u);
endfunction

function ans = smirnov_test(n, m, a, s, w)
  x = sort(normrnd(a, s, n, m));
  sum = 1 / (12 * n);
  
  for i = 1:n
    F_x_i = normcdf(x(i, :), a, s);
    sum = sum + (F_x_i - (2 * i - 1) / (2 * n)).^2;
  endfor
  
  ans = mean(sum > w);
endfunction

n = 100;
a = pi;
s = e;
u = 1.36;
w = 0.4614;
draw_plot(n, a, s, u);
m1 = 10^4;
m2 = 10^6;

printf("Kolmogorov's test: n = %d, alpha = %g\n\n", m1, kolmogorov_test(n, m1, a, s, u));
printf("Smirnov's test: n = %d, alpha = %g\n\n", m1, smirnov_test(n, m1, a, s, w));
printf("Kolmogorov's test: n = %d, alpha = %g\n\n", m2, kolmogorov_test(n, m2, a, s, u));
printf("Smirnov's test: n = %d, alpha = %g\n\n", m2, smirnov_test(n, m2, a, s, w));
