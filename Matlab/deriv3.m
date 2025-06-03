% deriv3.m
% La funzione permette di calcolare la derivata di un vettore rispetto ad un altro

% INPUT:
% v: vettore da derivare
% t: vettore rispetto al quale calcolare la derivata

% OUTPUT:
% dv: derivata del vettore

function dy = deriv3(y,t)
    N=length(t);
    dy=zeros(N,1);

    for k = 2:length(y)-1
        dy(k) = (y(k+1) - y(k-1)) / (t(k+1) - t(k-1));
    end
 
    dy(1) = (y(2) - y(1)) / (t(2) - t(1));      %primo elemento con forward-Euler
    dy(N) = (y(N) - y(N-1)) / (t(N)-t(N-1));    %ultimo elemento con backward-Euler
end