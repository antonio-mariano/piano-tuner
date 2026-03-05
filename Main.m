clc; close all

%% Read Audio
[x,Fs] = audioread('dataset/A4.ogg');
x = mean(x,2); % Stereo para mono

% Forçar o sinal a ter 10s para que a resolução na freq seja exatamente 0.1 Hz
if length(x) > 10*Fs
    x = x(1:10*Fs);
else
    x = padarray(x,10*Fs-length(x),'post');
end

% Downsample
n = 4;
x = lowpass(x, 0.5*Fs/n, Fs, 'ImpulseResponse','iir'); % Anti aliasing; iir = faster
x = downsample(x, n);
Fs = Fs/n;
% figure, spectrum(x,Fs,6e3), grid;

%% Analisa os harmónicos

h = harmonics(x,Fs); % Frequências dos harmónicos
num_h = 3;  % Analisa os 3 primeiros harmónicos

for i=1:num_h
    f = h(i);
    
    % Plot Frequência da envolvente
    subplot(num_h,2,2*i-1)
    env_freq = plot_envelope_freq(x,Fs,f);

    % Plot Diferença de frequências
    subplot(num_h,2,2*i)
    diff = plot_difference_freq(x,Fs,f);
    
    annotation('textbox',[0 0.82-(i-1)*0.3 0.15 0.01], 'String',sprintf('Harmonic %d', i),...
        'EdgeColor','none','HorizontalAlignment','center', 'FontSize',12);
end


set(gcf, 'Position', get(0, 'Screensize')); %Coloca o plot em full screen



