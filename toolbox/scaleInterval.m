function [out, coeffs] = scaleInterval(data, interval, coeffs)

if nargin < 3
    coeffs = zeros(2, size(data.x, 2));
    for dim = 1:size(data.x, 2)
        dataMin = min(data.x(:, dim));
        dataMax = max(data.x(:, dim));
        coeffs(:, dim) = [dataMin; dataMax];
    end
    
    if nargin < 2
       interval = [-1, 1];
    end
end

out.x = [];
out.labels  = data.labels;
out.targets = data.targets;

for dim = 1:size(data.x, 2)
   dataMin = coeffs(1, dim);
   dataMax = coeffs(2, dim);
   
   dimvals = ((data.x(:, dim) - dataMin) / (dataMax - dataMin))... 
              * (interval(2) - interval(1)) + interval(1);
   out.x = [out.x dimvals];
end

end