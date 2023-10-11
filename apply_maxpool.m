% Yige Li, Haoyu Li, Yichen Shi, Runqi Yang


function outarray = apply_maxpool(inarray)
    [N, M, D] = size(inarray);
    outarray = zeros(floor(N/2), floor(M/2), D);

    for k = 1:D
        for i = 1:2:N-1   
            for j = 1:2:M-1 
                outarray((i+1)/2, (j+1)/2, k) = max(max(inarray(i:i+1, ...
                    j:j+1, k)));
            end
        end
    end
end


