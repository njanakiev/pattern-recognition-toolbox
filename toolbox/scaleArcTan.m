function [ out, coeffs ] = scaleArcTan( data, coeffs )
    
if nargin < 2
    [out, coeffs] = scaleZScore(data);
else
    [out, coeffs] = scaleZScore(data, coeffs);
end
out.x = 2/pi*atan(out.x);

end