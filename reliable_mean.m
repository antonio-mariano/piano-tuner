
% calcula a média de D, excluindo os outliars
% Semelhante a ransac, mas como D é pequeno (e n=1) testa todas as possibilidades

function [m,nb] = reliable_mean(D)
    D = sort(D);
    
    % Thresholds
    e1 = 0.1 * std(D);
    e2 = 0.01 * mean(D);
    e = e1 + e2;
     
    N = length(D);
    count = zeros(N,1);
    
    % Conta quantos vizinhos cada ponto tem
    for i = 1:N     
       d = D(i);
       for k = 1:N
           if abs(D(k) - d) < e
               count(i) = count(i)+1;
           end
       end 
    end
    
    [~,I] = sort(count, 'descend');
    max_neighbors = I(1); % ponto com mais vizinhos
    d = D(max_neighbors); % d = valor do ponto com mais vizinhos
    
    % calcula a média dos pontos 'próximos' a d
    v = 0; c = 0; nb = [];
    for k = 1:N
       if abs(D(k) - d) < e
           nb = [nb; D(k)]; %vizinhos do ponto com mais vizinhos
           v = v + D(k);
           c = c+1;
       end
    end 

   m = v/c; % retorna a média
end

%%%% Outros algoritmos desenvolvidos antes de ser baseado em 'ransac'

% Baseado em derivar D novamente e encontrar a região entre as duas maiores subidas
%     D = sort(D,'ascend');
%     D2 = diff(D);
%     figure; plot(D2);
%     
%     [pks,locs] = findpeaks(D2);
%     [B,I] = sort(pks);
%     ...

% Baseado em ir removendo do inic valores maixos e do fim valroes altos
% O problema é quando o nº de valores baixos é diferente do nº de valroes altos
%     k = 1;
%     while k == 1 %TODO: atençao tambem a possiveis valroes grandes
%         k = 0;
%         if D(1) < 0.8*mean(D)
%             D = D(2:end);
%             k = 1;
%         end
%         if D(end) > 1.2*mean(D)
%             D = D(1:end-1);
%             k = 1;
%         end
%     end


