function [out] = discreteCos(signalFreq, sampleFreq, phase, duration)
    t = linspace(0, duration-(1/sampleFreq), sampleFreq)
    out = cos(2*%pi*signalFreq*t + phase)
endfunction

disp(discreteCos(100, 44100, 0, 1))
disp(discreteCos(10, 8192, %pi/2, 1))

function [out] = quantize(signalMin, signalMax, bits, signal)
    quantTable = linspace(signalMin, signalMax, 2^bits)
    out = zeros(1,size(signal,"c"))
    for i = 1:size(signal,"c")
        [dummy index] = min(abs(quantTable-signal(i)))
        out(1,i) = quantTable(index)
    end
endfunction

function [out] = quantError(signalMin, signalMax, bits, signal)
    out = quantize(signalMin, signalMax, bits, signal)-signal
endfunction

t = linspace(0, 1-1/1000, 1000)
s = discreteCos(1,1000,0,1)

scf()
plot(t,s,'b')
plot(t,quantize(-1,1,2,s),'k')
plot(t,quantError(-1,1,2,s),'g')

scf()
plot(t,s,'b')
plot(t,quantize(-1,1,3,s),'k')
plot(t,quantError(-1,1,3,s),'g')

scf()
plot(t,s,'b')
plot(t,quantize(-1,1,5,s),'k')
plot(t,quantError(-1,1,5,s),'g')

scf()
plot(t,2*s,'b')
plot(t,quantize(-1,1,5,2*s),'k')
plot(t,quantError(-1,1,5,2*s),'g')

function [] = showAlias(signalFreq, sampleFreq, duration)
    scf()
    a = get("current_axes")
    a.data_bounds=[0,-1.25;duration,1.25]
    t = linspace(0, duration-(1/sampleFreq), sampleFreq)
    s = discreteCos(signalFreq, sampleFreq, 0, duration)
    plot(t,s,'ks','markerfac','k')
    t2 = linspace(0, duration-(1/10000), 10000)
    s2 = discreteCos(signalFreq, 10000, 0, duration)
    plot(t2,s2,'b')
endfunction

showAlias(5,10,1)
showAlias(1,10,1)
showAlias(9,10,1)

showAlias(1,100,1)
showAlias(101,100,1)
showAlias(90,100,1)
