function bRange = InRangeG3(board,point)
if (point(1) <= size(board,1) && point(1) > 0 && point(2) <= size(board,2) && point(2) > 0 && point(3) <= size(board,3) && point(3) > 0)
    bRange = true;
else
    bRange = false;
end
end