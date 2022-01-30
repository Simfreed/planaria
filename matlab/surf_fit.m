scriptPath = '/Users/simonfreedman/cqub/plenaria';
addpath(genpath('~/Documents/MATLAB/ImSAnE'));
dataDir    = fullfile(scriptPath, 'data');
projectDir = fullfile(scriptPath, 'surface_detect');
xp2 = project.Experiment(projectDir, dataDir);

fileMeta2                 = struct();
fileMeta2.dataDir         = dataDir;
fileMeta2.filenameFormat  = 'BMP4_Tls__Day15_Control_w2_dorsal_14_w301 405.TIF';%  full data sample use Time000000.tif
fileMeta2.timePoints      = [0]; % for full data sample use 0;
fileMeta2.stackResolution = [0.9214 0.9214 2]; 
fileMeta2.nChannels = 1;

expMeta = struct();
expMeta.description = 'Fixed worm [DAPI labeling nuclei]';
expMeta.channelsUsed = [1];
%expMeta.channelColor = [2 1 3];
expMeta.dynamicSurface = false;
expMeta.jitterCorrection = false;
expMeta.detectorType = 'surfaceDetection.planarEdgeDetector';
expMeta.fitterType = 'surfaceFitting.tpsFitter';


expMeta.fitTime          = fileMeta2.timePoints(1);

xp2.setFileMeta(fileMeta2);
xp2.setExpMeta(expMeta);
xp2.initNew();

xp2.loadTime(0);

xp2.rescaleStackToUnitAspect();

detectOptions = xp2.detector.defaultOptions;
detectOptions.sigma = 3.5;
detectOptions.zdir = -3;
detectOptions.maxIthresh = 0.02;

xp2.setDetectOptions(detectOptions);
xp2.detectSurface();

fitOptions = struct('smoothing', 500, 'gridSize', [100 100]);
xp2.setFitOptions(fitOptions);
xp2.fitSurface();

%xp2.generateSOI();