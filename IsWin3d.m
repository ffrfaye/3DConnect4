function info3d = IsWin3d (board, nToWin)
% function info3d = IsWin3d (board, nToWin)
% 
% The function checks whether there are 'nToWin' consecutive 'true' entries
% in the 3D 'board' horizontally, vertically, or diagonally. If it finds a
% winning state, it returns it in 'info'. 'info' is a tructure with 'start'
% and 'end' fields, both are 1x2 for [i,j]. If no winning state is found,
% 'info' is [].

% Check whether a win exists in any 2D slice of the 3D board, in the
% left/right, up/down, or in/out directions.
[m,n,p]=size(board);
info3d=[];
for i=1:m
    info2d=IsWin2d(squeeze(board(i,:,:)),nToWin);
    if (~isempty(info2d))
        info3d=struct('start',[i,info2d.start],'finish',[i,info2d.finish]);
        return
    end
end
for j=1:n
    info2d=IsWin2d(squeeze(board(:,j,:)),nToWin);
    if (~isempty(info2d))
        info3d=struct('start',[info2d.start(1),j,info2d.start(2)],...
            'finish',[info2d.finish(1),j,info2d.finish(2)]);
        return
    end
end
for k=1:p
    info2d=IsWin2d(squeeze(board(:,:,k)),nToWin);
    if (~isempty(info2d))
        info3d=struct('start',[info2d.start,k],'finish',[info2d.finish,k]);
        return
    end
end
% Look for 3D-diagnoal win states. For each entry each face of the cube,
% look around. Elements above, below, to the left, and to the right, are in
% 2D sliecs so they would have been caught by the above process. So we need
% to examine only diagonals that point to the top left, top right, bottom
% left, and bottom right.
% Top & bottom faces
for j=1:n
    for k=1:p
        info3d=Test3dDiagonals(board,1,j,k,nToWin);
        if (~isempty(info3d)), return; end
        info3d=Test3dDiagonals(board,m,j,k,nToWin);
        if (~isempty(info3d)), return; end
    end
end
% Left & right faces
for i=1:m
    for k=1:p
        info3d=Test3dDiagonals(board,i,1,k,nToWin);
        if (~isempty(info3d)), return; end
        info3d=Test3dDiagonals(board,i,n,k,nToWin);
        if (~isempty(info3d)), return; end
    end
end
% Outer-most and inner-most faces for j=nToWin:n-nToWin+1
for i=1:m
    for j=1:n
        info3d=Test3dDiagonals(board,i,j,1,nToWin);
        if (~isempty(info3d)), return; end
        info3d=Test3dDiagonals(board,i,j,p,nToWin);
        if (~isempty(info3d)), return; end
    end
end

end

% ============================ Subfunctions ===============================

function info = IsWin2d (board, nToWin)
% function IsWin3d (board, nToWin)
% 
% The function checks whether there are 'nToWin' consecutive 'true' entries
% in the 2D 'board' horizontally, vertically, or diagonally. If it finds a
% winning state, it returns it in 'info'. 'info' is a tructure with 'start'
% and 'end' fields, both are 1x2 for [i,j]. If no winning state is found,
% 'info' is [].
info=[];
[m,n]=size(board);
% Search for horizontal wins
for i=1:m
    location=IsWin1d(board(i,:),nToWin);
    if (~isempty(location))
        info=struct('start',[i,location],'finish',[i,location+nToWin-1]);
        return;
    end
end
% Search for vertical wins
for j=1:n
    location=IsWin1d(board(:,j),nToWin);
    if (~isempty(location))
        info=struct('start',[location,j],'finish',[location+nToWin-1,j]);
        return;
    end
end
boardFlipLr=fliplr(board);
for j=-(m-1):n-1
    location=IsWin1d(diag(board,j),nToWin);
    if (~isempty(location))
        if (j>=0)
            info=struct('start',[location,j+location],...
                'finish',[location,j+location]+nToWin-1);
        else
            info=struct('start',[-j+location,location],...
                'finish',[-j+location,location]+nToWin-1);
        end
        return;
    end
    location=IsWin1d(diag(boardFlipLr,j),nToWin);
    if (~isempty(location))
        if (j>=0)
            info=struct('start',[location+nToWin-1,n-j-location+1-nToWin+1],...
                'finish',[location,n-j-location+1]);
        else
            info=struct('start',[-j+location+nToWin-1,location],...
                'finish',[-j+location,location+nToWin-1]);
        end
        return;
    end
end
end

% -------------------------------------------------------------------------
function location = IsWin1d (board, nToWin)
% function IsWin3d (board, nToWin)
% 
% The function checks whether there are 'nToWin' consecutive 'true' entries
% in the 1D 'board' horizontally, vertically, or diagonally. It returns the
% first index of that winning state in 'location' if found. Otherwise
% 'location' is [].
location=strfind(char('a'+board(:)'),repmat('b',1,nToWin));
if (~isempty(location)), location=location(1); end
end

% -------------------------------------------------------------------------
function info3d = Test3dDiagonals (board, iOrg, jOrg, kOrg, nToWin)
% function info3d = Test3dDiagonals (board, iOrg, jOrg, kOrg, nToWin)
% 
% Test whether any of the 3D diagonals stemming from location 'iOrg',
% 'jOrg, 'kOrg' in 'board' have 'nToWin' or more conecutive elements. The
% function works by trying to move out in all 8 diagonal directions from
% the initial location.
info3d=[];
[m,n,p]=size(board);
InBounds=@(i,j,k)((i>=1)&(j>=1)&(k>=1)&(i<=m)&(j<=n)&(k<=p));
for iSign=[-1,1]
    for jSign=[-1,1]
        for kSign=[-1,1]
            countConsecutive=0;
            i=iOrg; j=jOrg; k=kOrg;
            while (InBounds(i,j,k))
                countConsecutive=(countConsecutive+1)*board(i,j,k);
                if (countConsecutive>=nToWin)
                    info3d=struct(...
                        'start',[i-iSign*(nToWin-1),j-jSign*(nToWin-1),...
                        k-kSign*(nToWin-1)],'finish',[i,j,k]);
                    return
                end
                i=i+iSign; j=j+jSign; k=k+kSign; 
            end
        end
    end
end
end