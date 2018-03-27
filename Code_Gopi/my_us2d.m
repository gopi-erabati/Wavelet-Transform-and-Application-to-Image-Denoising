function imgUS = my_us2d(I, R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to upsample a image row or column wise
% 
% Input
% I       -       Input image
% R       -       Row - (1)
%                 Column  - (0)
%                 
% Output
% imgDS  -       Image upsampled
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get size of image
[m,n] = size(I);

%for column wise
if (R == 1)
    imgUS = zeros(m,n*2);
    for nRow = 1:m
        Itemp = I(nRow, :);
        imgUS(nRow, 1:2:size(imgUS,2))=Itemp;
    end
    
%for row wise
elseif (R == 0)
    imgUS = zeros(m*2,n);
    for nCol = 1:n
        Itemp = I(:, nCol);
        imgUS(1:2:size(imgUS, 1), nCol) = Itemp;
    end
    
end