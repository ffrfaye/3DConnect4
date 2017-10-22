function info = IsWinDiag(board,nInRow)
info.start=[];
info.finish=[];

for i = -size(board,1)+1:size(board,1)-1
    extractedDiag = diag(board,i);
    result = IsWin1d(extractedDiag,nInRow);
    if (~isempty(result))
        if i<0
            info.start = [result(1)-i,result(1)];
            info.finish = [result(2)-i,result(2)];
            return;
        elseif i>0
            info.start = [result(1),result(1)+i];
            info.finish = [result(2),result(2)+i];
            return;
        elseif i==0
            info.start = [result(1),result(1)];
            info.finish = [result(2),result(2)];
            return;
        end  
    end
end

board = fliplr(board);

for i = -size(board,1)+1:size(board,1)-1
    extractedDiag = diag(board,i);
    result = IsWin1d(extractedDiag,nInRow);
    if (~isempty(result))
        if i<0
            info.start = [result(1)-i,result(1)];
            info.finish = [result(2)-i,result(2)];            
        elseif i>0
            info.start = [result(1),result(1)+i];
            info.finish = [result(2),result(2)+i];           
        elseif i==0
            info.start = [result(1),result(1)];
            info.finish = [result(2),result(2)];            
        end  
        info.start = [info.start(1),size(board,2)+1-info.start(2)];
        info.finish = [info.finish(1),size(board,2)+1-info.finish(2)];
        return;
    end
    
end


%{
    
    for i = 1:size(board,1)
        for j = 1:size(board,2)
            if board(i,j)==true
                count = count+1;
                if count == nInRow
                    info.start = [i-count+1,j-count+1];
                    info.finish = [i,j];
                end
                if (i~=size(board,1)&&j~=size(board,2))
                    if board(i+1,j+1)==false
                        break;
                    end
                end
            end
        end
    end
%}

end