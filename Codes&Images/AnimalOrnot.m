
function AnimalOrnot(subject_name,n,image_counts)
    clc
    
    %%%%%%%%%%%%%%%%%%%% Data reading %%%%%%%%%%%%%%%%%%%%
    img_dir = 'H_a\';
    file_list = dir([img_dir '*.jpg']);
    img_H_a = cell(150, 1);
    for i = 1:length(file_list)
        filename = [img_dir file_list(i).name];
        img_H_a{i} = imread(filename);
    end
    
    img_dir = 'H_d\';
    file_list = dir([img_dir '*.jpg']);
    img_H_d = cell(150, 1);
    for i = 1:length(file_list)
        filename = [img_dir file_list(i).name];
        img_H_d{i} = imread(filename);
    end
    
    img_dir = 'C_a\';
    file_list = dir([img_dir '*.jpg']);
    img_C_a = cell(150, 1);
    for i = 1:length(file_list)
        filename = [img_dir file_list(i).name];
        img_C_a{i} = imread(filename);
    end
    
    img_dir = 'C_d\';
    file_list = dir([img_dir '*.jpg']);
    img_C_d = cell(150, 1);
    for i = 1:length(file_list)
        filename = [img_dir file_list(i).name];
        img_C_d{i} = imread(filename);
    end
    
    img_dir = 'M_a\';
    file_list = dir([img_dir '*.jpg']);
    img_M_a = cell(150, 1);
    for i = 1:length(file_list)
        filename = [img_dir file_list(i).name];
        img_M_a{i} = imread(filename);
    end
    
    img_dir = 'M_d\';
    file_list = dir([img_dir '*.jpg']);
    img_M_d = cell(150, 1);
    for i = 1:length(file_list)
        filename = [img_dir file_list(i).name];
        img_M_d{i} = imread(filename);
    end
    
    img_dir = 'F_a\';
    file_list = dir([img_dir '*.jpg']);
    img_F_a = cell(150, 1);
    for i = 1:length(file_list)
        filename = [img_dir file_list(i).name];
        img_F_a{i} = imread(filename);
    end
    
    img_dir = 'F_d\';
    file_list = dir([img_dir '*.jpg']);
    img_F_d = cell(150, 1);
    for i = 1:length(file_list)
        filename = [img_dir file_list(i).name];
        img_F_d{i} = imread(filename);
    end
    
    %%%%%%%%%%%%%%%%%%%% Trial making %%%%%%%%%%%%%%%%%%%%
    trial1 = cell(400,1);
    trial2 = cell(400,1);
    trial3 = cell(400,1);
    
    trial1(1:50) = img_H_a(1:50);
    trial1(51:100) = img_H_d(1:50);
    trial1(101:150) = img_C_a(1:50);
    trial1(151:200) = img_C_d(1:50);
    trial1(201:250) = img_M_a(1:50);
    trial1(251:300) = img_M_d(1:50);
    trial1(301:350) = img_F_a(1:50);
    trial1(351:400) = img_F_d(1:50);
    
    trial2(1:50) = img_H_a(51:100);
    trial2(51:100) = img_H_d(51:100);
    trial2(101:150) = img_C_a(51:100);
    trial2(151:200) = img_C_d(51:100);
    trial2(201:250) = img_M_a(51:100);
    trial2(251:300) = img_M_d(51:100);
    trial2(301:350) = img_F_a(51:100);
    trial2(351:400) = img_F_d(51:100);
    
    trial3(1:50) = img_H_a(101:150);
    trial3(51:100) = img_H_d(101:150);
    trial3(101:150) = img_C_a(101:150);
    trial3(151:200) = img_C_d(101:150);
    trial3(201:250) = img_M_a(101:150);
    trial3(251:300) = img_M_d(101:150);
    trial3(301:350) = img_F_a(101:150);
    trial3(351:400) = img_F_d(101:150);

    
    %%%%%%%%%%%%%%%%%%%% Trial defining %%%%%%%%%%%%%%%%%%%%
    trial_number = image_counts;
    random_im = randperm(400, 400);
    switch n
        case 1
            trial = trial1;
        case 2
            trial = trial2;
        case 3
            trial = trial3;
        otherwise
            trial = trial1;
    end
    
    %%%%%%%%%%%%%%%%%%%% Screen making %%%%%%%%%%%%%%%%%%%%
    PsychDefaultSetup(2);
    backgroundColor = WhiteIndex(0)/2;
    [window, windowRect] = PsychImaging('OpenWindow', 0, backgroundColor);
    [~, ~] = Screen('WindowSize', window);
    ifi = Screen('GetFlipInterval', window);
    [xCenter, yCenter] = RectCenter(windowRect);
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    
    %%%%%%%%%%%%%%%%%%%% Keyboard defining %%%%%%%%%%%%%%%%%%%%
    kQ = KbName('q');          
    kSp = KbName('space');     
    kL = KbName('LeftArrow');
    kR = KbName('RightArrow');
    key = nan;
    
    %%%%%%%%%%%%%%%%%%%% Epoch durations %%%%%%%%%%%%%%%%%%%%
    showImage_duration = 0.02;
    waitframes_image = round(showImage_duration / ifi);
    showImage_ISI = 0.03;
    waitframes_ISI = round(showImage_ISI / ifi);
    showImage_filter = 0.08;
    waitframes_filter = round(showImage_filter / ifi);
    
    %%%%%%%%%%%%%%%%%%%% Noise filter %%%%%%%%%%%%%%%%%%%%
    noiseid = CreateProceduralNoise(window, 800, 800, 'Perlin', [0.7 0.7 0.7 0.5]);
    
    %%%%%%%%%%%%%%%%%%%% Text fetures %%%%%%%%%%%%%%%%%%%%
    Screen('TextSize', window, 44);
    Screen('TextStyle', window, 5);
    Screen('TextFont', window, 'Ariel');
    
    %%%%%%%%%%%%%%%%%%%% First scene %%%%%%%%%%%%%%%%%%%%
    message = sprintf('If you see an Animal press the LeftArrow key\n\n If you do not see an Animal press the RightArrow key \n\n Press the Space key when you are ready. \n\n\n\n By Amirhossein Zahedi 2024');
    DrawFormattedText(window, message, 'center','center', [256,256,256]);
    HideCursor;
    Screen('Flip', window);
    
    %%%%%%%%%%%%%%%%%%%% Main cycle %%%%%%%%%%%%%%%%%%%%
    output = zeros(400,4);
    for i = 1:trial_number
        while ~(key(1) == kSp || key(1) == kQ)
            key(1) = nh_key_resp(-1);
        end
        
        %%%%%%%%%%%%%%%%%%%% Center scene %%%%%%%%%%%%%%%%%%%%
        t_center1 = GetSecs;
        Screen('DrawDots', window, [xCenter, yCenter], 20, [1 1 1], [], 2);
        Screen('Flip', window);
        Screen('Flip', window, t_center1 + (30) * ifi);
        
        %%%%%%%%%%%%%%%%%%%% Delay for image showing %%%%%%%%%%%%%%%%%%%%
        delay = randi([10,20]);
        t_delay = GetSecs;
        Screen('Flip', window);
        Screen('Flip', window, t_delay + (delay) * ifi);
        
        %%%%%%%%%%%%%%%%%%%% Image defining & setting %%%%%%%%%%%%%%%%%%%%
        image = rgb2gray(trial{random_im(i)});
        imageTexture = Screen('MakeTexture', window, image);
        
        if (random_im(i)<=50 && random_im(i)>=1)
            cat = 1;
            animal = 1;
        elseif (random_im(i)<=100 && random_im(i)>=51)
            cat = 1;
            animal = -1;
        elseif (random_im(i)<=150 && random_im(i)>=101)
            cat = 2;
            animal = 1;
        elseif (random_im(i)<=200 && random_im(i)>=151)
            cat = 2;
            animal = -1;
        elseif (random_im(i)<=250 && random_im(i)>=201)
            cat = 3;
            animal = 1;
        elseif (random_im(i)<=300 && random_im(i)>=251)
            cat = 3;
            animal = -1;
        elseif (random_im(i)<=350 && random_im(i)>=301)
            cat = 4;
            animal = 1;
        elseif (random_im(i)<=400 && random_im(i)>=351)
            cat = 4;
            animal = -1;
        end
    
        output(i,1) = cat;
        output(i,2) = animal; 
    
        %%%%%%%%%%%%%%%%%%%% Image showing %%%%%%%%%%%%%%%%%%%%
        t_image = GetSecs;
        Screen('DrawTexture', window, imageTexture, [], [xCenter-400 yCenter-400 xCenter+400 yCenter+400], 0);
        Screen('Flip', window);
        Screen('Flip', window, t_image + (waitframes_image) * ifi);
        
        %%%%%%%%%%%%%%%%%%%% ISI %%%%%%%%%%%%%%%%%%%%
        t_ISI = GetSecs;
        Screen('Flip', window);
        Screen('Flip', window, t_ISI + (waitframes_ISI)* ifi);
        
        %%%%%%%%%%%%%%%%%%%% Noise showing %%%%%%%%%%%%%%%%%%%%
        t_filter = GetSecs;
        Screen('DrawTexture', window, noiseid, [], [], [], [], [], [], [], [], [1, 0, 0, 0]);
        Screen('Flip', window);
        Screen('Flip', window, t_filter + (waitframes_filter)*ifi);
        
        %%%%%%%%%%%%%%%%%%%% Response scene %%%%%%%%%%%%%%%%%%%%
        Screen('TextSize', window, 100);
        Screen('TextStyle', window, 1);
        message = sprintf('Animal                         not Animal \n\n LeftArrow key               RightArrow key');
        DrawFormattedText(window, message, 'center','center', [0,0,0]);
        Screen('DrawDots', window, [xCenter, yCenter], 20, [0 0 0], [], 2);
        HideCursor;
        Screen('Flip', window);
        t_response_start = GetSecs;
        
        while ~(key(1) == kL || key(1) == kR)
            key(1) = nh_key_resp(-1);
        end
        if (key(1) == kL)
            output(i,3) = 1;
        else
            output(i,3) = -1;
        end
        
        %%%%%%%%%%%%%%%%%%%% Response time %%%%%%%%%%%%%%%%%%%%
        t_response_end = GetSecs;
        response_time = t_response_end - t_response_start;
        output(i,4) = response_time;
    
        %%%%%%%%%%%%%%%%%%%% Training scene (Trial 1) %%%%%%%%%%%%%%%%%%%%
        if n == 1
            if output(i,3) == animal
                message = sprintf('CORRECT');
                DrawFormattedText(window, message, 'center','center', [0,256,0]);
                HideCursor;
            else
                message = sprintf('WRONG');
                DrawFormattedText(window, message, 'center','center', [256,0,0]);
                HideCursor;
            end
            Screen('Flip', window);
            Screen('Flip', window, t_response_end + (30)* ifi);
        end
    
        %%%%%%%%%%%%%%%%%%%% Delay %%%%%%%%%%%%%%%%%%%%
        Screen('Flip', window);
    
    end
    
    %%%%%%%%%%%%%%%%%%%% Measurements %%%%%%%%%%%%%%%%%%%%
    measurements(output,subject_name,n,trial_number);
    
    %%%%%%%%%%%%%%%%%%%% Quit message %%%%%%%%%%%%%%%%%%%%
    message = sprintf('Press Q to Quit');
    DrawFormattedText(window, message, 'center','center', [0,0,256]);
    HideCursor;
    Screen('Flip', window);
    
    while ~(key(1) == kQ)
            key(1) = nh_key_resp(-1);
    end
    
    %%%%%%%%%%%%%%%%%%%% Screen clearing %%%%%%%%%%%%%%%%%%%%
    sca; 

end
