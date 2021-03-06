function h = showskeletons_joints(im, points, pa, msize, torsobox)
if nargin < 4
  msize = 4;
end
if nargin < 5
  torsobox = [];
end
p_no = numel(pa);

switch p_no
  case 26
    partcolor = {'g','g','y','r','r','r','r','y','y','y','m','m','m','m','y','b','b','b','b','y','y','y','c','c','c','c'};
  case 14
    partcolor = {'g','g','y','r','r','y','m','m','y','b','b','y','c','c'};
  case 10
    partcolor = {'g','g','y','y','y','r','m','m','m','b','b','b','y','c','c'};
  case 18
    partcolor = {'g','g','y','r','r','r','r','y','y','y','y','b','b','b','b','y','y','y'};
  otherwise
    error('showboxes: not supported');
end
h = imshow(im); hold on;
if ~isempty(points)
  x = points(:,1);
  y = points(:,2);
  v = points(:,3);
  for n = 1:size(x,1)
    for child = 2:p_no
      parent = pa(child);
      x1 = x(pa(child));
      y1 = y(pa(child));
      x2 = x(child);
      y2 = y(child);
      if v(child) ~= -1
        plot(x1, y1, 'o', 'color', partcolor{child}, ...
          'MarkerSize',msize, 'MarkerFaceColor', partcolor{child});
      end
      
      if v(child)~= -1 && v(parent)~=-1
        plot(x2, y2, 'o', 'color', partcolor{child}, ...
          'MarkerSize',msize, 'MarkerFaceColor', partcolor{child});
        line([x1 x2],[y1 y2],'color',partcolor{child},'linewidth',round(msize/2));
      end
    end
  end
end
if ~isempty(torsobox)
  plotbox(torsobox,'w--');
end
drawnow; hold off;
