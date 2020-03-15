pkg load statistics;

function monte_carlo(n)
  c = 8.8;
  y = 0.95;
  k = 10; 
  Q = norminv((y + 1) / 2);
  X = rand(k, n);
  F_x = sum(exp(-0.35 .* X));
  In = mean(F_x <= c);
  delta = Q * sqrt(In * (1 - In) / n);
  printf("N = %d\n", n);
  printf("Volume is %g (from %g to %g)\n", In, In - delta, In + delta);
  printf("Delta is %g\n\n", delta); 
endfunction

monte_carlo(10000);
monte_carlo(1000000);
