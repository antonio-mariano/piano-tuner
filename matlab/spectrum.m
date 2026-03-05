
% Faz um plot do módulo do espectro de x(t), de 0 a Fmax
% Usar figure e grid antes e depois de chamar spectrum()

function spectrum(x,Fs,Fmax)
    N = size(x,1);
    df = Fs/N;
    f = 0:df:Fs-df;

    X = abs(fft(x));

	% Seleciona apenas uma região do espectro
    T = round(N*Fmax/Fs);
    X = X(1:T);
    f = f(1:T);

    plot(f,X)
    xlabel('Frequência [Hz]');
end




