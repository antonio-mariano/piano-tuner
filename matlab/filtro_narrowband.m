
% Filtro passa banda em torno de fc = freq central da passband
% delta = banda de transição = 0.5 banda de passagem

function xf = filtro_narrowband(x,Fs,fc,delta)

    Hd = designfilt('bandpassiir', ...
        'StopbandFrequency1',fc - 2*delta,'PassbandFrequency1',fc - delta, ...
        'PassbandFrequency2',fc + delta ,'StopbandFrequency2',fc + 2*delta , ...
        'StopbandAttenuation1',20,'PassbandRipple',3, ...
        'StopbandAttenuation2',20,'DesignMethod','butter','SampleRate',Fs);

%     fprintf('The order of the filter is %d\n',filtord(Hd))
    xf = filter(Hd,x);
end

