function updatedBoard = PlayMoveG3(board, nToWin)

% Check if we are 1 disc away from winning.
updatedBoard = board;
potential1 = [0 0 0];
potential2 = [0 0 0];
temp = IsWin3d(board,nToWin-1);

if (~isempty(temp))
    changedIndex = temp.finish-temp.start;
    dim1Changed = logical(changedIndex(1));
    dim2Changed = logical(changedIndex(2));
    dim3Changed = logical(changedIndex(3));
    
    
    if(dim1Changed)
        potential1(1) = temp.finish(1)-1;
        potential1(2) = temp.finish(2);
        potential1(3) = temp.finish(3);
        potential2(1) = temp.finish(1)+1;
        potential2(2) = temp.finish(2);
        potential2(3) = temp.finish(3);
    end
    if(dim2Changed)
        potential1(1) = temp.finish(1);
        potential1(2) = temp.finish(2)-1;
        potential1(3) = temp.finish(3);
        potential2(1) = temp.finish(1);
        potential2(2) = temp.finish(2)+1;
        potential2(3) = temp.finish(3);
    end
    if(dim3Changed)
        potential1(1) = temp.finish(1);
        potential1(2) = temp.finish(2);
        potential1(3) = temp.finish(3)-1;
        potential2(1) = temp.finish(1);
        potential2(2) = temp.finish(2);
        potential2(3) = temp.finish(3)+1;
    end
    
    
    % check 2 potential positions in the range? gravity?
    bInRange = InRangeG3(board,potential1);
    bGravity = GravityG3(board,potential1);
    if (bInRange && bGravity && ~board(potential1(1),potential1(2),potential1(3)))
        updatedBoard(potential1(1),potential1(2),potential1(3)) = true;
        return;
    else
        bInRange = InRangeG3(board,potential2);
        bGravity = GravityG3(board,potential2);
        if (bInRange && bGravity && ~board(potential2(1),potential2(2),potential2(3)))
            updatedBoard(potential2(1),potential2(2),potential2(3)) = true;
            return;
        end
    end
end

% Check if they are 1 disc away from winning.
updatedBoard = board;
theirBoard = logical(board==-1);
potential1 = [0 0 0];
potential2 = [0 0 0];
temp = IsWin3d(theirBoard,nToWin-1);

if (~isempty(temp))
    changedIndex = temp.finish-temp.start;
    dim1Changed = logical(changedIndex(1));
    dim2Changed = logical(changedIndex(2));
    dim3Changed = logical(changedIndex(3));
    
    
    if(dim1Changed)
        potential1(1) = temp.finish(1)-1;
        potential1(2) = temp.finish(2);
        potential1(3) = temp.finish(3);
        potential2(1) = temp.finish(1)+1;
        potential2(2) = temp.finish(2);
        potential2(3) = temp.finish(3);
    end
    if(dim2Changed)
        potential1(1) = temp.finish(1);
        potential1(2) = temp.finish(2)-1;
        potential1(3) = temp.finish(3);
        potential2(1) = temp.finish(1);
        potential2(2) = temp.finish(2)+1;
        potential2(3) = temp.finish(3);
    end
    if(dim3Changed)
        potential1(1) = temp.finish(1);
        potential1(2) = temp.finish(2);
        potential1(3) = temp.finish(3)-1;
        potential2(1) = temp.finish(1);
        potential2(2) = temp.finish(2);
        potential2(3) = temp.finish(3)+1;
    end
    
    
    % check 2 potential positions in the range? gravity?
    bInRange = InRangeG3(theirBoard,potential1);
    bGravity = GravityG3(theirBoard,potential1);
    if (bInRange && bGravity && ~board(potential1(1),potential1(2),potential1(3)))
        updatedBoard(potential1(1),potential1(2),potential1(3)) = true;
        return;
    else
        bInRange = InRangeG3(theirBoard,potential2);
        bGravity = GravityG3(theirBoard,potential2);
        if (bInRange && bGravity && ~board(potential2(1),potential2(2),potential2(3)))
            updatedBoard(potential2(1),potential2(2),potential2(3)) = true;
            return;
        end
    end
end

% If neither of us is winning, place the disc at a place that makes the
% longest possible sequence.
i = 2;
while (i <= nToWin)
    updatedBoard = board;
    potential1 = [0 0 0];
    potential2 = [0 0 0];
    temp = IsWin3d(updatedBoard,nToWin-i);
    
    if (~isempty(temp))
        changedIndex = temp.finish-temp.start;
        dim1Changed = logical(changedIndex(1));
        dim2Changed = logical(changedIndex(2));
        dim3Changed = logical(changedIndex(3));
        
        % If we can't find anything
        if(i==nToWin)
            potentialDim2 = ceil(rand()*size(board,2));
            potentialDim3 = ceil(rand()*size(board,3));
            updatedBoard(1,potentialDim2,potentialDim3)=true;
            return;
        end
        
        % If diagonaly changed.
        if (dim1Changed&&dim2Changed&&dim3Changed)
            potential = [temp.finish(1)+1,temp.finish(2)+1,temp.finish(3)+1];
            bInRange = InRangeG3(board,potential);
            bGravity = GravityG3(board,potential);
            if (bInRange && bGravity && ~logical(board(potential(1),potential(2),potential(3))))
                updatedBoard(potential(1),potential(2),potential(3))=true;
                return;
            end
        end
        
        % If we only played 1 disc, or If we havn't played anything yet
        if (i==nToWin-1)
            potential = temp.finish;
            % If there is occupied which means we only played 1 disc
            if(board(potential(1),potential(2),potential(3)))
                directionToPick = ceil(rand()*3);
                potential(directionToPick)=potential(directionToPick)+1;
                bInRange = InRangeG3(board,potential);
                bGravity = GravityG3(board,potential);
                if (bInRange)
                    bOccupied = 1;
                    while (bOccupied)
                        bOccupied = logical(board(potential(1),potential(2),potential(3)));
                        potential(directionToPick)=potential(directionToPick)-1;
                        directionToPick = ceil(rand()*3);
                        potential(directionToPick)=potential(directionToPick)+1;
                        bOccupied = logical(board(potential(1),potential(2),potential(3)));
                    end
                    if (bGravity && ~bOccupied)
                        updatedBoard(potential(1),potential(2),potential(3))=true;
                        return;
                    end
                % If we havn't played anything.
                else
                    updatedBoard(potential(1),potential(2),potential(3))=true;
                    return;
                end
            end
        end
        
        if(dim1Changed)
            potential1(1) = temp.finish(1)-1;
            potential1(2) = temp.finish(2);
            potential1(3) = temp.finish(3);
            potential2(1) = temp.finish(1)+1;
            potential2(2) = temp.finish(2);
            potential2(3) = temp.finish(3);
        end
        if(dim2Changed)
            potential1(1) = temp.finish(1);
            potential1(2) = temp.finish(2)-1;
            potential1(3) = temp.finish(3);
            potential2(1) = temp.finish(1);
            potential2(2) = temp.finish(2)+1;
            potential2(3) = temp.finish(3);
        end
        if(dim3Changed)
            potential1(1) = temp.finish(1);
            potential1(2) = temp.finish(2);
            potential1(3) = temp.finish(3)-1;
            potential2(1) = temp.finish(1);
            potential2(2) = temp.finish(2);
            potential2(3) = temp.finish(3)+1;
        end
             
        % Check range and gravity and place the disc.
        bInRange = InRangeG3(board,potential1);
        bGravity = GravityG3(board,potential1);
        if (bInRange && bGravity && ~board(potential1(1),potential1(2),potential1(3)))
            updatedBoard(potential1(1),potential1(2),potential1(3)) = true;
            return;
        else
            bInRange = InRangeG3(board,potential2);
            bGravity = GravityG3(board,potential2);
            if (bInRange && bGravity && ~board(potential2(1),potential2(2),potential2(3)))
                updatedBoard(potential2(1),potential2(2),potential2(3)) = true;
                return;
            end
        end
    end
    
    i = i+1;
end

end



