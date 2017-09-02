function [Ic, T] = carv(I, nr, nc)
% I is the image being resized
% [nr, nc] is the numbers of rows and columns to remove.
% Ic is the resized image
% T is the transport map

T = zeros(nr+1, nc+1);
TI = cell(nr+1, nc+1);

TI{1,1} = I;
T(1,1) = 0;
% TI is a trace table for images. TI{r+1,c+1} records the image removed r rows and c columns.
for i = 2:nr+1
    %removing i-1 rows
    e = genEngMap(TI{i-1,1});
    [My, Tby] = cumMinEngHor(e);
    [TI{i, 1}, E] = rmHorSeam(TI{i-1,1}, My,Tby);
    T(i,1) = T(i-1,1) + E;
end

for j = 2:nc+1
    %removing j -1 columns
    e = genEngMap(TI{1,j-1});
    [Mx, Tbx] = cumMinEngVer(e);
    [TI{1, j}, E] = rmVerSeam(TI{1, j-1}, Mx, Tbx);
    T(1, j) = T(1,j-1) + E;
end

for i = 2:nr+1
    for j = 2:nc+1
        if isempty(TI{i,j}) == 1

            %vertical seam option
            ev = genEngMap(TI{i,j-1});
            [Mx, Tbx] = cumMinEngVer(ev); 
            [vertImg, vertCost ] = rmVerSeam(TI{i, j-1}, Mx, Tbx);
            vertCost = T(i,j-1) + vertCost;
            
            %horizontal seam option
            eh = genEngMap(TI{i-1,j});
            [My, Tby] = cumMinEngHor(eh);
            [horImg, horCost] = rmHorSeam(TI{i-1,j}, My,Tby);
            horCost = T(i-1,j) + horCost;
            
            if horCost < vertCost
                T(i,j) = horCost;
                TI{i,j} = horImg;   
            else
                T(i,j) = vertCost;
                TI{i,j} = vertImg;
            end
        end
    end
end
Ic = TI{nr + 1,nc + 1};
end