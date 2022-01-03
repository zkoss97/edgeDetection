function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)

    [x, y] = size(Im);
    longestDist = floor(sqrt(x^2 + y^2));
    
    rhoScale = ceil(-longestDist):rhoRes:ceil(longestDist);
    
    thetaRes = thetaRes * (180/pi); % convert to degrees
    thetaScale = -90:thetaRes:90;
    
    H = zeros(numel(rhoScale), numel(thetaScale)); % initialize accumulator to max size of rho and theta respectively
    
    for i = 1:x
        for j = 1:y
            if Im(i,j) > threshold
                for theta = thetaScale
                    rho = j*cosd(theta) + i*sind(theta);
                    rho = floor((rho+longestDist)/rhoRes) + 1;
                    t = floor((theta+90)/thetaRes) + 1;
                    H(rho, t) = H(rho, t) + 1; % add votes
                end
            end
        end
    end
    
    thetaScale = thetaScale * (180/pi); % convert to radians

end
        
        