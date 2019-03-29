%load trainig preictal signals for patient 5

clear
clc

tic;

signalNo = 1380; 

level = 5;
wname = 'sym4';
npc = 'kais';
P = [];

database=[];
signal = [];

totalLength = 921600; % 1 hour (256Hz*60*60)
length48min = 737280;

%files names
preseizure1channel = 'chb05_05_edfm.mat';
seizure1channel = 'chb05_06_edfm.mat';

preseizure2channel = 'chb05_12_edfm.mat';
seizure2channel = 'chb05_13_edfm.mat';

preseizure3channel = 'chb05_21_edfm.mat';
seizure3channel = 'chb05_22_edfm.mat';


seizure1start = 106752; %start of seizure (417*256Hz)
preictalSeizure1start = totalLength -(length48min - seizure1start); 

seizure2start = 278016; %start of seizure (1086*256Hz)
preictalSeizure2start = totalLength -(length48min - seizure2start);

seizure3start = 601088; %start of seizure (2348*256Hz)
preictalSeizure3start = totalLength -(length48min - seizure3start);

ictal_sig_1=load(seizure1channel);
preictal_sig_1=load(preseizure1channel);

ictal_sig_1_seizure=ictal_sig_1.val(:,1:seizure1start);
preictal_sig_1_seizure=preictal_sig_1.val(:,preictalSeizure1start:end);

ictal_signal_1=[preictal_sig_1_seizure ictal_sig_1_seizure];

signal = ictal_signal_1;


j=1;

while (j < size(signal,2)-2049) %po 8 sec sample (8*256Hz)
    database = [database; signal(:,j:j+2047)];
    j=j+2048;               
end

ictal_sig_2=load(seizure2channel);
preictal_sig_2=load(preseizure2channel);

ictal_sig_2_seizure=ictal_sig_2.val(:,1:seizure2start);
preictal_sig_2_seizure=preictal_sig_2.val(:,preictalSeizure2start:end);

ictal_signal_2=[preictal_sig_2_seizure ictal_sig_2_seizure];

signal = [];
signal = ictal_signal_2;

j=1;

while (j < size(signal,2)-2049)
    database = [database; signal(:,j:j+2047)];
    j=j+2048;               
end

ictal_sig_3=load(seizure3channel);
preictal_sig_3=load(preseizure3channel);

ictal_sig_3_seizure=ictal_sig_3.val(:,1:seizure3start);
preictal_sig_3_seizure=preictal_sig_3.val(:,preictalSeizure3start:end);

ictal_signal_3=[preictal_sig_3_seizure ictal_sig_3_seizure];
signal = [];
signal = ictal_signal_3;

j=1;

while (j < size(signal,2)-2049)
    database = [database; signal(:,j:j+2047)];
    j=j+2048;               
end

signal = [];
signal = database';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FOCAL/ICTAL DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z = floor(size(signal,2)/signalNo);


for k = 1:z
    
l = (1380*(k-1)+1);
m = 1380*k;


[x_mpca, qual, npc] = wmspca(signal(:,l:m), level, wname, npc);

preictal_mpca = x_mpca';

for i = 1:signalNo

[wp10,wp11] = dwt(preictal_mpca(i,:), wname); 

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
end

TimeSpent = toc;