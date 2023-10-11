% Yige Li, Haoyu Li, Yichen Shi, Runqi Yang


function outarray = apply_softmax(inarray)
    D = size(inarray, 3);
    outarray = zeros(1, 1, D);
    alpha = max(inarray, [], 3);

    for i = 1:D
        outarray(1, 1, i) = exp(inarray(1, 1, i) - alpha);
    end

    total_sum = sum(outarray, 3);
    for i = 1:D
        outarray(1, 1, i) = outarray(1, 1, i) / total_sum;
    end
end
