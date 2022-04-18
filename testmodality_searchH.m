function h0 = testmodality_searchH(x,N0,varargin)
options=struct(...
    'precision',1e-6,...
    'maxiter',100,...
    'disp',false);
if numel(varargin)>0, for n=2:2:numel(varargin), assert(isfield(options,varargin{n-1}),'unrecognized option %s',varargin{n-1}); options.(varargin{n-1})=varargin{n}; end; end

M=numel(x);
assert(N0>=1&N0<M,'N must be greater or equal to 1 and snmaller than the number of samples');
minx=min(x);
maxx=max(x);
prec=(maxx-minx)*options.precision;

H2=maxx-minx;
N2=testmodality_countmodes(x,H2);
while N2>N0, H2=H2*2; N2=testmodality_countmodes(x,H2); end
H1=0;
N1=M;

% H1 ---> N1 (N+1)
% H2 ---> N2 (N)
for niter=1:options.maxiter
    H = (H1+H2)/2;
    N = testmodality_countmodes(x,H);
    if N>=N0+1, H1 = H; N1 = N;
    else H2 = H; N2 = N;
    end
    if H2-H1<prec, break; end
    if options.disp, disp([H1 H2]); end
end
h0 = (H1+H2)/2;


