function [My, Tby] = cumMinEngHor(e)
% e is the energy map.
% My is the cumulative minimum energy map along horizontal direction.
% Tby is the backtrack table along horizontal direction.

[nx,ny] = size(e);
My = ones(nx, ny).*255;
Tby = zeros(nx, ny);
My(:,1) = e(:,1);

for j = 2:ny
    left = [NaN;My(1:end-1, j-1)];
    center = My(:, j-1);
    right = [My(2:end, j-1); NaN];
    vals = [left center right];
    [min_val, min_ind] = min(vals, [], 2); 
    My(:,j) = e(:, j) + min_val;
    Tby(:, j) = min_ind;
end
end