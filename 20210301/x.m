function out = x(t)
    if (t<10)
        out = cos(2 * pi * t);
    end
    if(10 <= t && t < 20)
        out = cos(6 * pi * t);
    end
    if (t>=20)
        out = cos(4 * pi * t);
    end
end