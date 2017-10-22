function info = IsWin1d(v,nInRow)
count = 0;
info = [];
for i=1:length(v)
    if v(i)==true
        count = count + 1;
        if count==nInRow
            info = [i-nInRow+1,i];
            return;
        end
        if i~=length(v)&&v(i+1)==false
            info = [];
            break;
        end
    else
        info = [];
    end
    
end


end