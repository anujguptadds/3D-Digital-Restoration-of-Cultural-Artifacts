% High-Speed Profilometry (Matlab Code)

% We have reconstructed two shapes here, the first one is a 
% cuboid, and the second one is the peaks function.
% To see the reconstruction of the cuboid, keep the 
% line: 30 commented
% To see the reconstruction of the peaks, uncomment it.

clc;
clear all;
close all;

M = 512;
N = 512;

x = 1:N;
y = 1:M;
[X,Y] = meshgrid(x,y);

% Defining object shape 'c'
% c as a cuboid:
c = zeros(N,M);
for row = 200:300
    for col = 200:300
        c(row,col) = 10;
    end
end

% c as peaks:
%c = zeros(N,N); c = peaks(N); c = c/10;
figure; mesh(c); title('Original Shape');

% A -> average intensity, B-> intensity modulation, F -> frequency
A = zeros(N,M)+127.5; B = zeros(N,M)+127.5; F = 10;

% Intensities of the four designed fringe patterns
I1 = A + B.*sin(pi*F*(2*x/M - 1));
I2 = A + B.*cos(pi*F*(2*x/M - 1));
I3 = A + B.*(2*x/M - 1);
I4 = A - B.*(2*x/M - 1);

% wrapped phase (reference)
phir = atan2(2*I1-I3-I4, 2*I2-I3-I4);

% a -> reflectivity or albedo of the reference
a = sqrt((2*I1-I3-I4).*(2*I1-I3-I4)+(2*I2-I3-I4).*(2*I2-I3-I4))./(2*B);

% Base reference phase
phibr = (I3 - I4)./(2*(a.*B));

% Unwrapped reference phase
phihr = phir + 2*pi*round((pi*F*phibr - phir)/(2*pi));

% Distorted intensities
I1 = A + B.*sin(pi*F*(2*x/M - 1 + c));
I2 = A + B.*cos(pi*F*(2*x/M - 1 + c));
I3 = A + B.*(2*x/M - 1 + c);
I4 = A - B.*(2*x/M - 1 + c);

% wrapped phase 
phi = atan2(2*I1-I3-I4, 2*I2-I3-I4);
figure; mesh((phi-phir)/(pi*F)); title('Wrapped phase Reconstruction');

% a -> reflectivity or albedo of the scanned object
a = sqrt((2*I1-I3-I4).*(2*I1-I3-I4)+(2*I2-I3-I4).*(2*I2-I3-I4))./(2*B);

% Base phase
phib = (I3 - I4)./(2*(a.*B));
figure; mesh((phib-phibr)/(pi*F)); title('Base phase Reconstruction');

% Unwrapped phase
phih = phi + 2*pi*round((pi*F*phib - phi)/(2*pi));

figure; mesh((phih-phihr)/(pi*F)); title('Unwrapped Reconstruction');