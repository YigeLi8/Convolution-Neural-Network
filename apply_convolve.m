% Yige Li, Haoyu Li, Yichen Shi, Runqi Yang


function outarray = apply_convolve(inarray, filterbank, biasvals)
    [N, M, D1] = size(inarray);
    D2 = size(filterbank, 4);
    outarray = zeros(N, M, D2);
    
    for i = 1:D2
        convolved = zeros(N, M);
        for j = 1:D1
            filter = filterbank(:,:,j,i);
            convolved = convolved + conv2(inarray(:,:,j), filter, 'same');
        end
        outarray(:,:,i) = convolved + biasvals(i);
    end
end
