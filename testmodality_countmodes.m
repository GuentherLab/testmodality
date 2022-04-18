function N = testmodality_countmodes(x,h,varargin)

options=struct(...
    'nsamples',1e6);
if numel(varargin)>0, for n=2:2:numel(varargin), assert(isfield(options,varargin{n-1}),'unrecognized option %s',varargin{n-1}); options.(varargin{n-1})=varargin{n}; end; end

minx=min(x);
maxx=max(x);
X=linspace(minx,maxx,options.nsamples);
for nh=1:numel(h)
    if h(nh)==0, N(nh)=numel(unique(x)); 
    else
        p=0;
        k=sqrt(2*pi)*h(nh)*numel(x);
        for n=1:numel(x), p=p+exp(-(X-x(n)).^2/h(nh)^2/2)/k; end
        p([false p(2:end)==p(1:end-1)])=[];
        N(nh)=nnz(p>[0 p(1:end-1)] & p>[p(2:end) 0]);
    end
end
end

