%System B test
%Ariel Motsenyat - motsenya 
%Sharon Cai - cais12

%%
%Question 1 - test with unit impulse function - IIR
n = -5:15;
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; %unit impulse function
y_impulse = ltisystemB(n,x); %impulse respose

figure(1), subplot(1,1,1), stem(n, y_impulse), title("System B Impulse Response"), xlabel("n"), ylabel("y[n]");

%%
%Question 2 - test with unit step function
n = -5:15;
x_step = [0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; %unit-step function
y_unitstep = ltisystemB(n,x_step); %unit-step respose

figure(2), subplot(1,1,1), stem(n, y_unitstep), title("System B Unit Step Response"), xlabel("n"), ylabel("y[n]"); 

%Question 3 - unit step and unit impulse cumulative sum
x_impulse = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; %unit impulse function
y2_impulse = ltisystemB(n,x_impulse); %impulse respose
SUM_IMPULSE = cumsum(y2_impulse);

figure(3),
subplot(2,1,1), stem(n, y_unitstep), title("System B Unit Step Response"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), stem(n, SUM_IMPULSE), title("Cumulative Sum of the Impulse Response"), xlabel("n"), ylabel("y[n]");

%%
%Question 4 - unit impulse and first difference of unit step function
n = -5:15;
x2_impulse = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
x2_step = [0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

y3_unitstep = ltisystemB(n,x2_step); %step response
FIRST_DIFF_STEP = diff(y3_unitstep, 1); %1st difference of step function
FIRST_DIFF_STEP(end+1:numel(n))=0; %resize vector accounting for lost index

y3_impulse = ltisystemB(n,x2_impulse);

figure(4), 
subplot(2,1,1), stem(n, FIRST_DIFF_STEP), title("First Difference of the Unit Step Response"), xlabel("n"), ylabel("y[n]");
subplot(2,1,2), stem(n, y3_impulse), title("Unit Impulse Function Output"), xlabel("n"), ylabel("y[n]");

%%
%Question 5&6 - ECG & Respiration Signal directly computed through System A
load ECG_assignment2.mat
ecg = x;
n_ecg = [1:length(ecg)]; 
y_ecg = ltisystemB(n_ecg, ecg); 


load respiration_assignment2.mat
resp = x;
n_resp = [1:length(resp)]; 
y_resp = ltisystemB(n_resp, resp); 


figure(5),
subplot(2,1,1), plot(n_ecg, y_ecg), title("ECG Output Signal for System B"), xlabel("n"), ylabel("y[n]");
subplot(2,1,2), plot(n_resp, y_resp), title("Respiratory Output Signal for System B"), xlabel("n"), ylabel("y[n]");
%%
%Question 7 - convolution of ECG and respiration output and impulse response
load ECG_assignment2.mat
ecg = x;
n_ecg = [1:length(ecg)];
y_ecg = ltisystemB(n_ecg, ecg); 

load respiration_assignment2.mat
resp = x;
n_resp = [1:length(resp)];
y_resp = ltisystemB(n_resp, resp); 

n = -5:15; 
x = [0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
y4_impulse = ltisystemB(n,x);

CONV_ECG_B = conv(ecg, y4_impulse);
CONV_ECG_B = CONV_ECG_B([6:length(CONV_ECG_B)-15]); %i dont know why we need this

figure(6),
subplot(2,1,1), plot(n_ecg, y_ecg), title("ECG Output Signal for System B"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), plot(n_ecg, CONV_ECG_B), title("Convolved Signal for System B (ECG & Unit-Impulse)"), xlabel("n"), ylabel("y[n]"); 

CONV_RESP_B = conv(resp, y4_impulse);
CONV_RESP_B = CONV_RESP_B([6:length(CONV_RESP_B)-15]);

figure (7),
subplot(2,1,1), plot(n_resp, y_resp), title("Respiratory Output Signal for System B"), xlabel("n"), ylabel("y[n]"); 
subplot(2,1,2), plot(n_resp, CONV_RESP_B), title("Convolved Signal for System B (Respiration & Unit-Impulse)"), xlabel("n"), ylabel("y[n]"); 
