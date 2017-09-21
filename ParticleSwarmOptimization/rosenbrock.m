function ObjVal = rosenbrock(Chrom)

% Dimension of objective function
    Dim=size(Chrom,2);

    acc=0;
    for i=1:Dim/2
    acc = acc + 100*(Chrom(2*i)-Chrom(2*i-1)^2)^2+(1-Chrom(2*i-1))^2;
    end
    ObjVal = acc;

% End of function

