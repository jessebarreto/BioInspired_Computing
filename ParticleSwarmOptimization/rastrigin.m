
function ObjVal = rastrigin(Chrom)

% Dimension of objective function
    Dim=size(Chrom,2);
   
% Compute population parameters
      A = 10;
      Omega = 2 * pi;
      ObjVal = Dim * A + sum(((Chrom .* Chrom) - A * cos(Omega * Chrom))')';

