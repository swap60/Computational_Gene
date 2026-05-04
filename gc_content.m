% =============================
% GC Content
% =============================
function gc = gc_content(S)
    counts = histcounts(S, 0:4);
    gc = (counts(3) + counts(4)) / sum(counts);
end