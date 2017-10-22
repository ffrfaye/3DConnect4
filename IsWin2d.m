function info = IsWin2d(board, nInRow)
info.start=[];
info.finish=[];
% Find if win horizontally
    for i = 1:size(board,1)
        temp = IsWin1d(board(i,:),nInRow);
        if (~isempty(temp))
            info.start=[i,temp(1)];
            info.finish=[i,temp(2)];
            return;
        end
    end
    
% Find if win vertically
    for i = 1:size(board,2)
        temp = IsWin1d(board(:,i),nInRow);
        if (~isempty(temp))
            info.start=[temp(1),i];
            info.finish=[temp(2),i];
            return;
        end
    end
    
%Find if win diagonally
    info = IsWinDiag(board,nInRow);
    

end
    
        