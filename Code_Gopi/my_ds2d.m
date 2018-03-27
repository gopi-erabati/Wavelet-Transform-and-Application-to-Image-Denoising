function imgDS = my_ds2d(I, R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to downsample a image row or column wise
% 
% Input
% I       -       Input image
% R       -       Row - (1)
%                 Column  - (0)
%                 
% Output
% imgDS  -       Image downsampled
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get size of image
[m,n] = size(I);

%for columnm wise
if (R == 1)
    imgDS = zeros(m,n/2);
    for nRow = 1:m
        Itemp = I(nRow, :);
        imgDS(nRow, :) = Itemp(1:2:n);
    end
    
%for row wise
elseif (R == 0)
    imgDS = zeros(m/2,n);
    for nCol = 1:n
        Itemp = I(:, nCol);
        imgDS(:, nCol) = Itemp(1:2:m);
    end
    
end