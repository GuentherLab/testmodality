function [P,X] = testmodality_hist(x,h,varargin)

options=struct(...
    'scale',1,...
    'nsamples',1e6);
if numel(varargin)>0, for n=2:2:numel(varargin), assert(isfield(options,varargin{n-1}),'unrecognized option %s',varargin{n-1}); options.(varargin{n-1})=varargin{n}; end; end

minx=min(x);
maxx=max(x);
if nargin<2||isempty(h), h=(maxx-minx)/sqrt(numel(x)); end
X=linspace(minx-3*h,maxx+3*h,options.nsamples);
P=0;
k=sqrt(2*pi)*h*numel(x);
for n=1:numel(x), P=P+exp(-(X-x(n)).^2/h^2/2)/k; end
if ~nargout
    P = plot(X,options.scale*P,'.-');
end

