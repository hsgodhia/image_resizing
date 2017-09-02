function [Iy, E] = rmHorSeam(I, My, Tby)
% I is the image. Note that I could be color or grayscale image.
% My is the cumulative minimum energy map along horizontal direction.
% Tby is the backtrack table along horizontal direction.
% Iy is the image removed one row.
% E is the cost of seam removal

[nx, ny, ~] = size(I);
%fprintf('hor: %d %d\n', nx, ny);
rmIdy = zeros(1, ny);

%% Add your code here
j = ny;
[E, min_row] = min(My(:,j));

while j >= 1
    bk = Tby(min_row,j);
    rmIdy(j) = min_row;
    I(min_row, j, 1) = 255;
    I(min_row, j, 2) = 0;
    I(min_row, j, 3) = 0;
    min_row = min_row + bk - 2;
    j = j - 1;
end

Iy = I;
for j= 1:ny
    i = rmIdy(j);
    Iy(i:nx-1, j, :) = I([i:nx-1] + 1,j,:);
end

Iy(end,:,:) = [];
%figure;
%imshow(I);
end