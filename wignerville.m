function wignerville()
    Fs = 5e2;
    t = 0:1/Fs:1;
    %x = chirp(t,100,1,200,'quadratic');
    x = chirp(t,0,1,125) + chirp(t,125,1,250);
    x = cat(2, x, zeros(1,mod(size(x,2),2)));
    h = hilbert(x);
    N = size(x,2);
    w = zeros(N,N);
    win = 50;
    for f = 0:N-1
        for n = 0:N-1
            l = min([win,n,N-n-1]);
            s = 0;
            for m = -l:l
                s = s + h(1+n+m)*conj(h(1+n-m))*exp(-1i*2*pi*f*m/Fs);
            end
            w(f+1,n+1) = 2 * s;
        end
        disp(f)
    end
    imagesc(abs(w))
    colormap(jet)
    colorbar
    set(gca,'YDir','normal')
end