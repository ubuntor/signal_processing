function day2()
    t = linspace(0, 1-1/1000, 1000);
    s = discreteCos(1,1000,0,1);

    figure
    subplot(2,2,1)
    plot(t,s,'b',t,quantize(-1,1,2,s),'k',t,quantError(-1,1,2,s),'g')
    title('1 Hz, 1000 Hz sample, 2 bit precision')
    
    subplot(2,2,2)
    plot(t,s,'b',t,quantize(-1,1,3,s),'k',t,quantError(-1,1,3,s),'g')
    title('1 Hz, 1000 Hz sample, 3 bit precision')
    
    subplot(2,2,3)
    plot(t,s,'b',t,quantize(-1,1,5,s),'k',t,quantError(-1,1,5,s),'g')
    title('1 Hz, 1000 Hz sample, 5 bit precision')
    
    subplot(2,2,4)
    plot(t,2*s,'b',t,quantize(-1,1,5,2*s),'k',t,quantError(-1,1,5,2*s),'g')
    title('1 Hz, 1000 Hz sample, 5 bit precision, clipping')
    
    showAlias(5,10,1)
    showAlias(1,10,1)
    showAlias(9,10,1)
    
    showAlias(1,100,1)
    showAlias(101,100,1)
    showAlias(90,100,1)
end

function [out] = discreteCos(signalFreq, sampleFreq, phase, duration)
    t = linspace(0, duration-(1/sampleFreq), sampleFreq);
    out = cos(2*pi*signalFreq*t + phase);
end

function [out] = quantize(signalMin, signalMax, bits, signal)
    quantTable = linspace(signalMin, signalMax, 2^bits);
    out = interp1(quantTable,quantTable,signal,'nearest','extrap');
end

function [out] = quantError(signalMin, signalMax, bits, signal)
    out = quantize(signalMin, signalMax, bits, signal)-signal;
end

function [] = showAlias(signalFreq, sampleFreq, duration)
    figure
    t = linspace(0, duration-(1/sampleFreq), sampleFreq);
    s = discreteCos(signalFreq, sampleFreq, 0, duration);
    plot(t,s,'ks','MarkerFaceColor','k')
    hold on
    
    t2 = linspace(0, duration-(1/10000), 10000);
    s2 = discreteCos(signalFreq, 10000, 0, duration);
    plot(t2,s2,'b')
    hold off
end
