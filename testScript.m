load testingBoards

for i = 9:-1:1
    
    boardExpression = ['board' int2str(i) '_connect4'];
    eval(['board =' boardExpression ';']);
    
    info = IsWin3d(logical(board),4);
    
    if ~isempty(info.start)
        board(info.start(1), info.start(2), info.start(3)) = 5;
        board(info.finish(1), info.finish(2), info.finish(3)) = 5;
        
        figure;
        for k = 1:length(board)
            subplot(6,1,k);
            slice = board(:,:,k);
            slice = slice*15;
            image(slice);
            grid on
            grid minor
        end
    else
        [boardExpression 'has no win']
    end
end