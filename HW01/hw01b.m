pkg load statistics;

function [res] = g(x)
  res = sqrt(1 + x * x);
endfunction

function [res] = f(x)
  res = g(x) * exp(-3 * x);
endfunction

function monte_carlo(n)
  j = 3;
  y = 0.95;
  Q = norminv((y + 1) / 2);
  X = exprnd(1/j, 1, n);
  F_x = arrayfun(@(x) g(x) * 1/j, X);
  V = mean(F_x);
  delta = (std(F_x) * Q) / sqrt(n);
  printf("N = %d\n", n);
  printf("Value is %g (from %g to %g)\n", V, V - delta, V + delta);
  printf("Delta is %g\n\n", delta);
endfunction

printf("Sample answer = %g\n\n", quad(@f, 0, inf));
monte_carlo(10000);
monte_carlo(1000000);