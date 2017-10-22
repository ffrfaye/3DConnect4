function board = HumanPlayer (board, ~)
% function HumanPlayer (board, nToWin)
% 
% Updates the board using graphical input from a human. 
if (size(board,3)>9)
    error('This code only works for boards up to 9 slices deep');
end
[x,~,button]=ginput(1);
if (button==1)
    axisTitle=get(get(gca,'Title'),'string');
    if (iscell(axisTitle))
        nSlice=1;
    else
        nSlice=axisTitle(end)-'0';
    end
    j=round(x);
    if ((j>=1)&&(j<=size(board,2)))
        i=sum(board(:,j,nSlice)~=0)+1;
        board(i,j,nSlice)=1;
    end
end
end