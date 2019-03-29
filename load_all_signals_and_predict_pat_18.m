%clear
clc

tic;

javaaddpath('weka.jar');
import weka.classifiers.*;
import weka.classifiers.Classifier.*;
import weka.classifiers.Evaluation.*;

%load clssf_rf_18;
s = struct;

signalNo = 1380; %23*60

level = 5;
wname = 'sym4';
npc = 'kais';

database = [];
signal = [];

% Loadanje interictal test signala
for i = 16:28
   
    string = strcat('chb18_', num2str(i), '_edfm', '.mat'); 
    x = load (string);
    sig = x.val(:,:);
    sig = sig';
    signal = [signal; sig];  
    
end

%{
 for i = 33:34
     string = strcat('chb18_', num2str(i), '_edfm', '.mat');
     x = load (string);
     sig = x.val(:,:);
     sig = sig';
     signal = [signal; sig];        
 end
%}

% Loadanje preictal + ictal za test

%ictal_sig_1=load('chb18_35_edfm.mat');
%signal=[signal;ictal_sig_1.val(:,:)'];

ictal_sig_2=load('chb18_36_edfm.mat');
signal=[signal;ictal_sig_2.val(:,:)'];

signal = signal';

j=1;

while (j < size(signal,2)-2049)
    database = [database; signal(:,j:j+2047)];
    j=j+2048;               
end


database=database';

z = floor(size(database,2)/signalNo);

alarm = zeros (1, z);
result = zeros(1, z);

for k = 1:z
    
l = (1380*(k-1)+1);
m = 1380*k;
[x_mpca, qual, npc] = wmspca(database(:,l:m), level, wname, npc);

interictal_mpca = x_mpca';

P = [];
p = [];
for i = 1:signalNo

    [wp10,wp11] = dwt(interictal_mpca(i,:), wname); 

    [wp20,wp21] = dwt(wp10,wname); 
    [wp22,wp23] = dwt(wp11,wname); 
    [wp30,wp31] = dwt(wp20,wname);
    [wp32,wp33] = dwt(wp21,wname); 
    [wp34,wp35] = dwt(wp22,wname); 
    [wp36,wp37] = dwt(wp23,wname); 

    [wp40,wp41] = dwt(wp30,wname);
    [wp42,wp43] = dwt(wp31,wname); 
    [wp44,wp45] = dwt(wp32,wname); 
    [wp46,wp47] = dwt(wp33,wname); 
    [wp48,wp49] = dwt(wp34,wname);
    [wp4A,wp4B] = dwt(wp35,wname); 
    [wp4C,wp4D] = dwt(wp36,wname); 
    [wp4E,wp4F] = dwt(wp37,wname); 
    
      
p(1,i)=mean(abs(wp40));
p(2,i)=mean(abs(wp41));
p(3,i)=mean(abs(wp42));
p(4,i)=mean(abs(wp43));
p(5,i)=mean(abs(wp44));
p(6,i)=mean(abs(wp45));
p(7,i)=mean(abs(wp46));
p(8,i)=mean(abs(wp47));
p(9,i)=mean(abs(wp48));
p(10,i)=mean(abs(wp49));
p(11,i)=mean(abs(wp4A));
p(12,i)=mean(abs(wp4B));
p(13,i)=mean(abs(wp4C));
p(14,i)=mean(abs(wp4D));
p(15,i)=mean(abs(wp4E));
p(16,i)=mean(abs(wp4F));

    uD1=length(wp40);
    uD2=length(wp41);
    uD3=length(wp42);
    uD4=length(wp43);
    uD5=length(wp44);
    uD6=length(wp45);
    uD7=length(wp46);
    uD8=length(wp47);
    uD9=length(wp48);
    uD10=length(wp49);
    uDA=length(wp4A);
    uDB=length(wp4B);
    uDC=length(wp4C);
    uDD=length(wp4D);
    uDE=length(wp4E);
    uDF=length(wp4F);

p(17,i)=sqrt(sum(wp40(:).^2)/uD1);
p(18,i)=sqrt(sum(wp41(:).^2)/uD2);
p(19,i)=sqrt(sum(wp42(:).^2)/uD3);
p(20,i)=sqrt(sum(wp43(:).^2)/uD4);
p(21,i)=sqrt(sum(wp44(:).^2)/uD5);
p(22,i)=sqrt(sum(wp45(:).^2)/uD6);
p(23,i)=sqrt(sum(wp46(:).^2)/uD7);
p(24,i)=sqrt(sum(wp47(:).^2)/uD8);
p(25,i)=sqrt(sum(wp48(:).^2)/uD9);
p(26,i)=sqrt(sum(wp49(:).^2)/uD10);
p(27,i)=sqrt(sum(wp4A(:).^2)/uDA);
p(28,i)=sqrt(sum(wp4B(:).^2)/uDB);
p(29,i)=sqrt(sum(wp4C(:).^2)/uDC);
p(30,i)=sqrt(sum(wp4D(:).^2)/uDD);
p(31,i)=sqrt(sum(wp4E(:).^2)/uDE);
p(32,i)=sqrt(sum(wp4F(:).^2)/uDF);
    
p(33,i)=std(wp40);
p(34,i)=std(wp41);
p(35,i)=std(wp42);
p(36,i)=std(wp43);
p(37,i)=std(wp44);
p(38,i)=std(wp45);
p(39,i)=std(wp46);
p(40,i)=std(wp47);
p(41,i)=std(wp48);
p(42,i)=std(wp49);
p(43,i)=std(wp4A);
p(44,i)=std(wp4B);
p(45,i)=std(wp4C);
p(46,i)=std(wp4D);
p(47,i)=std(wp4E);
p(48,i)=std(wp4F);

p(49,i)=mean(abs(wp40))/mean(abs(wp41));
p(50,i)=mean(abs(wp41))/mean(abs(wp42));
p(51,i)=mean(abs(wp42))/mean(abs(wp43));
p(52,i)=mean(abs(wp43))/mean(abs(wp44));
p(53,i)=mean(abs(wp44))/mean(abs(wp45));
p(54,i)=mean(abs(wp45))/mean(abs(wp46));
p(55,i)=mean(abs(wp46))/mean(abs(wp47));
p(56,i)=mean(abs(wp47))/mean(abs(wp48));
p(57,i)=mean(abs(wp48))/mean(abs(wp49));
p(58,i)=mean(abs(wp49))/mean(abs(wp4A));
p(59,i)=mean(abs(wp4A))/mean(abs(wp4B));
p(60,i)=mean(abs(wp4B))/mean(abs(wp4C));
p(61,i)=mean(abs(wp4C))/mean(abs(wp4D));
p(62,i)=mean(abs(wp4D))/mean(abs(wp4E));
p(63,i)=mean(abs(wp4E))/mean(abs(wp4F));

p(64,i)=skewness(wp40);
p(65,i)=skewness(wp41);
p(66,i)=skewness(wp42);
p(67,i)=skewness(wp43);
p(68,i)=skewness(wp44);
p(69,i)=skewness(wp45);
p(70,i)=skewness(wp46);
p(71,i)=skewness(wp47);
p(72,i)=skewness(wp48);
p(73,i)=skewness(wp49);
p(74,i)=skewness(wp4A);
p(75,i)=skewness(wp4B);
p(76,i)=skewness(wp4C);
p(77,i)=skewness(wp4D);
p(78,i)=skewness(wp4E);
p(79,i)=skewness(wp4F);

p(80,i)=kurtosis(wp40);
p(81,i)=kurtosis(wp41);
p(82,i)=kurtosis(wp42);
p(83,i)=kurtosis(wp43);
p(84,i)=kurtosis(wp44);
p(85,i)=kurtosis(wp45);
p(86,i)=kurtosis(wp46);
p(87,i)=kurtosis(wp47);
p(88,i)=kurtosis(wp48);
p(89,i)=kurtosis(wp49);
p(90,i)=kurtosis(wp4A);
p(91,i)=kurtosis(wp4B);
p(92,i)=kurtosis(wp4C);
p(93,i)=kurtosis(wp4D);
p(94,i)=kurtosis(wp4E);
p(95,i)=kurtosis(wp4F);

end

P = [P; p'];


    % Feature vector heading
        
        numFeatures = size(P, 2);
        features = {};
        
        for f = 1:numFeatures
            features (f,:) = {strcat('f',int2str(f))};
        end
        
        features (f+1,:) = {'class'};            
    
    % Converting feature vector into cell
    klasa = ones(1380, 1);
    Pp = [P klasa];
    testCell = cell(size(Pp));
    for f = 1:numFeatures
        testCell (:,f) = num2cell (P(:,f));
    end
        testCell (:,numFeatures + 1) = {'INTERICTAL'};
        testCell (1381, :) = num2cell (0); 
        testCell (1381,numFeatures + 1) = {'ICTAL'};
    
    % Evaluation
    test_weka_labeled = matlab2weka ('test', features, testCell); 
    
    
    %%%%%%
    for j = 0:1379
        predicted (k, j+1) = save_clssf.classifyInstance(test_weka_labeled.instance(j));
    end
    
    suma_predicted (k, 1) = sum(predicted(k, :));
        
    % Notification
    if (sum(predicted(k, :)) > 450)
        result (k) = 1;
    else
        result (k) = 0;
    end
    
    if (k <= 5)
        if (sum(result) >=3 )
            alarm (k) = 1
        end
    else
    if (sum(result(k-4:k)) >=3)
        alarm (k) = 1;
    end
    end
    
%     % Accuracy
%     if test_weka_labeled.instance(0).classValue ~= predicted(pokusaj)
%         err = err + 1;
%         assignin('base', 'err', err);
%     end   

end
TimeSpent = toc;