function ShowBoard (board, info)
% function ShowBoard (board, info)
% 
% The function plots out the board to the current figure. It is assumed
% that board is 3D and the entries for player 1 are 1 (designated blue) and
% for player 2 are -1 (red). Empty entries are 0 (gray). If 'info' is input
% and is not [], there is a winner and show that winner in magenta.
board=board+1;
board(board==0)=3;
[m,n,nSlices]=size(board);
if (exist('info','var')&&~isempty(info))
    nWon=max(abs(info.finish-info.start))+1;
    i=linspace(info.start(1),info.finish(1),nWon);
    j=linspace(info.start(2),info.finish(2),nWon);
    k=linspace(info.start(3),info.finish(3),nWon);
    inds=sub2ind(size(board),i,j,k);
    board(inds)=4;
end
nI=floor(sqrt(nSlices)); nJ=ceil(sqrt(nSlices)); 
while (nI*nJ<nSlices), nJ=nJ+1; end
fontSize=18;
for k=1:nSlices
    subplot(nI,nJ,k);
    image(board(:,:,k));
    axis('equal'); axis('xy');
    if (k==1)
        title({'Front-most slice, #1',...
            '{\color{blue}Player 1   \color{red}Player 2}'});
    elseif (k==nSlices)
        title(sprintf('Back-most slice, #%d',nSlices));
    else
        title(sprintf('Slice #%d',k));
    end
    set(gca,'XTick',1:n,'YTick',1:m,'FontSize',fontSize);
    hold('on');
    plot([0.5 n+0.5],[0.5 0.5],'-k','LineWidth',3);
    for j=1:m
        plot([0.5 n+0.5],[j+0.5 j+0.5],'-k','LineWidth',3);
    end
    plot([0.5 0.5],[0.5 m+0.5],'-k','LineWidth',3);
    for j=1:n
        plot([j+0.5 j+0.5],[0.5 m+0.5],'-k','LineWidth',3);
    end
end
colormap([0.5 0.5 0.5; 0 0 1; 1 0 0; 1 0 1]);
end