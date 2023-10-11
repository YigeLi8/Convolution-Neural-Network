% Load the provided parameters and dataset
load 'CNNparameters.mat';
load 'cifar10testdata.mat';

%some sample code to read and display one image from each class
for classindex = 1:10
    %get indices of all images of that class
    inds = find(trueclass==classindex);
    %take first one

    imrgb = imageset(:,:,:,inds(1));
    %display it along with ground truth text label
    figure; imagesc(imrgb); truesize(gcf,[64 64]);
    title(sprintf('\%s',classlabels{classindex}));
end

%Verification of layers
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


%Debugging
load 'debuggingTest.mat';
figure; imagesc(imrgb); truesize(gcf, [64 64]);

for d = 1:length(layerResults)
    result = layerResults(d);
    fprintf('layer %d output is size %d x %d x %d\n', ...
        d,size(result,1),size(result,2), size(result,3));
end

% find the most probable class
classprobvec = squeeze(layerResults{end});
[maxprob, maxclass] = max(classprobvec);
fprintf('Estimated class is %s with probability %.4f\n', ...
    classlabels{maxclass}, maxprob);
