load('muab.mat');


red_wavelength =600; %%INSERT_RED_WAVELENGTH (unit nm)
green_wavelength = 515;%%INSERT_GREEN_WAVELENGTH (unit nm)
blue_wavelength = 460;%%INSERT_BLUE_WAVELENGTH (unit nm)

wavelengths = [red_wavelength, green_wavelength, blue_wavelength];


mua_blood_oxy = @(x) interp1(muabo(:,1), muabo(:,2), x);
mua_blood_deoxy = @(x) interp1(muabd(:,1), muabd(:,2), x);


bvf = 0.01; %blood volume fraction, average amount of blood in the tissue
oxy = 0.8; %oxygenation of the blood

%absorption coefficient (mu_a in lab text)
%units: m^(-1)
mua_other = 25; %background absorption due to collagen etc
mua_blood = mua_blood_oxy(wavelengths)*oxy + mua_blood_deoxy(wavelengths)*(1-oxy); %absorption due to pure blood
mua = mua_blood*bvf + mua_other;

%reduced scattering coefficient (mu_s' in lab text)
%the magic numbers are from N. Bashkatov, E. A. Genina, V. V. Tuchin.
%Optical properties of skin, subcutaneous and muscle tissues: A review. J.
%Inoov.  Opt. Health Sci., 4(1):9-38, 2011
%units: m^(-1)
musr = (17.6*(wavelengths/500.0).^(-4) + 18.78*(wavelengths/500).^(-0.22))*100;

%mua and musr are now available as three-valued arrays, each index corresponding to: red, green and blue channels.


%%INSERT CODE FOR CALCULATING PENETRATION DEPTH DEL:
%
d=0.013;
color={'Red','Green','Blue'};
for i=1:length(mua)
    p_depth(i)=sqrt(1/(3*(mua(i)+musr(i))*mua(i)));
    fprintf('\nPenetration depth of color %s is: %f',color{i} ,p_depth(i))
    %Transmitansen:
    transmitans(i)=exp(-sqrt(3*(mua(i)+musr(i))*mua(i))*d);
    fprintf('\nTransmitation of color %s is: %f',color{i} ,transmitans(i));
end

%ved blodåre på 300mu meter diameter:
d_vein=300e-6;
bvf_vein=1;
mua_vein=mua_blood*bvf_vein+mua_other;
% ny penetrasjonsdypde og transmissjon:
fprintf('\n\nFinding new Transmitation and penetraion through the vain:');
for i=1:length(mua_vein)
    p_depth_vein(i)=sqrt(1/(3*(mua_vein(i)+musr(i))*mua_vein(i)));
    fprintf('\nPenetration depth of color %s is: %e',color{i} ,p_depth_vein(i))
    %Transmitansen:
    transmitans_vein(i)=exp(-sqrt(3*(mua_vein(i)+musr(i))*mua_vein(i))*d_vein);
    fprintf('\nTransmitation of color %s is: %e',color{i} ,transmitans_vein(i));
    diff(i)=abs(transmitans_vein(i)-transmitans(i)/transmitans(i));
    fprintf('\nThe contrast between vein and no vain of color %s is: %f',color{i} ,diff(i));
end
