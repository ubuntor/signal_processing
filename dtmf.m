function dtmf()
    low = [697,770,852,941];
    high = [1209,1336,1477,1633];
    threshold = 35;
    key = '123A456B789C*0#D';
    [a,Fs] = audioread('R:\iTECH\Kosek\Test Sounds\DMTF\TouchTone_02.wav');
    l = length(a);
    bins = 1024;
    sc = floor(l/bins);
    ov = floor(sc/2);
    s = spectrogram(a,hamming(bins),ov);
    s = abs(s);
    warning('off','signal:findpeaks:largeMinPeakHeight')
    scale = Fs/bins;
    peakcutoff = max(s(:))/2;
    lastkey = '';
    for i = 1:size(s,2)
        %plot(linspace(0,Fs/2,bins/2+1),s(:,i))
        %refline([0 peakcutoff])
        %axis([-inf inf 0 100])
        %pause(0.05)
        [~,locs] = findpeaks(s(:,i),'MinPeakDistance',2,'MinPeakHeight',peakcutoff);
        locs = scale*locs;
        %disp(locs)
        lowi = 0;
        highi = 0;
        for j = 1:length(locs)
            [ml,mli] = min(abs(low-locs(j)));
            if ml < threshold
                lowi = mli;
                continue;
            end
            [mh,mhi] = min(abs(high-locs(j)));
            if mh < threshold
                highi = mhi;
                continue;
            end
        end
        if (lowi == 0 || highi == 0) && ~strcmp('',lastkey)
            fprintf('Key %s end at %.4f s\n',lastkey,i*l/(Fs*size(s,2)))
            lastkey = '';
        elseif lowi ~= 0 && highi ~= 0 && ~strcmp(key(lowi*4+highi-4),lastkey)
            curkey = key(lowi*4+highi-4);
            fprintf('Key %s start at %.4f s\n',curkey,i*l/(Fs*size(s,2)))
            lastkey = curkey;
        end
    end
end