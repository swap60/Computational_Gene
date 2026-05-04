
% =============================
% Selection (entropy + GC constraint)
% =============================
function S_out = selection(S_old, S_new)

    if entropy_calc(S_new) > entropy_calc(S_old)
        S_out = S_old;
        return;
    end

    gc = gc_content(S_new);
    if gc < 0.4 || gc > 0.6
        S_out = S_old;
    else
        S_out = S_new;
    end
end