function info = ThreedDiag(board,nInRow)
info.start = [];
info.finish = [];
extractedDiag = zeros(1,size(board,3));
varChanged = false;

% Facet 1.
for m = 1:size(board,1)
    for n = 1:size(board,2)
        
        % Direction 1.
        i = m;
        j = n;
        k = 1;
       
        while (i-1>=0 && j-1>=0 && k+1<=size(board,3)+1)
            extractedDiag(k) = board(i,j,k);
            varChanged = true;
            i = i-1;
            j = j-1;
            k = k+1;
        end
        if (find(extractedDiag))
            temp = IsWin1d(extractedDiag,nInRow);
            if (~isempty(temp))
                info.start = [m-temp(1)+1,n-temp(1)+1,temp(1)];
                info.finish = [m-temp(2)+1,n-temp(2)+1,temp(2)];
                return;
            end
        end
        
        % Direction 2.
        if(varChanged)
            i = m;
            j = n;
            k = 1;
            varChanged = false;
        end
        
        while (i-1>=0 && j+1<=size(board,2)+1 && k+1<=size(board,3)+1)
            extractedDiag(k) = board(i,j,k);
            varChanged = true;
            i = i-1;
            j = j+1;
            k = k+1;
        end
        if (find(extractedDiag))
            temp = IsWin1d(extractedDiag,nInRow);
            if (~isempty(temp))
                info.start = [m-temp(1)+1,n+temp(1)-1,temp(1)];
                info.finish = [m-temp(2)+1,n+temp(2)-1,temp(2)];
                return;
            end
        end
        
        % Direction 3.
        if(varChanged)
            i = m;
            j = n;
            k = 1;
            varChanged = false;
        end
        
        while (i+1<=size(board,1)+1 && j+1<=size(board,2)+1 && k+1<=size(board,3)+1)
            extractedDiag(k) = board(i,j,k);
            varChanged = true;
            i = i+1;
            j = j+1;
            k = k+1;
        end
        if (find(extractedDiag))
            temp = IsWin1d(extractedDiag,nInRow);
            if (~isempty(temp))
                info.start = [m+temp(1)-1,n+temp(1)-1,temp(1)];
                info.finish = [m+temp(2)-1,n+temp(2)-1,temp(2)];
                return;
            end
        end
        
        % Direction 4.
        if(varChanged)
            i = m;
            j = n;
            k = 1;
            varChanged = false;
        end
        while (i+1<=size(board,1)+1 && j-1>=0 && k+1<=size(board,3)+1)
            extractedDiag(k) = board(i,j,k);
            varChanged = true;
            i = i+1;
            j = j-1;
            k = k+1;
        end
        if (find(extractedDiag))
            temp = IsWin1d(extractedDiag,nInRow);
            if (~isempty(temp))
                info.start = [m+temp(1)-1,n-temp(1)+1,temp(1)];
                info.finish = [m+temp(2)-1,n-temp(2)+1,temp(2)];
                return;
            end
        end
        
    end
end
end



