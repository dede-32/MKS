close all

ntc = csvread('ntc.csv');    % columns: [temperature(°C), resistance(ohm)]
t = ntc(:,1);
r = ntc(:,2);

r = r * 1000;

R5 = 10000;                  % 10kΩ fixed resistor

% --- choose correct divider formula ---
% (most boards: NTC to GND)
ad = 1023 * (r ./ (R5 + r));      % 0..1023 codes

figure;
plot(ad, t, 'b.');
hold on;

% --- fit polynomial of order 10 ---
p = polyfit(ad, t, 10);

ad2 = 0:1023;
t2  = round(polyval(p, ad2), 1);


plot(ad2, t2, 'r');

grid on;

dlmwrite('data.dlm', t2*10, ',');

