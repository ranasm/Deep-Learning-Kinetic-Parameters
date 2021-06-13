function [AIF,TAC]= generateDATA(noiselevel,ktrueA,ktrueB,ktrueC,AIF_p)

addpath C:\Tools\noise\addnoise

% noiselevel=2;
SNR=noiselevel;

cm = compartmentModel;  % start with a new, empty model




    %        k1     k2      k3     k4

%    %        k1     k2      k3     k4
%    ktrueA=[0.1 ;  0.13 ; 0.06 ; 0.0068];
%    ktrueB=[0.2 ;  0.25 ; 0.04 ; 0.0058];
%    ktrueC=[0.05;  0.18 ; 0.02 ; 0.0064];



   % define the parameters
   cm = addParameter(cm, 'sa',    1);           % specific activity of injection, kBq/pmol
   cm = addParameter(cm, 'dk',    log(2)/109.8); % radioactive decay
   cm = addParameter(cm, 'PV',    1);            % (none)

   % region A
   cm = addParameter(cm, 'k1A',    ktrueA(1));     % 1/min
   cm = addParameter(cm, 'k2A',    ktrueA(2));     % 1/min
   cm = addParameter(cm, 'k3A',    ktrueA(3));     % ml/(pmol*min)
   cm = addParameter(cm, 'k4A',    ktrueA(4));     % 1/min

   % region B
   cm = addParameter(cm, 'k1B',    ktrueB(1));     % 1/min
   cm = addParameter(cm, 'k2B',    ktrueB(2));     % 1/min
   cm = addParameter(cm, 'k3B',    ktrueB(3));     % ml/(pmol*min)
   cm = addParameter(cm, 'k4B',    ktrueB(4));     % 1/min

   % region C
   cm = addParameter(cm, 'k1C',    ktrueC(1));     % 1/min
   cm = addParameter(cm, 'k2C',    ktrueC(2));     % 1/min
   cm = addParameter(cm, 'k3C',    ktrueC(3));     % ml/(pmol*min)
   cm = addParameter(cm, 'k4C',    ktrueC(4));     % 1/min
   

   % define input function parameter vector
  
   cm = addParameter(cm, 'pin', AIF_p);

   % define compartments for regions A, B, C (they can share the same junk or sink compartment)
   cm = addCompartment(cm, 'Junk');
   cm = addCompartment(cm, 'CeA');
   cm = addCompartment(cm, 'CmA');
   cm = addCompartment(cm, 'CeB');
   cm = addCompartment(cm, 'CmB');
   cm = addCompartment(cm, 'CeC');
   cm = addCompartment(cm, 'CmC');
;

   % define plasma input function
   % specifying function as refCp with parameters pin
   cm = addInput(cm, 'Cp', 'sa', 'dk', 'refCp', 'pin'); % plamsa pmol/ml

   % connect inputs and compartments
   
   % region A
   cm = addLink(cm, 'L', 'Cp',  'CeA', 'k1A');
   cm = addLink(cm, 'K', 'CeA', 'Junk','k2A');
   cm = addLink(cm, 'K', 'CeA', 'CmA', 'k3A');
   cm = addLink(cm, 'K', 'CmA', 'CeA', 'k4A');

   % region B
   cm = addLink(cm, 'L', 'Cp',  'CeB', 'k1B');
   cm = addLink(cm, 'K', 'CeB', 'Junk','k2B');
   cm = addLink(cm, 'K', 'CeB', 'CmB', 'k3B');
   cm = addLink(cm, 'K', 'CmB', 'CeB', 'k4B');

   % region C
   cm = addLink(cm, 'L', 'Cp',  'CeC', 'k1C');
   cm = addLink(cm, 'K', 'CeC', 'Junk','k2C');
   cm = addLink(cm, 'K', 'CeC', 'CmC', 'k3C');
   cm = addLink(cm, 'K', 'CmC', 'CeC', 'k4C');


   % specify scan begin and end times
   ttt=[ ones(6,1)*5/60; ...    %  6 frames x  5   sec
         ones(2,1)*15/60; ...   %  2 frames x 15   sec
         ones(6,1)*0.5;...      %  6 frames x  0.5 min
         ones(3,1)*2;...        %  3 frames x  2   min
         ones(2,1)*5;...        %  2 frames x  5   min
         ones(3,1)*10];        % 10 frames x 10   min
   scant = [[0;cumsum(ttt(1:(length(ttt)-1)))] cumsum(ttt)];
   midscant=(scant(:,1)+scant(:,2))./2;
   cm = set(cm, 'ScanTime', scant);
   
      % define an outputs, one for each region
   cm = addOutput(cm, 'RegA', {'CeA', 'PV'; 'CmA', 'PV'}, {});
   cm = addOutput(cm, 'RegB', {'CeB', 'PV'; 'CmB', 'PV'}, {});
   cm = addOutput(cm, 'RegC', {'CeC', 'PV'; 'CmC', 'PV'}, {});

   % solve model and generate example output
   [PET, PETindex]=solve(cm);
   n0=1; n1=0.333; n2=0.1666; n3= 0.04166; n4= 0.01666; n5=0.00833;
   
%  
   %Using COMKAT addnoise function
   nl=SNR;
   PET(:,3)=addNoiseDefault(PET(:,3),nl,scant);
   PET(:,4)=addNoiseDefault(PET(:,4),nl,scant);
   PET(:,5)=addNoiseDefault(PET(:,5),nl,scant);

   
   idx = [3 4 5 ];
%  plot(0.5*(PET(:,1)+PET(:,2)), PET(:,idx), '.');  

   TAC=PET(:,idx);
   AIF=refCp(AIF_p,midscant);
   
 end