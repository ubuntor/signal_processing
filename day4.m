function day4()
    disp(convolve([5,0,0,3,0,0,1,0,0],[2,4,1,2]))
    disp(conv([5,0,0,3,0,0,1,0,0],[2,4,1,2]))
end

function [out] = overlapAdd(signal1, signal2, offset)
    signal2 = cat(2,zeros(1,offset),signal2);
    s1 = size(signal1,2);
    s2 = size(signal2,2);
    if s1 >= s2
        signal2 = cat(2,signal2,zeros(1,s1-s2));
    else
        signal1 = cat(2,signal1,zeros(1,s2-s1));
    end
    out = signal1 + signal2;
end

function [out] = convolve(signal1, signal2)
    s1 = size(signal1,2);
    s2 = size(signal2,2);
    out = zeros(1,s1+s2-1);
    for i = 1:s1
        out = overlapAdd(out, signal1(1,i)*signal2, i-1);
    end
end
