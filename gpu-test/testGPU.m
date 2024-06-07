% do matrix mutlply
function [theTime,mmGFlopsGPU] = testGPU(mSize)
% tic;
% x = rand(mSize);
% y = rand(mSize);
% z=svd(x*y);
% theTime =  toc;

% tic;
% x = rand(mSize,'gpuArray');
% y = rand(mSize,'gpuArray');
% z=svd(x*y);


gpu = gpuDevice();
fprintf('Using an %s GPU.\n', gpu.Name)
sizes = power(2, mSize);
N = sqrt(sizes);
% First do it on the host
A = rand( N, N );
B = rand( N, N );
% theTime = timeit(@() A*B);
% Now on the GPU
A = gpuArray(A);
B = gpuArray(B);
theTime = gputimeit(@() A*B);
mmGFlopsGPU = (2*N.^3 - N.^2)./theTime/1e9;
fprintf(['Achieved peak calculation rates of ', ...
    '%1.1f GFLOPS\n'], mmGFlopsGPU)