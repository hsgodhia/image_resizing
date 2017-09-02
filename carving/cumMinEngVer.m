function [Mx, Tbx] = cumMinEngVer(e)
% e is the energy map.
% Mx is the cumulative minimum energy map along vertical direction.
% Tbx is the backtrack table along vertical direction.

[nx,ny] = size(e);
Mx = ones(nx, ny).*255;
Tbx = zeros(nx, ny);
Mx(1,:) = e(1,:);

%% Add your code here
%using 1,2,3 for the backtrack table
for i = 2:nx
    left = [NaN Mx(i-1,1:end-1)]';
    center = Mx(i-1,:)';
    right = [Mx(i-1,2:end) NaN]';
    vals = [left center right];
    [min_val, min_ind] = min(vals, [], 2); 
    Mx(i,:) = e(i,:) + min_val';
    Tbx(i,:) = min_ind';
end
end