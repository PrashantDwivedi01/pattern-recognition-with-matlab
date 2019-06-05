function imgs = getVideoFrames(vid, startt, endt, step, savetodir)
% extracts frames from a video and saves them as image files in a given folder.
%
% description:
%   This function generates a series of images corresponding to specified
%   frames of a given video file. Users can specify the time in second of
%   the starting frame and the time in second of the ending frame as well
%   as the time lap in second between two successive frames. Users can also
%   specify in which folder to store these images.
%   
%   inputs:
%   vid - a VideoReader object or a path to a video file
%   from - the starting second of the extracted frames (default 0)
%   to - the ending second of the extracted frames (default end time of video)
%   step - the interval in seconds between frames (default 5)
%   savetodir - (optional) the output directory (default a
%               "tmp-extracted-frames" subfolder of the video file's
%               directory or of the current execution directory)
% outputs:
%   imgs - heigth X width X colors X frames arrays representing the
%          extracted frames.
    
    % limit input from 0 to 5 arguments
    narginchk(0, 5);
    
    % constants for default values
    DEFAULTSTARTT = 0; % default start time = 1 seconds
    DEFAULTSTEP = 5; % default step = 5 seconds
    MINSTEP = 10^(-9); % minimum step = 1 nanosecond
    DEFAUTOUTDIRNAME = 'tmp-extracted-frames'; % default output dir name
    
    
    % read the video file and its properties
    if nargin < 1
        [fn, fp, ~] = ...
            uigetfile('*','Please choose the video file to be processed.');
        vid = [fp, fn];
    end
    if isa(vid, 'VideoReader')
        vidObj = vid;
    else
        vidObj = VideoReader(vid);
    end
    frameRate = vidObj.FrameRate;
    duration = vidObj.Duration;
    % nFrames = vidObj.NumberOfFrames;    
    [nrow, ncol, nclr] = size(read(vidObj, 1));
    % vidHeight = xyloObj.Height;
    % vidWidth = xyloObj.Width;
    
    % set default values to the rest arguments when no specified
    % set default start frame time
    if nargin < 2
        startt = DEFAULTSTARTT;
        userinput = input(['Type in the time in seconds of the starting ', ...
                           'frame, \nor simply enter to accept ', ... 
                           'default (', num2str(startt), ' seconds): '],'s');
        tmpstartt = str2double(userinput);
        if (~isnan(tmpstartt))
            startt = min(max(0,tmpstartt),duration);
        end
    end
    % set default end frame time
    if nargin < 3
        endt = duration;
        userinput = input(['Type in the time in seconds of the stopping', ...
                           'frame, \nor simply enter to accept ', ... 
                           'default (', num2str(endt), ' seconds): '],'s');

                       tmpendt = str2double(userinput);
        if (~isnan(tmpendt))
            endt = min(max(startt,tmpendt),duration);
        end
    end
    % set default frame interval (step)
    if nargin < 4
        step = DEFAULTSTEP;
        userinput = input(['Type in the time in seconds between two ', ...
                           'extracted frames, \nor simply enter to accept ', ... 
                           'default (', num2str(step), ' seconds): '],'s');
        tmpstep = str2double(userinput);
        if (~isnan(tmpstep))
            step = min(max(MINSTEP,tmpstep),endt-startt);
        end
    end
    % set default savetodir value
    if nargin < 5
        videopath = './';
        if (isa(vid, 'char'))
            [videopath,~,~] = fileparts(vid);
        end
        savetodir = fullfile(videopath,DEFAUTOUTDIRNAME);
        userinput = input(['Do you want to set the output directory?\n', ...
                           '(The default is: "', strrep(savetodir,'\','/'), ...
                           '")\n', '(y/n): '],'s');
        if strcmp(userinput, 'y')
            savetodir = uigetdir;
        end
    end

    % calculate the start and end frame indices and the number of frames to
    % skip each time
    startF = round(frameRate*startt)+1;
    endF = round(frameRate*endt);
    stepF = round(frameRate*step)+1;
    disp(['Extracting frames from ',vidObj.Name]);
    disp(['starting at frame no.', num2str(startF), ...
          ' (at second ', num2str(startt), '),']);
    disp(['stopping at frame no.', num2str(endF), ...
          ' (at second ', num2str(endt), '),']);
    disp(['and by every other ', num2str(stepF), ' frames (', ...
          num2str(step), ' seconds).']);
    disp(['Output folder: "', savetodir, '"']);
    
    % allocate the memory for storing the frames
    imgs = uint8(zeros(nrow, ncol, nclr, floor((endF-startF)/stepF)+1));
    
    % read one frame at a time.
    count = 0;
    for k = startF:stepF:endF
        count = count+1;
        imgs(:,:,:,count) = read(vidObj, k);
    end
    
    % write images to files
    if exist('savetodir','var')
        if (~exist(savetodir,'dir'))
            mkdir(savetodir);
        end
        count = 0;
        padding = power(10,size(num2str(max(startF, endF)),2));
        for k = startF:stepF:endF
            count = count+1;
            padded_k = num2str(padding+k);
            img = imgs(:,:,:,count);
            imwrite(img, [savetodir,'\prashant.jpg'], 'JPG');
        end
    end
end