pkg load statistics;

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

n = 100;
a = 3.14;
s = 2.7;
u = 1.36;
draw_plot(n, a, s, u);
m1 = 10^4;
m2 = 10^6;
printf("n = %d: alpha = %g\n\n", m1, kolmogorov_test(n, m1, a, s, u));
printf("n = %d: alpha = %g\n\n", m2, kolmogorov_test(n, m2, a, s, u));