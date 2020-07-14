% Number-Theory Implementation (Matlab Code)

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

% fh -> higher freq, fl -> lower freq;
% mh, ml are co-primes satisfying: fh/fl = mh/ml
% taking ml as irrational theoretically removes any limits on kl
mh = 20, ml = 3*sqrt(2);
fh = 0.1*mh, fl = 0.1*ml; 

% Making the Look-Up-Table 'A'
% Add 100000 to keep indices of 'A' positive
for kh = -floor(mh/2):floor(mh/2)
    for kl = -floor(mh/2):floor(mh/2)
        A(round(kh*ml-kl*mh)+100000) = kh;
    end
end

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

% Extracting Kh from LUT and Unwrapping
kh = A(round((mh*phi-ml*phih)/(2*pi))+100000);
phih = phih+kh*(2*pi);
phih = phih/fh;

figure; mesh(kh); title('Kh');
figure; mesh(phih); title('Unwrapped Reconstruction');