function ObjVal = quadric(Chrom)

    Dim=size(Chrom,2);

      acc2=0;
      for i=1:Dim
          acc=0;
          for j=1:i
              acc = acc+Chrom(j);
          end
          acc2=acc2+acc^2;
      end
      ObjVal=acc2;

