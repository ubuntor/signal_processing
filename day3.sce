function [out] = timeShift(signal, offset)
    out = cat(2,zeros(1,offset),signal)
endfunction

function [out] = overlapAdd(signal1, signal2, offset)
    out = cat(2,signal1,zeros(1,offset)) + cat(2,zeros(1,offset),signal2)
endfunction

function [xe, xo] = evenOdd(signal)
    s = size(signal,"c")
    xe = zeros(1,s)
    xo = zeros(1,s)
    for i = 1:s
        xe(1,i) = (signal(1,i) + signal(1,s+1-i))/2
        xo(1,i) = (signal(1,i) - signal(1,s+1-i))/2
    end
endfunction
