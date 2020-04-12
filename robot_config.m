global robot
global current_axis
global time

global detection_snr_db
global motor_1_snr motor_2_snr
global robot_figure

% ex 2
global wall_sensors
global wall_acc_sensors
global flashing_sensors
global floor_sensors

global track
global wall
global ir_emitters
% end ex 2 vars

% get robot things in to the path
s = pwd;
s = strcat(s, '\..\robot_sim');
addpath(s);

% set noise level
detection_snr_db = 65;
motor_1_snr = 0;
motor_2_snr = 0;

% ex 2
% set IR flashing emitters positions and frequencies
ir_xy = [];
ir_emitters = [];

% set wall corners
%wall = [-20, -10; 20, -10];
space_gen();

% set track corners
track = [];

% add floor sensors
floor_sensors = [];

% add wall sensors here
%wall_sensors = [5, 0, -pi/2; -2, 2, -pi/2];

% center of robot facing "down" (towards negative y)
%wall_sensors = [0, 0, -pi/2];

% -60 degrees (looking forward 30 degrees)
wall_sensors = [0, 0, -pi/3];
wall_acc_sensors = [];

% add flashing sensors here
flashing_sensors = [];
% end ex 2 wall and sensors

% set robot starting position
%robot = [0, 0, 0];
%robot = [10, -10, 1/2]

% with ir sensor set to center of robot...
%ir_dist_cm = 22; % ir sensor distance to wall in centimeters
%ir_dist_in = ir_dist_cm * 0.393701; % convert cm to inches

robot = [0, 14, 0]; % [x y theta] in inches and radians

% Open simulation plot window
if length(robot_figure) == 0
    robot_figure = figure();
    hold on
else
    figure(robot_figure);
end

current_axis = axis();

plot_wall();

% set initial time
time = 0;

