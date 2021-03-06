clear, close all

% Domain parameters
I = 50;                                 % Number of cells in x-axis
J = 50;                                 % Number of cells in y-axis

% DATA struct
data.dx     = 5e-3;                     % Cell size in x-axis [m]
data.dy     = 5e-3;                     % Cell size in y-axis [m]
data.epsr   = ones(I,J);                % Relative permittivity data
data.sig    = zeros(size(data.epsr));   % Conductivity data [S/m]
data.epsrb  = 1;                        % Background relative permittivity
data.sigb   = 0;                        % Background conductivity [S/m]

% PAR struct
par.f       = 800e6;                    % Linear frequency of measurements [Hz]
par.nts     = 2^12;                     % Number of FDTD time steps
par.nsps    = 7;                        % Number of sources per side
data.lambda = 1/par.f/sqrt(4e-7*pi*...  % Wavelength [m]
    data.epsrb*8.854187817e-12);
data.kb     = 2*pi*par.f*sqrt(4e-7*...  % Wavenumber of background [1/m]
    pi*data.epsrb*8.854187817e-12);
data.f      = par.f;
data.I      = I;
data.J      = J;

% Incident field matrix
ei          = zeros(I,J,par.nsps*4);

% Grid variables
x = cell(4*par.nsps,1);
y = cell(4*par.nsps,1);

% Auxiliar parameter variable
aux_par = cell(4*par.nsps,1);
aux_par(:) = {par};

s_indx = 20;
aux_par{s_indx}.s_indx = s_indx;
[ei(:,:,s_indx),x{s_indx},y{s_indx}] = fdtd2d(data,aux_par{s_indx});

