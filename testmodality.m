function [p,H] = testmodality(X,N,varargin)
% TESTMODALITY 
% Silverman 1981 "Using kernel desity estimates to investigate multimodality"
% Smoothed bootstrap statistics
%
%   [p,H] = TESTMODALITY(X,N) Tests whether the distribution where the sample X is drawn from has more than N modes
%   X   : [M,1] M samples from same distribution
%   N   : number of modes of null hypothesis (default 1)
%   p   : tests null hypothesis that distribution has at most N modes
%   H   : true if p<.05 (reject null hypothesis)
%
% TESTMODALITY(...,'niter',n)       runs n bootstrap replications (default n=1000)
% TESTMODALITY(...,'disp',false)    skips status display messages
% 
% e.g. test whether distribution is unimodal
% p = testmodality([randn(1,20), 3+randn(1,20)],1); 

options=struct(...
    'disp',true,...
    'niter',1e3);
if numel(varargin)>0, for n=2:2:numel(varargin), assert(isfield(options,varargin{n-1}),'unrecognized option %s',varargin{n-1}); options.(varargin{n-1})=varargin{n}; end; end
    
M = numel(X);
s0 = var(X);
h0 = testmodality_searchH(X,N);
if options.disp, fprintf('Test critical width = %f\n',h0); end
Ndist = nan(options.niter,1);
nseed=rand('seed');
for niter=1:options.niter
    idx = ceil(M*rand(M,1));
    x = (reshape(X(idx),[],1) + h0*randn(M,1)) / sqrt(1+h0^2/s0);
    Ndist(niter) = testmodality_countmodes(x,h0);
    if options.disp, fprintf('iter %d/%d : p = %.4f\n',niter,options.niter,mean(Ndist(1:niter)>N)); end
end
rand('seed',nseed);
p = mean(Ndist>N);
H = p<.05;
    
end


