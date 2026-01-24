% Calcula a diferença de frequências entre os dois picos mais afastados na vizinhança de f,
% e faz um plot resumindo a análise
function diff = plot_difference_freq(x,Fs,f)

    % FFT
    xf = filtro_narrowband(x, Fs, f, 25); % Passa apenas uma vizinhança de f
    % Nota: o filtro é necessário porque a região em torno de f só é
    % cortada para fazer o gráfico. Cortá-la para a análise complica um pouco
    N = size(xf,1);
    df = Fs/N;
    f_axis = 0:df:Fs-df;
    X = abs(fft(xf));
    X = X(1:round(N/2)); % Seleciona apenas o espectro positivo
    f_axis = f_axis(1:round(N/2));
     
    % Picos do espectro ordenados por ordem decrescente
    [~,locs] = findpeaks(movmean(X,3));
    [~,I] = sort(X(locs), 'descend'); 
    I = I(1:min(3,length(I))); % 3 maiores picos apenas
    f_peaks = (locs(I)-1)*df; % Passa de loc para Hz; f_peaks(1) = freq do maior pico
    
    % Ordena os maiores picos por ordem crescente de frequência
    [~, J] = sort(f_peaks, 'ascend');
    f_min = f_peaks(J(1)); % f_min e f_max = menor e maior frequência de entre os picos vistos
    f_max = f_peaks(J(end));
    
    % diff = f_peaks(1)-f_peaks(2); % diferença de frequencia dos dois maiores picos
    diff = f_max - f_min; % diferença entre os picos de maior e menor frequência 
    
    % Plot
    % Seleciona apenas a região de f_peaks(1) +- k [Hz] para fazer o plot
    k = 0.02*f;
    Fi = round((f_peaks(1)-k)/df + 1);
    Ff = round((f_peaks(1)+k)/df + 1);

    % Plot
    plot(f_axis(Fi:Ff), X(Fi:Ff)), grid, hold on;
    loc_min = round(f_min/df+1);
    loc_max = round(f_max/df+1);
    scatter([f_min f_max], [X(loc_min) X(loc_max)]);
    plot([f_min f_max],[X(loc_min) X(loc_max)],'--');
    xlabel('Frequência [Hz]'); legend('abs(FFT)','max2(FFT)')
    
    str = sprintf('\n        Diferença de picos\n        = %.2f Hz\n        = %.1f cents',...
    diff, (1200/log(2))*(diff/f));
    xlim([f_peaks(1)-k f_peaks(1)+k]); text(f_peaks(1)-k, 0.9*max(X), str);
end





