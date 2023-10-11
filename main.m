% Yige Li, Haoyu Li, Yichen Shi, Runqi Yang

% Load parameters and data
load 'CNNparameters.mat';
load 'cifar10testdata.mat';


% Verification of layers
for d = 1:length(layertypes)
    fprintf('layer %d is of type %s\n', d, layertypes{d});
    filterbank = filterbanks{d};
    if ~isempty(filterbank)
        fprintf('   filterbank size %d x %d x %d x %d\n', ...
            size(filterbank,1), size(filterbank,2), ...
            size(filterbank,3), size(filterbank,4));
        biasvec = biasvectors{d};
        fprintf('    number of biases is %d\n', length(biasvec));
    end
end

% Forward Passing
numImg = size(imageset, 4);
confusionMatrix = zeros(10, 10);

for imgIdx = 1:numImg
    inputImg = imageset(:,:,:,imgIdx);
    
    for layerIdx = 1:length(layertypes)
        layerType = layertypes{layerIdx};
        filterbank = filterbanks{layerIdx};
        biasvals = biasvectors{layerIdx};
        
        switch layerType
            case 'imnormalize'
                inputImg = apply_imnormalize(inputImg);
            case 'convolve'
                inputImg = apply_convolve(inputImg, filterbank, biasvals);
            case 'relu'
                inputImg = apply_relu(inputImg);
            case 'maxpool'
                inputImg = apply_maxpool(inputImg);
            case 'fullconnect'
                inputImg = apply_fullconnect(inputImg, filterbank, biasvals);
            case 'softmax'
                inputImg = apply_softmax(inputImg);
        end
    end
    
    [~, predictedClass] = max(inputImg);
    trueClass = trueclass(imgIdx);
    confusionMatrix(trueClass, predictedClass) = confusionMatrix( ...
        trueClass, predictedClass) + 1;
end

% --- Evaluation ---
accuracy = sum(diag(confusionMatrix)) / sum(confusionMatrix(:)) * 100;
disp('Confusion Matrix:');
disp(confusionMatrix);
fprintf('Total accuracy: %.2f%%\n', accuracy);

