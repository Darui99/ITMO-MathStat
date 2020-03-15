pkg load statistics;

function res = f(x)
  res = log(x) ./ (x .+ 1);
endfunction

function monte_carlo(n)
  L = 4;
  R = 9;
  y = 0.95;
  Q = norminv((y + 1) / 2);
  X = unifrnd(L, R, 1, n);
  F_x = f(X) .* (R - L);
  V = mean(F_x);
  delta = (std(F_x) * Q) / sqrt(n);
  printf("N = %d\n", n);
  printf("Value is %g (from %g to %g)\n", V, V - delta, V + delta);
  printf("Delta is %g\n\n", delta); 
endfunction

printf("Sample answer = %g\n\n", quad(@f, 4, 9));
monte_carlo(10000);
monte_carlo(1000000);