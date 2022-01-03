function [img1] = myImageFilter(img0, h)

    [x, y] = size(img0); % image size
    img1 = zeros(x, y); % new image is same size
    
    [u, v] = size(h); % filter size
    padding_hor = (u-1)/2; % padding is half the value
    padding_ver = (v-1)/2;

    padded = padarray(img0, [padding_hor, padding_ver], 'replicate', 'both');
    [padded_x, padded_y] = size(padded);
    
    h = flipud(h); % perform flips to get convolution filter
    h = fliplr(h);
    [hx, hy] = size(h);
    
    for i = 1+padding_hor:padded_x-padding_hor % iterate through image and give space for filter
        for j = 1+padding_ver:padded_y-padding_ver
            
            sum = 0;
            
            for k = 1:hx % iterate through filter
                for l = 1:hy
                    sum = sum + (h(k,l) * padded(i+k-1-padding_hor,j+l-1-padding_ver));
                end
            end
            
            img1(i-padding_hor,j-padding_ver) = sum;
        end
    end

end
