% Yige Li, Haoyu Li, Yichen Shi, Runqi Yang


function outarray = apply_imnormalize(inarray)
    outarray = (double(inarray) / 255.0) - 0.5;
end
