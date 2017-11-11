function ObjVal = sphere(Chrom)

% Dimension of objective function
    Dim=size(Chrom,2);

    acc=0;
    for i=1:Dim
    acc = acc + Chrom(i)^2;
    end
    ObjVal = acc;

% End of function

