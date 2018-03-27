function imgFilt = my_filter2d1(I, h, R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to apply LPF or HPF on every row or colum of the image
%
% Input
% I       -       Input image
% h       -       Filter coeffcients
% R       -       Row - (1)
%                 Column  - (0)
%
% Output
% imgLpf  -       Image with low frequency components or high frequency
%                 components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get size of image
[m,n] = size(I);
imgFilt = zeros(m,n);

%for Row wise
if (R == 1)
    
    for nRow = 1:m
        %circular convolution 
        imgFilt(nRow, :) = fliplr(cconv(fliplr(I(nRow,:)), fliplr(h), n));
        
    end
    
    %for Column wise
elseif (R == 0)
    
    for nCol = 1:n
                %circular convolution 
        imgFilt(:, nCol) = fliplr(cconv(fliplr(I(:,nCol)'), fliplr(h), m));
        
    end
    
    
end