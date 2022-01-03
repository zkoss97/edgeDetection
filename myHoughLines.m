function [rhos, thetas] = myHoughLines(H, nLines)

    rhos = zeros(nLines, 1); % size of rhos as given in PDF
    thetas = zeros(nLines, 1); % size of thetas as given in PDF
    
    H_padded = padarray(H, [1,1], 'replicate', 'both'); % pad H for NMS
    H_copy = H; % copy H for NMS
    [x, y] = size(H_copy);
    
    % non-maximal suppression
    
    for i = 2:x-1
        for j = 2:y-1
            if (H_padded(i-1, j-1) > H_padded(i, j)) || (H_padded(i, j-1) > H_padded(i, j)) || (H_padded(i+1, j-1) > H_padded(i, j)) || (H_padded(i-1, j) > H_padded(i, j)) || (H_padded(i-1, j+1) > H_padded(i, j)) || (H_padded(i, j+1) > H_padded(i, j))
                H_copy(i, j) = 0; % pixel is not local maxima
            end
        end
    end
    
    for i = 1:nLines
        max_score = max(H_copy(:)); % flatten H and get max score
        [rhoMax, thetaMax] = find(H_copy==max_score); % get rho and theta
        rhos(i) = rhoMax(1);
        thetas(i) = thetaMax(1);
        H_copy(rhoMax(1), thetaMax(1)) = 0; % get rid of that score
    end
    
end
        