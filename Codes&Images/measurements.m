function measurements(output,name,trialnumber,image_counts)

    save("Output_" + name + "_" + trialnumber + '.mat');

    %%%%%%%%%%%%%%%%%%%% Accuracy & RT of full trial %%%%%%%%%%%%%%%%%%%%
    rt_all = 0;
    t = 0;
    for i = 1:image_counts
        if output(i,2) == output(i,3)
            t = t+1;
        end
        rt_all = rt_all + output(i,4);
    end
    accuracy_all = (t/image_counts);
    rt_all = (rt_all/image_counts);

    %%%%%%%%%%%%%%%%%%%% Accuracy & RT of each categury %%%%%%%%%%%%%%%%%%%%
    accuracy = zeros(4,1);
    t = zeros(4,1);
    counts = zeros(4,1);
    rts = zeros(4,1);
    for i = 1:length(output(:,1))
        if output(i,1) ~= 0 
            if output(i,2) == output(i,3)
                t(output(i,1)) = t(output(i,1)) + 1;
            end
            rts(output(i,1)) = rts(output(i,1)) + output(i,4);
            counts(output(i,1)) = counts(output(i,1)) + 1;
        end
    end
    for i = 1:4
        accuracy(i) = t(i)/(counts(i));
        rts(i) = rts(i)/(counts(i));
    end

    %%%%%%%%%%%%%%%%%%%% Displays %%%%%%%%%%%%%%%%%%%%
    disp("Accuracy of all = " + accuracy_all*100);
    disp("RT of all = " + rt_all);
    disp("Accuracy of Head = " + accuracy(1)*100);
    disp("RT of Head = " + rts(1));
    disp("Accuracy of Close Body = " + accuracy(2)*100);
    disp("RT of Close Body = " + rts(2));
    disp("Accuracy of Medium Body = " + accuracy(3)*100);
    disp("RT of Medium Body = " + rts(3));
    disp("Accuracy of Far Body = " + accuracy(4)*100);
    disp("RT of Far Body = " + rts(4));
end