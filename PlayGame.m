function PlayGame (functionGroupA, functionGroupB)
% function PlayGame (functionGroup1, functionGroup2)
% 
% The function runs a game between the functions of group A and B. If
% 'functionGroupA' or 'functionGroupB' are empty, it means that this
% group's algorithm is a human player.
if (~exist('functionGroupA','var')), functionGroupA=[]; end
if (~exist('functionGroupB','var')), functionGroupB=[]; end
% rng('default'); % For debugging purposes
figMain=1;
nRows=10; nColumn=8; nSlices = 6;
nToWin=5;
board=zeros(nRows,nColumn,nSlices);
isWin=false;
if (round(rand)==1)
    turns={functionGroupA, functionGroupB};
    kTurn=1;
else
    turns={functionGroupB, functionGroupA};
    kTurn=2;
end
turns(cellfun(@isempty,turns))={@HumanPlayer};
figure(figMain); clf;
ShowBoard(board);
while (~isWin)
    % If there are no empty spaces on the board, declare a tie.
    if (~any(board(:)==0))
        CreateStruct.Interpreter='tex'; CreateStruct.WindowStyle='modal'; 
        msgbox('\fontsize{24}Game tied','Game Over','help',CreateStruct);
        return;
    end
    % Update board
    signTurn=(-1)^(kTurn-1);
    board=signTurn*turns{kTurn}(signTurn*board,nToWin);
    info=IsWin3d(board==signTurn,nToWin);
    if (isempty(info))
        ShowBoard(board);
    else
        ShowBoard(board,info);
        isWin=true;
        % Announce winner
        CreateStruct.Interpreter='tex'; CreateStruct.WindowStyle='modal'; 
        msgbox(sprintf('\\fontsize{24}{\\color{magenta}Player %d} wins',...
            kTurn),'Game Over','help',CreateStruct);
    end
    kTurn=3-kTurn;
end
end