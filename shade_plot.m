function h = shade_plot(ax, x, y, varargin)
%SHADE_PLOT Make a patch that has alpha value instead of a line
%
%   h = ui.shade_plot(ax, x, y, 'Name', value,...);
%
% Inputs
%   ax - Axes (target) handle
%   x  - X-axis vector values
%   y  - Y-axis vector values
%   varargin - (Optional) 'Name', value pairs from built-in `patch`
%
% Output
%   h - Patch object that is like a line except it is transparent.
%
% See also: Contents, patch

x = reshape(x, numel(x), 1);
y = reshape(y, numel(y), 1);
data = [x, y];

coeff = pca(data);

T = ([0 -0.5; 0.5 0] * coeff(:, 1))'; % Rotate to perpendicular

A = data + T;
B = flipud(data - T);
V = [A; B];
F = [1:size(V,1), 1];

c = validatecolor('#2b68d9');
h = patch('Faces', F, 'Vertices', V, ...
    'Parent', ax, ...
    'FaceAlpha', 0.33, ...
    'FaceColor', c, ...
    'EdgeColor', 'none', ...
    varargin{:});

end