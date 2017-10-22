function bGravity = GravityG3(board,point)
pointBelow = [point(1)-1,point(2),point(3)];
bInRange = InRangeG3(board,pointBelow);
if bInRange
    if board(pointBelow(1),pointBelow(2),pointBelow(3)) == true
        bGravity = true;
    else
        bGravity = false;
    end
else
    bGravity = true;
end
end