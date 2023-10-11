% Yige Li, Haoyu Li, Yichen Shi, Runqi Yang


function outarray = apply_fullconnect(inarray, filterbank, biasvals)
    D2 = size(filterbank, 4); 
   
    outarray = zeros(1, 1, D2);
    for i = 1:D2
        filter = filterbank(:,:,:,i);
        outarray(:,:,i) = sum(inarray .* filter, "all") + ...
        biasvals(i);
    end

end
