clear all

c=1;
j=2;

for i=88:88
ktrueA=[0.041;  0.12 ;  0.064 ;  0.0075];
ktrueB=[0.064;  0.312;  0.041 ;  0.0098];
ktrueC=[0.100;  0.180;  0.029 ;  0.0082];
AIF_p=[851.1225; 21.8798; 20.8113; 4.134; 0.1191; 0.0104];

    
[AIF,TACs]=generateDATA(j,ktrueA,ktrueB,ktrueC,AIF_p);

TAC_array(:,i)={TACs(:,1),TACs(:,2),TACs(:,3)};
AIF_array(:,i)=AIF
end

% net = feedforwardnet;
% net.numinputs = 3;
% net.inputConnect = [1 1 1 ; 0 0 0];
% net = configure(net,TAC_array);
% net = train(net,TAC_array,AIF_array);
% view(net)

% TAC4a(:,:,:,i)=generateDATA4(j);
% TAC5a(:,:,:,i)=generateDATA5(j);
    
% TACarray3(:,:,:,:,c)=TAC3a;
% TACarray4(:,:,:,:,c)=TAC4a;
% TACarray5(:,:,:,:,c)=TAC5a;
% c=c+1;
% end

% save('C:\Users\HSARI\Dropbox\AIF_work\ModelBasedAIF_2\Aftersiemens\TAC_100.mat','TACarray3');
