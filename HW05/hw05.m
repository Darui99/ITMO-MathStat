pkg load statistics;
clear;
clc;

function res = laplrnd(a, u, n, m) 
  res = exprnd(u, n, m) - exprnd(u, n, m) .+ a;
endfunction

function check(n, m, Frnd, estimator, s_perf, prefix)
  X = Frnd(n, m);
  T = estimator(X);
  s_real = std(T, 1);
  printf(prefix);
  printf("Real = %f, Perfect = %f\n", s_real, s_perf);
endfunction

function multi_check(n, m)
  printf("n = %d, m = %d\n", n, m);
  
  a = pi;
  s = e;
  check(n, m, @(x, y) normrnd(a, s, x, y), @(x) mean(x), s / sqrt(n), "Norm. distribution, average: ");
  check(n, m, @(x, y) normrnd(a, s, x, y), @(x) median(x), s * sqrt(pi / (2 * n)), "Norm. distribution, med: ");
  check(n, m, @(x, y) normrnd(a, s, x, y), @(x) (min(x) .+ max(x)) ./ 2, s * sqrt(0.4 / log(n)), "Norm. distribution, min-max: ");

  a = pi;
  u = e;
  check(n, m, @(x, y) laplrnd(a, u, x, y), @(x) mean(x), u * sqrt(2 / n), "Laplace distribution, average: ");
  check(n, m, @(x, y) laplrnd(a, u, x, y), @(x) median(x), u / sqrt(n), "Laplace distribution, med: ");
  check(n, m, @(x, y) laplrnd(a, u, x, y), @(x) (min(x) .+ max(x)) ./ 2, u * 0.9, "Laplace distribution, min-max: ");

  a = 25;
  d = 24;
  check(n, m, @(x, y) unifrnd(a - d / 2, a + d / 2, x, y), @(x) mean(x), d / sqrt(12 * n), "Unif. distribution, average: ");
  check(n, m, @(x, y) unifrnd(a - d / 2, a + d / 2, x, y), @(x) median(x), d / sqrt(4 * n), "Unif. distribution, med: ");
  check(n, m, @(x, y) unifrnd(a - d / 2, a + d / 2, x, y), @(x) (min(x) .+ max(x)) ./ 2, d / sqrt(2 * n * n), "Unif. distribution, min-max: ");
  
  printf("\n");
endfunction

multi_check(10^2, 10^2);
multi_check(10^4, 10^2);
