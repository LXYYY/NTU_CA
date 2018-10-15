function winId = SOMCompete(x, w)

xs=repmat(x, size(w,1), 1);

d=EuclidDist(xs, w);
[~,winId]=min(d);
