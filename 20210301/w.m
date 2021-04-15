function ww = w(sig,t)
    ww = sig^(0.25) * exp(-pi * sig * t^2);
end