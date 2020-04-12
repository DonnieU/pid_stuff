close all;
if(~isempty(timerfind))
    stop(timerfind)
    delete(timerfind);
end
clear all;
clear class
clear classes

disp('place breakpoints now - type dbcont');
%keyboard

robot_config;

b = robot_analoginput();
c = robot_analogoutput();

addchannel(b, 0);
b.in = ['W1'];

% ex 2
%addchannel(b, [0 1]);
%b.in = ['W1'; 'W2'];

addchannel(c, [0 1]);
c.out = ['M0'; 'M1'];

putsample(c, [2.5 2.5]);

disp('type dbcont to continue');
%keyboard

% 10th degree polynomial from polyfit testing.
% diverges > 2.1
p = [1.52103926409912 -32.0882797729619 280.338070697342 -1350.42647978742 4001.56804605317 -7662.35861242234 9646.82309250794 -7928.71578858704,4110.05362984887 -1240.68347841151 179.200700187371];


base_speed = 4;
putsample(c, [base_speed base_speed]);

kp = 1.0;
kd = 1.0;

prev_error = 0.0;
target_dist = 6; % inches from wall
steps = 2500;
%ir_temp_data = zeros(1,10);
e = zeros(1,steps);
meas_dist = zeros(1,steps);


for i=1:steps
    % attempt to normalize reading at current point
    %for j=1:10
    %    ir_temp_data(j) = getsample(b);
    %end
    
    %curr_dist = polyval(p,mean(ir_temp_data));
    curr_dist = polyval(p,mean(getsample(b)));
    curr_error = target_dist - curr_dist;
    e(i) = (curr_error);
    kd_error = prev_error - curr_error;
    prev_error = curr_error;
    adjustment = kp*curr_error + kd*kd_error;
    
    lspeed = base_speed + adjustment/2;
    rspeed = base_speed - adjustment/2;
    putsample(c, [lspeed rspeed]);

    %error = (target_dist - curr_dist);
    meas_dist(i) = (curr_dist);
  
    
%     if exist('h')
%         delete(h);
%     end
%     figure(2)
%     h = plot(e);
    
    pause(0.02);
    
end

putsample(c, [2.5 2.5]);
stop(timerfind)
delete(timerfind)
%figure(3)
plot(e)


robot_stop;