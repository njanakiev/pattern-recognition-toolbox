function [ out, coeffs ] = scaleZScore( data, coeffs )

if nargin < 2
    coeffs = zeros(2, size(data.x, 2));
    for dim = 1:size(data.x, 2)
        dataMean = mean(data.x(:, dim));
        dataStd  = std(data.x(:, dim));
        coeffs(:, dim) = [dataMean; dataStd];
    end
end

out.x = [];
out.labels  = data.labels;
out.targets = data.targets;
for dim = 1:size(data.x, 2)
   dataMean = coeffs(1, dim);
   dataStd  = coeffs(2, dim);
   dimVals  = ((data.x(:, dim)) - dataMean) / dataStd;
   out.x = [out.x dimVals];
end

end