function [ mappedClasses ] = TargetMapper( data )
    % Anzahl Daten
    datasize = size(data,1);
    % Klassen
    classes = unique(data);
    % Anzahl Klassen
    numClasses = length(classes);
    % Ergebnismatrix mit 0 initialisieren
    mappedClasses = zeros(datasize,numClasses);
    % Für jede Klasse
    for i=1:numClasses
        % wenn gleich Klasse --> auf 1 setzen
        index = find(data==classes(i));
        mappedClasses(index,i) = 1;
    end
end