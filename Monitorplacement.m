%print the purpose of this script and define coordinate system basics
fprintf('\n\nThis script is designed to help with the placement of a 6 inch wide monitor \nin an experiment where a mouse completes a visual task in \na monocular field of vision.  You must input coordinates for the location of the \nmouse left eye in inches relative to a reference point of your choice.  Ensure all units.\nCoordinate system is top view of setup with mouse facing forward. \nX is positive to the left of mouse and Y is positive in front of mouse.')

%get the x and y coordinates of the mouse's left eye in relation to a
%reference point and how far the user would like the monitor to be from the
%eye and the desired angle of the screen
xeye=input('\n\nWhat is the x coordinate of the left eye in relation to your reference point?  ');
yeye=input('\nWhat is the y coordinate of the left eye in relation to your reference point?  ');
distance=input('\nHow far from the mouse would you like the monitor to be?  ');
%Make sure user is aware of the minimum and logical maximum restraints
while (distance<=4)
    fprintf('\nThe screen should be more than 4 inches from the mouse for optimal viewing')
    distance=input('\nHow far from the mouse would you like the monitor to be?  ');
end
if (distance>=8)
    fprintf('\n8 inches is getting rather far away although is possible for the mouse to see')
    distance=input('\nPlease input a new value for screen distance or confirm previous input.  ');
end
angle=input('\nWould you like the screen to be parallel to the mouse or at a 25 degree angle [type parallel or angle]?  ','s');
%Check response
while (~strcmp(angle,'parallel') && ~strcmp(angle,'angle'))
    angle=input('\nPlease type parallel or angle  ','s');
end


%User input section complete, now time for numerical analysis

if (strcmp(angle,'parallel'))
    %First we will deal with parallel case. First both x coordinates can be set simply to the distance the monitor is
    %away from the mouse's eye mlx is x coordinate of left side of monitor.
    %mrx is x coordinate of right side of monitor.  same convention will be
    %used for y
    mlx=xeye+distance;
    mrx=xeye+distance;
    %in parallel setup left side of monitor simply follows 120 degree line from
    %mouse's eye to stay in good field of vision and right side is simply 6
    %inches ahead of this point
    mly=yeye-.577*distance;
    mry=mly+6;
elseif(strcmp(angle,'angle'))
    %If the screen is angled, first we find the right side of the monitor
    %by following the 40 degree line (staying outside of binocular zone
    mrx=xeye+distance*.643;
    mry=yeye+distance*.766;
    %and then follow the angle of the screen to find the left side for 6
    %inch long screen
    mlx=mrx+6*.423;
    mly=mry-6*.906;
end

%Now we have the coordinates for the left and right side of the screen and
%simply return them to the user
fprintf('\n\nThe monitor should be placed such that the left side of the screen is above \nthe coordinate (%f,%f)inches \nand the right side of the screen is above \nthe coordinate (%f,%f)inches \nrelative to your reference point.\n\n',mlx,mly,mrx,mry)






