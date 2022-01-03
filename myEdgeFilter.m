function [img1] = myEdgeFilter(img0, sigma)
    
    gaussian = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
    smoothed = myImageFilter(img0, gaussian); % generate smoothed image with gaussian filter
    
    xs = fspecial('sobel');
    imgx = myImageFilter(smoothed, xs); % x derivative sobel 
    
    ys = xs';
    imgy = myImageFilter(smoothed, ys); % y derivative sobel
    
    img1 = sqrt(imgx.^2 + imgy.^2);
    [m, n] = size(img1);
    img = img1;  % image copy
    
    img1tan = atan2(imgx, imgy) * (180/pi); % radians to degrees
    
    for x = 1:m
        for y = 1:n
            if img1tan(x, y) < 0
                img1tan(x, y) = img1tan(x, y) + 180; % negative values become positive
            end
        end
    end
    
    % non-maximum suppression
    
    for i = 2:m-1
        for j = 2:n-1
            if img1tan(i,j) < 22.5 || img1tan(i,j) > 157.5
                img1tan(i,j) = 0;
                if img1(i, j+1) > img1(i,j) || img1(i, j-1) > img1(i,j)
                    img(i,j) = 0;
                end
            elseif (img1tan(i,j) >= 22.5 && img1tan(i,j) < 67.5)
                img1tan(i,j) = 45;
                if img1(i-1, j+1) > img1(i,j) || img1(i+1, j-1) > img1(i,j)
                    img(i,j) = 0;
                end
            elseif (img1tan(i,j) >= 67.5 && img1tan(i,j) < 112.5)
                img1tan(i,j) = 90;
                if img1(i-1, j) > img1(i,j) || img1(i+1, j) > img1(i,j)
                    img(i,j) = 0;
                end
            elseif (img1tan(i,j) >= 112.5 && img1tan(i,j) <= 157.5)
                img1tan(i,j) = 135;
                if img1(i-1, j-1) > img1(i,j) || img1(i+1, j+1) > img1(i,j)
                    img(i,j) = 0;
                end
            end
        end
    end
    
    img1 = img;

end
    
                
        
        
