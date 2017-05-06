clear all;
close all;

disp('Frequenzmodulation');

T_max = 1;
numsteps = 1000;
T_delta = T_max / numsteps;
t = [0:T_delta:T_max];

A = 1;
f_0 = 3;
d = 0.1; %/(2*pi);

phi_0 = pi;


F = 10;
s = sin(t*2*pi*F);

s = ones(1,length(t));
s = randi(2, 1, length(t)) - 1;

%s = [ones(floor(length(t)/2), 1)' 2*ones(ceil(length(t)/2), 1)'] 

u = [];
for i = [1:length(t)]
    ui = A * cos(f_0*2*pi*t(i) + d*sum(s([1:i])) + phi_0);
    u = [u,ui]; % * cumsum(t([0:i])));
end

w = 2*pi*f_0 + d*s;

length(t)
length(u)

filt = [1 1 1 -1 -1];
filt = filt/length(filt);

z = conv(u, filt);
figure('Name','u');
plot(t,u,'r');
hold
%stem(t, u);
figure('Name','z');
plot(z);
figure('Name','w');
plot(t, w);
figure('Name','fft');
plot(abs(fft(filt)));
freqz(filt);


