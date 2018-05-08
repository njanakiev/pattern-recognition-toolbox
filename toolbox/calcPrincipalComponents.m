function [transDataTrain, coeffs] = calcPrincipalComponents(trainData, dimReduct, coeffs)

if nargin == 1
   dimReduct = size(trainData.x, 2); 
end

if nargin < 3
    coeffs.mean = mean(trainData.x, 1);
    
    % subtract the mean in each coordinate
    % here we use the outer product to do is in an elegant way
    Xcentered = trainData.x - ones(size(trainData.x, 1), 1) * coeffs.mean;
    
    % check this by calculating the mean(Xcentered) which ist the zero vector!
    % calculate the covariance matrix
    Sigma = cov(Xcentered);
    
    % compute eigenvalues and eigenvectors
    [EVe, EVa] = eig(Sigma);
    
    % we take out the eigenvalues from the diagonal matrix and sort them
    % idx contains the sorting index which we need to sort the
    % eigenvectors in the same order
    [EVa, idx] = sort(diag(EVa), 'descend');
    
    % lets resort the eigenvectors
    EVe = EVe(:,idx);
    coeffs.EVe = EVe;
    coeffs.EVa = EVa;
    
    normalized = EVa / sum(EVa);
    fprintf('Own PCA: %s Dimensions(/s) exhibit %s procent of the data variance.\n',...
        num2str(dimReduct), num2str(sum(normalized(1:dimReduct))*100));
else
    Xcentered = trainData.x - ones(size(trainData.x, 1), 1) * coeffs.mean;
    EVe = coeffs.EVe;
end

% now transform the data to the new coordinates by multiplying
% (this works since the eigenvectors form an orthonormal basis so that
% coordinates can simply be calculated by the inner product
Z = EVe' * Xcentered';

transDataTrain.labels = trainData.labels(1:dimReduct);
transDataTrain.targets = trainData.targets;
transDataTrain.x = Z(1:dimReduct, :)';
    
end
