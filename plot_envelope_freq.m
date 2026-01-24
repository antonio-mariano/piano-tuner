% Calcula a frequência da envolvente, e faz um plot resumindo a análise
function env_freq = plot_envelope_freq(x,Fs,f)

    env_freq_max = 0.02*f; % em cents, seria log2(1.02) * 1200 = 34.3 cents
    xf = filtro_narrowband(x, Fs, f, 10+0.02*f);
    t = (0:length(xf)-1)' / Fs;
% 	figure; spectrum(xf,Fs, 2*f); grid;
    
    % Envelope RMS
    window = round(2*Fs/env_freq_max); % 2 * 'período mínimo do envelope que esperamos encontrar'
    [env,~] = envelope(xf,window,'rms');
    % %figure, spectrum(env,Fs,6e3); grid; % espectro da envolvente é useless, fica aqui para dizer isso
% 	figure; plot(t, xf); grid; hold on; plot(t, env);

    % LPF MM do envelope
    env = 1.5 * filtro_mm(env,Fs,env_freq_max);
    % plot(t, env);
    
    % avança até encontrar a subida rápida, correspondente ao 'início da nota' = i
    Denv = diff(env);
    [~,I] = sort(Denv,'descend');
    for i = 1:length(env)
        if Denv(i) > 0.5*Denv(I(1)), break, end
    end
    
    % Identifica a zona de interesse, desde o início do som até ficar fraco
    M = 0.03*max(env) + 0.1*mean(abs(env));
    % avança até encontrar o 'fim da nota' = j
    for j = i:length(env)
        if env(j) < M, break, end
    end
    
    env(1:i) = 0; % anula a parte antes da nota começar
    xf = xf(1:j); env = env(1:j); t = t(1:j); % corta apenas até onde a nota fica fraca

    plot(t, xf); grid; hold on;
    plot(t, env);
    xlabel('Tempo [s]');

    % Análise do envelope
    [~,locs] = findpeaks(env); % máximos do envelope
    D = diff(locs); % distância entre máximos consecutivos
    if length(D) <= 0
        env_freq = -1;
        return
    end
    
    % Calcula a lfo = 1 / 'período do envelope'
    [mean_T, ~] = reliable_mean(D/Fs); % a estimativa do período é a média das distâncias entre máximos
    env_freq = 1 / mean_T;
    
    % Finaliza o gráfico
    scatter(locs/Fs, env(locs));
    legend('Sinal','Envolvente','Picos(env)')
	str = sprintf('\n\n\n        Frequência da envolvente\n        = %.2f Hz\n        = %.1f cents',...
    env_freq, (1200/log(2))*(env_freq/f));
    xl = xlim(); text(xl(1), max(xf), str);
end