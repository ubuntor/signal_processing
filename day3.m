function day3()
    s = [1 2 3 4 5];
    disp(timeShift(s,3))
    disp(overlapAdd(s,s,3))
    [even,odd] = evenOdd(s);
    disp(even)
    disp(odd)
end

function [out] = timeShift(signal, offset)
    out = cat(2,zeros(1,offset),signal);
end

function [out] = overlapAdd(signal1, signal2, offset)
    out = cat(2,signal1,zeros(1,offset)) + cat(2,zeros(1,offset),signal2);
end

function [xe, xo] = evenOdd(signal)
    s = size(signal,2);
    xe = zeros(1,s);
    xo = zeros(1,s);
    for i = 1:s
        xe(1,i) = (signal(1,i) + signal(1,s+1-i))/2;
        xo(1,i) = (signal(1,i) - signal(1,s+1-i))/2;
    end
end
