function imageReconst = InvdiscreteWavletTrans(C, S, J, lpfCoeff)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to compute discrete wavelet transform at level J of an image using provided
% low pass filter coefficients
%
% Input
% I           -       input image
% J           -       Number of levels
%
% Input
% C           -       organized as a vector with
%                     A(J), H(J), V(J), D(J),
%                     H(J-1), V(J-1), D(J-1), ...,
%                     H(1), V(1), D(1),
%                     where A, H, V, and D are each a row vector.
%                     Each vector is the vector column-wise storage of a matrix.
%                     A contains the approximation coefficients
%                     H contains the horizontal detail coefficients
%                     V contains the vertical detail coefficients
%                     D contains the diagonal detail coefficients
%
% S          -        S(1,:) = size of approximation coefficients(J).
%                     S(i,:) = size of detail coefficients(J-i+2) for i = 2, ...J+1 and S(J+2,:) = size(I).
%
% J         -        levels of transform
%
% lpfCoeff    -       Low Pass Filter Coefficients
%
%
% Output
% imageReconst    -   Reconstructed image
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%calculate LPF and HPF coeff for reconstruction
lpfCoeff = fliplr(lpfCoeff);
for n=0:length(lpfCoeff)-1,
   hpfCoeff(n+1)=lpfCoeff(n+1)*(-1)^(n+1); % make odd terms negative
end;
hpfCoeff=hpfCoeff(length(hpfCoeff):-1:1); %flip the signal

for level = 1:J
    
    nEle = S(level,1) * S(level,2); %get number of elements i matrix to get from C
    if (level == 1)
        Atemp = C(1, 1:nEle); Atemp = reshape(Atemp, S(level,:));
    end
    Htemp = C(1, nEle+1:2*nEle); Htemp = reshape(Htemp, S(level, :));
    Vtemp = C(1, 2*nEle+1:3*nEle); Vtemp = reshape(Vtemp, S(level, :));
    Dtemp = C(1, 3*nEle+1:4*nEle); Dtemp = reshape(Dtemp, S(level, :));
    
%     if (level == 1)
%         Atemp = wc(1:S(level,1), 1:S(level,2));
%     end
%     Htemp = wc(1:S(level,1), S(level,2)+1 : 2*S(level,2));
%     Vtemp = wc(S(level,1)+1:2*S(level,1), 1:S(level,2));
%     Dtemp = wc(S(level,1)+1:2*S(level,1), S(level,2)+1:2*S(level,2));


    %% IWT FOR COLUMN
    
    
    %For LPF Terms
    ILpfDS = [Atemp Htemp];
%     ILpfDS = Irow(1:S(level,1), :);
    
    % apply upsampling
    ILpfUS = my_us2d(ILpfDS, 0);
    
    %apply LPF
    ILpfUSLpf = my_filter2d1(ILpfUS, lpfCoeff, 0);
    
    %For HPF terms
    IHpfDS = [Vtemp Dtemp];
%     IHpfDS = Irow(S(level,1)+1:end, :);
    
    % apply upsampling
    IHpfUS = my_us2d(IHpfDS, 0);
    
    %apply LPF
    IHpfUSHpf = my_filter2d1(IHpfUS, hpfCoeff, 0);
    
    Icol = (ILpfUSLpf + IHpfUSHpf);
    
    
    %% IWT FOR ROWS
    
    %For LPF Terms
    ILpfDS = Icol(:, 1:S(level,2));
    
    % apply upsampling
    ILpfUS = my_us2d(ILpfDS, 1);
    
    %apply LPF
    ILpfUSLpf = my_filter2d1(ILpfUS, lpfCoeff, 1);
    
    %For HPF terms
    IHpfDS = Icol(:, S(level,2)+1:2*S(level,2));
    
    % apply upsampling
    IHpfUS = my_us2d(IHpfDS, 1);
    
    %apply LPF
    IHpfUSHpf = my_filter2d1(IHpfUS, hpfCoeff, 1);
    
    imageReconst = (ILpfUSLpf + IHpfUSHpf);
    
    %use reconstructeed result for next iteration
    Atemp = imageReconst;
    
    
end