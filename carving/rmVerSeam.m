function [Ix, E] = rmVerSeam(I, Mx, Tbx)
% I is the image. Note that I could be color or grayscale image.
% Mx is the cumulative minimum energy map along vertical direction.
% Tbx is the backtrack table along vertical direction.
% Ix is the image removed one column.
% E is the cost of seam removal

[nx, ny, ~] = size(I);
rmIdx = zeros(nx, 1);
%% Add your code here
i = nx;
[E, min_col] = min(Mx(i,:));

while i >= 1
    rmIdx(i) = min_col;
    I(i, min_col, 1) = 255;
    I(i, min_col, 2) = 0;
    I(i, min_col, 3) = 0;
    
    bk = Tbx(i, min_col);
    i = i - 1;
    min_col = min_col + bk - 2;
end

Ix = I;
for i = 1:nx
    j = rmIdx(i);
    Ix(i, j:ny-1, :) = I(i, [j:ny-1] + 1,:);
end
Ix(:,end,:) = [];
%figure;    %uncomment this to print interdmediate seams
%imshow(I);
end