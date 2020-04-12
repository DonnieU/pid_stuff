function space_gen()

global wall;

wall = [-100 0];
wall = add_track_point(wall, 1000, 0);


% eliminate duplicate wall points. These cause a problem in drive_robot
Npts = length(wall(:,1));
I = [];
for kk = 1:Npts - 1
    if(wall(kk,:) == wall(kk+1,:))
        I = [I kk+1];
    end
end
wall(I,:) = [];