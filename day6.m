function day6()
    fs = 44100;
    s1 = audioread('a4.wav');
    concert = audioread('concert.wav');
    s2 = stereoconv(s1,concert);
    echohalf = kron(0.5.^(0:5),[1,zeros(1,fs/2-1)])';
	s3 = stereoconv(s1,echohalf);
    echoone = kron(0.5.^(0:5),[1,zeros(1,fs-1)])';
	s4 = stereoconv(s1,echoone);
    echotwo = kron(0.5.^(0:5),[1,zeros(1,2*fs-1)])';
	s5 = stereoconv(s1,echotwo);
    echoeighth = kron(0.5.^(0:10),[1,zeros(1,round(fs/8)-1)])';
	s6 = stereoconv(s1,echoeighth);
    %soundsc(s1,fs); % normal
    %soundsc(s2,fs); % concert hall
    %soundsc(s3,fs); % echo every 1/2 sec
    %soundsc(s4,fs); % echo every 1 sec
    %soundsc(s5,fs); % echo every 2 sec
    %soundsc(s6,fs); % echo every 1/8 sec
    soundsc(squareWave(440,1000),44100)
    soundsc(triangleWave(440,1000),44100)
    soundsc(sawtoothWave(440,1000),44100)
    t = linspace(0,1-1/44100,44100);
    plot(t,squareWave(3,100),t,triangleWave(3,100),t,sawtoothWave(3,100))
end

function [out] = stereoconv(signal1, signal2)
    s1 = size(signal1,2);
    s2 = size(signal2,2);
    if s1 == 1
        signal1 = cat(2,signal1,signal1);
    end
    if s2 == 1
        signal2 = cat(2,signal2,signal2);
    end
    out = cat(2,conv(signal1(:,1)',signal2(:,1)')',conv(signal1(:,2)',signal2(:,2)')');
end

function [out] = discreteSin(signalFreq, sampleFreq, phase, duration)
    t = linspace(0, duration-(1/sampleFreq), sampleFreq);
    out = sin(2*pi*signalFreq*t + phase);
end

function [out] = squareWave(signalFreq, terms)
    out = zeros(1,44100);
    for k = 1:2:terms*2-1
        out = out + (4/pi)*(1/k*discreteSin(signalFreq*k, 44100, 0, 1));
    end
end

function [out] = triangleWave(signalFreq, terms)
    out = zeros(1,44100);
    for k = 1:2:terms*2-1
        out = out + (8/pi/pi)*((-1)^((k-1)/2)/k^2)*discreteSin(signalFreq*k, 44100, 0, 1);
    end
end

function [out] = sawtoothWave(signalFreq, terms)
    out = 1/2 + zeros(1,44100);
    for k = 1:terms
        out = out - (1/pi)*(1/k)*discreteSin(signalFreq*k, 44100, 0, 1);
    end
end