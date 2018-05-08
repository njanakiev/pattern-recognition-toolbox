function [ unmappedClasses ] = TargetUnmapper( data )
    % Anzahl Daten
    datasize = size(data,1);
    % Anzahl Klassen
    numClasses = size(data,2);
    % Ergebnisvektor mit 0 initialisieren
    unmappedClasses = zeros(datasize,1);
    % Für jede Klasse
    for i=1:numClasses
        % wenn in Spalte 1 --> Spaltenindex setzen
        index = find(data(:,i)==1);
        unmappedClasses(index) = i-1;
    end
end

