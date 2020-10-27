% "main"
% Calculates angle of incidence and time delay in plane of microphones.

channels = 5;
Fs = 31250;
angle_rad=zeros(12,1);
angle_deg=zeros(12,1);
y=[];
final_table = zeros(10,3);
final_table(1:3,1) = 45;
final_table(4:6,1) = 135;
final_table(7:8,1) = 225;
final_table(9:10,1) = 315;

for i=1:10
    path = ['k',int2str(i),'.bin'];
    [rawData, nomTp] = raspiImport(path,channels);

% fetch signals from binary
%signal_1 = band_pass(rawData(:,1), Fs);
%signal_2 = band_pass(rawData(:,2), Fs);
%signal_3 = band_pass(rawData(:,3), Fs);
inter_rawData = interp1((0:Fs - 1),rawData,(0:1/5:Fs - 1));
signal_1 = inter_rawData(:,1);
signal_2 = inter_rawData(:,2);
signal_3 = inter_rawData(:,3);

% remove DC-offset:
signal_1 = signal_1 - mean(signal_1);
signal_2 = signal_2 - mean(signal_2);
signal_3 = signal_3 - mean(signal_3);

% fetch time_delay:
[time21, rxy21] = time_delay(signal_2, signal_1, Fs);
[time31, rxy31] = time_delay(signal_3, signal_1, Fs);
[time32, rxy32] = time_delay(signal_3, signal_2, Fs);

% calculate angle of incidence:
teller=sqrt(3)*(time21+time31);
nevner=(time21-time31-2*time32);
if teller>0 && nevner<0
    angle_rad(i) = atan(teller/nevner)+pi;
elseif teller <0 && nevner<0
    angle_rad(i) = atan(teller/nevner)+pi;
elseif teller<0 && nevner>0
    angle_rad(i) = atan(teller/nevner)+2*pi;
else
    angle_rad(i) = atan(teller/nevner);
    
end
angle_deg(i) = (angle_rad(i) * 180)/pi;
fprintf("The angle of incidence is %.2f degrees.\n", angle_deg(i));

% write to table:
final_table(i,2) = angle_deg(i);
final_table(i,3) = final_table(i,1) - final_table(i,2);



% convert to complex:
y = teller;
x=nevner;

angle(i)=y*1i+x;

end

figure(1);
plot(l,r_xy);
% plot degrees:
figure(2);
compass(angle)





