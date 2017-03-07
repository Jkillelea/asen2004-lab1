function [ dCMdA, dCLdA, sMargin ] = staticCalc( CM, CL, A, n )

  l = length(CM);
  j = 0;
  dcmda = 0;
  dclda = 0;
  for i = 1:floor(l / n)
      cm  = CM(n*(i-1)+1:n*i);
      cl  = CL(n*(i-1)+1:n*i);
      a   = A(n*(i-1)+1:n*i);

      [~, idx] = min(abs(a));

      if abs(round(a(idx))) == 0
        dcmda = dcmda + (cm(idx+1)-cm(idx-1)) ./ (a(idx+1)-a(idx-1));
        dclda = dclda + (cl(idx+1)-cl(idx-1)) ./ (a(idx+1)-a(idx-1));
      elseif round(a(idx)) <= 0
        dcmda = dcmda + (cm(idx+1)-cm(idx))   ./ (a(idx+1)-a(idx));
        dclda = dclda + (cl(idx+1)-cl(idx))   ./ (a(idx+1)-a(idx));
      else
        dcmda = dcmda + (cm(idx)-cm(idx-1))   ./ (a(idx)-a(idx-1));
        dclda = dclda + (cl(idx)-cl(idx-1))   ./ (a(idx)-a(idx-1));
      end
      j = j+1;
  end

  dCMdA = dcmda./j;
  dCLdA = dclda./j;

  sMargin = -dCMdA./dCLdA;
end
