function area = wingarea(aircraft_type)
  % calculates the wing area of each model (not full-size)
  switch aircraft_type
  case 'f16'
    % 300 square ft : http://www.lockheedmartin.com/us/products/f16/F-16Specifications.html
    fullscale = 27.8709;
    area = fullscale / (48^2);
    return;
  case 'b787'
    % 3,880 sq ft (360.5 sq m) : https://en.wikipedia.org/wiki/Boeing_787_Dreamliner#Specifications
    fullscale = 360.5;
    area = fullscale / (225^2);
    return;
  otherwise
    error('[ERROR] wingarea.m - invalid aircraft type entered (%s).', aircraft_type);
  end
end
