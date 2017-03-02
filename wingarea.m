function area = wingarea(aircraft_type)
  % ASEN 2004 LAB 1 GROUP 34 SPRING 2017
  % PARAMS: aircraft_type => type string, either 'f16' or 'b787'. Other values will throw an error.
  % RETURNS: area => type double, the wing area of the scaled model.
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
