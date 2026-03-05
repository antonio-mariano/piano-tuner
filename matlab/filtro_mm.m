
% LPF usando movmean. f = freq de corte
function x = filtro_mm(x,Fs,f)
    x = movmean(x, Fs/f);
    x = movmean(x, Fs/f);
end

