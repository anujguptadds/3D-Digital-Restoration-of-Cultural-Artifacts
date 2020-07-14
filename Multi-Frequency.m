% Multi-Frequency Implementation (MATLAB Code)

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
c = zeros(N,N);
for row = 200:300
    for col = 200:300
        c(row,col) = 10;
    end
end

% c as peaks:
%c = zeros(N,N); c = peaks(N); c = c/10;
figure; mesh(c); title('Original Shape');

% fh -> higher freq, fl -> lower freq
fh = 24, fl = 0.1;

% cp-> carrier-phase of unit frequency
cp = (2*pi)*(X./N);

% Distorted fringe distributions, Low freq (total 3 distributions)
A0 = cos(fl*(cp+c));
A1 = cos(fl*(cp+c)-2*pi/3);
A2 = cos(fl*(cp+c)-4*pi/3);

% Extracting (wrapped) phase map for low freq
phi = atan2((sqrt(3)*(A1-A2)),(2*A0-A1-A2));

% Non-Distorted fringe distributions, Low freq
A0r = cos(fl*cp);
A1r = cos(fl*cp-2*pi/3);
A2r = cos(fl*cp-4*pi/3);

% Extracting reference (wrapped) phase map for low freq
phir = atan2((sqrt(3)*(A1r-A2r)),(2*A0r-A1r-A2r));

% Distorted fringe distributions, High freq (total 3 distributions)
A0h = cos(fh*(cp+c));
A1h = cos(fh*(cp+c)-2*pi/3);
A2h = cos(fh*(cp+c)-4*pi/3);

% Extracting (wrapped) phase map for high freq
phih = atan2((sqrt(3)*(A1h-A2h)),(2*A0h-A1h-A2h));

% Non-Distorted fringe distributions, High freq
A0hr = cos(fh*cp);
A1hr = cos(fh*cp-2*pi/3);
A2hr = cos(fh*cp-4*pi/3);

% Extracting reference (wrapped) phase map for high freq
phihr = atan2((sqrt(3)*(A1hr-A2hr)),(2*A0hr-A1hr-A2hr));

% Removing the references
phi = phi-phir; phih = phih-phihr; 
figure; mesh(phih/fh); title('Wrapped Reconstruction');

% Evaluating Kh and Unwrapping
kh = round(((fh/fl)*phi-phih)/(2*pi));
phih = phih+kh*(2*pi);
phih = phih/fh;

figure; mesh(kh); title('Kh');
figure; mesh(phih); title('Unwrapped Reconstruction');