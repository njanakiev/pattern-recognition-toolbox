function [err, c1, c2, c3, c4] = calcConfusion(dat1, dat2)

n = length(dat1);
c1 = sum((dat2 == 0)&(dat1 == 0));    %TP
c2 = sum((dat2 == 0)&(dat1 == 1));    %FN
c3 = sum((dat2 == 1)&(dat1 == 0));    %TP
c4 = sum((dat2 == 1)&(dat1 == 1));    %FN

disp(['class 0: True Positives: ',num2str(c1),' - False Positives: ', num2str(c2),]);
disp(['class 1: True Positives: ',num2str(c3),' - False Positives: ', num2str(c4),]);

disp(' ');
disp('Percentages');
disp([c1/n*100 c2/n*100]);
disp([c3/n*100 c4/n*100]);

err = (c2 + c3)/n*100;
disp(['Total Classification Error: ',num2str(err),' %'])
