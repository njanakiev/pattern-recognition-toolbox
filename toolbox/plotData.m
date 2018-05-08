function plotData( data, varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dimensions = size(data.x(1,:), 2);

if nargin == 1  
    selector = 1:dimensions;
else
    selector = varargin{1};
end

figure;

dimensions=length(selector);

if dimensions == 1
    scatter(data.x(:, selector(1)), zeros(size(data.x(:, selector(1)), 1), 1), [], data.targets, 'filled');
    xlabel(data.labels{1});
    grid on;
elseif dimensions == 2
    scatter(data.x(:, selector(1)), data.x(:, selector(2)), [], data.targets, 'filled');
    xlabel(data.labels{1});
    ylabel(data.labels{2});
    grid on;
elseif dimensions == 3
    scatter3(data.x(:, selector(1)), data.x(:, selector(2)), data.x(:, selector(3)), [], data.targets, 'filled');
    xlabel(data.labels{1});
    ylabel(data.labels{2});
    zlabel(data.labels{3});
    grid on;
end

end

