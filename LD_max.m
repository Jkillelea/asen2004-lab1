function LDmax = LD_max(airplane)
  LDmax = max(airplane.CL ./ airplane.CD);
end
