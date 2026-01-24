
% Calcula as frequências dos harmónicos presentes em x, sendo robusto a
% múltiplos picos próximos (causados por várias cordas vibrando a freqs  próximas)

function h = harmonics(x,Fs)
    N = size(x,1);
    df = Fs/N;
    f = 0:df:Fs-df;

    X = abs(fft(x));
    
    % Corta até aos 6000 Hz
    T = round(N*6000/Fs);
    X = X(1:T);
    f = f(1:T); 
	% figure; plot(f,X); hold on; grid

    % Faz LPF com fcorte progressivamente menor (window progresivamente maior)
    % Até que os únicos picos correspondem efectivamente às harmónicas
    thresh_prev = 2;
    for i = 1:20
        % figure; plot(f,X); grid
        Y = movmean(X,i^2*Fs/200); 

        [~,locs] = findpeaks(Y);
        D = diff(locs);
        s = std(D);
        m = mean(D);
        thresh = s/m;

        if thresh < 0.2 || thresh > 2*thresh_prev
            break
        end
        
        thresh_prev = thresh;
        X = Y;
    end
    
    % plot(f,X);
    h = (locs-1)*df; %converte para Hz
    
    % Usar o maximo divisor comum, se quiser realmente um bom f0
    % f0 = mean(D)*df
    
end