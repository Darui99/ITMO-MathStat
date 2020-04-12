pkg load statistics;

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

n = 100;
a = 13;
b = 37;
u = 1.36;
draw_plot(n, a, b, u);
m1 = 10^4;
m2 = 10^6;
printf("n = %d: alpha = %g\n\n", m1, kolmogorov_test(n, m1, a, b, u));
printf("n = %d: alpha = %g\n\n", m2, kolmogorov_test(n, m2, a, b, u));