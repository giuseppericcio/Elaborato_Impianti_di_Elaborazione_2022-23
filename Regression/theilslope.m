function [m,b,slopes] = theilslope(X,Y)
    % Calcolare le pendenze tra tutte le coppie di punti di dati
    slopes = zeros(length(X)*(length(X)-1)/2,1);
    index = 1;
    for i=1:length(X)
        for j=i+1:length(X)
            slopes(index) = (Y(j) - Y(i))/(X(j) - X(i));
            index = index + 1;
        end
    end
      
    % Calcolare la mediana delle pendenze
    m = median(slopes);
    % Calcolare l'intercetta utilizzando la formula b = median(Y) - m * median(X)
    b = median(Y) - m * median(X);
end