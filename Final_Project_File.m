% Traffic Flow Model on 101 Freeway using Monte Carlo Simulation


% Number of vehicles on the road (100 vehicles are selected at random)
%we can change this based on realtime dataset or apply random logic to select
%any 100/N vehicles from the dataset
Selected_vehicles = 100; 

% Simulation time in seconds (1 minute) this is selected to be 1 minute so
% that the simulation runs quickly
sim_time = 60; 

% Vehicle position is updated using the steps (this assumes 1-second time period)
steps = 60; 


% Total segement of the road in miles under study
road_len = 1; 

% Speed and acceleration of vehicles is based on normal distribution

% Mean speed in mph (based on average speed on 101 freeway)
mean_speed = 70; 

% Standard deviation in speed between vehicles in mph
std_speed = 10; 

% Initializing vehicle positions all vehicles start from position 0
positions = zeros(1, Selected_vehicles); 

% Initializing speed using normrnd to generate a single random value for each vehicle using the standard normal distribution.
vehicle_speeds = normrnd(mean_speed, std_speed, 1, Selected_vehicles); 

% To check if vehicle is on the road
on_road = true(1, Selected_vehicles); 

%Initializing variacle to store average speed value
avg_speed = zeros(1, Selected_vehicles);

% Initializing variable to store cumulative average speed
cum_avg_speed = zeros(1, steps);

% Simulation run Loop till maximum step
for t = 1:steps

    % Update positions based on speeds for vehicles still on the road speed is given in miles per hour, and the time is in seconds. 
    % Since the simulation is using 1-second time intervals (time_steps = 60), the division by 3600 is used to convert the speed from miles per hour to miles per second.
    positions(on_road) = positions(on_road) + vehicle_speeds(on_road) / 3600;
    
    % Sorting the positions and calculating the distances between consecutive vehicles.
    dist_inbetween_vehi = diff(sort(positions));
    
    % Randomly updating speeds using a Monte Carlo process for vehicles that are on the road
    %The accelerations is using normal distribution with a mean of 0 and a standard deviation of 2. 
    % This randomness to acceleration, is stimulating driver behavior or road conditions.
    accel = normrnd(0, 2, 1, Selected_vehicles); 

    %The randomly generated acceleration is added with current speed of the
    %vehicles
    vehicle_speeds(on_road) = vehicle_speeds(on_road) + accel(on_road);
    
    % To stimulate close to real speeds on free we include speed limits
    % such that the vechicle speed is between 60 and 85
    vehicle_speeds(vehicle_speeds < 60) = 60;
    vehicle_speeds(vehicle_speeds > 85) = 85;
    
    % This to make sure that there is  between vehicles are maintained
    vehicle_speeds(dist_inbetween_vehi < 0.05) = max(vehicle_speeds(dist_inbetween_vehi < 0.05), 60);
    
    % Once the vehicle reaches end of the road we have to make sure that
    % the on road condition is set to false
    exceeded_end = positions + vehicle_speeds / 3600 > road_len;
    on_road(exceeded_end) = false;
    
    % Bar chart for each vehicle's speed during simulation
    % Creating a subplot grid with 2 rows and 1 column
    %It selects the second subplot (bottom subplot) as the current subplot.
    subplot(2, 1, 2);
    bar(round(vehicle_speeds(on_road)));

    % Adjusting the limit of the y-axis to 90 mph as the maximum speed set is 85mph
    ylim([0, 90]); 
    xlabel('Vehicle Number');
    ylabel('Speed in mph');
    title(['Vehicle Speeds at step: ' num2str(t) ' seconds']);
    drawnow;
    
    % Plot the simulation
    % Creating a subplot grid with 2 rows and 1 column
    % It selects the first subplot (top subplot) as the current subplot.
    subplot(2, 1, 1);

    % Creating a scatter plot of vehicle positions on x-axis with y-axis = 0. 
    % The size of each point is set to 75.
    scatter(positions(on_road), zeros(1, sum(on_road)), 75); 

    % Adjusting the limit of the x-axis to road length as maximum road
    %length is 1 mile
    xlim([0, road_len]);

    % Adjusting the limit of the y-axis as it is set to 0
    ylim([-1, 1]);

    xlabel('Distance in miles');
    title(['Traffic Flow Simulation at step: ' num2str(t) ' seconds']);
    
    drawnow;

    % Calculating the traffic density using the length of road and vehicles
    % on the road at that time
    traffic_densi = sum(on_road) / road_len;
    disp(['Traffic Density at step ' num2str(t) ':' num2str(round(traffic_densi)) ' vehicles/mile']);

    % Calculating average speed at each simulation step
    avg_speed = round(mean(vehicle_speeds(on_road)));
    disp(['Average Traffic Speed at step ' num2str(t) ':' num2str(avg_speed) ' mph']);

    % Updating the cumulative average speed of all vehicles during the entire simulation 
    % only if average_speed doesn't have error
    if ~isnan(avg_speed)
        cum_avg_speed(t) = avg_speed;
    end
end

% Remove error entries from cumulative_avg_speed to error free cummulati
cum_avg_speed = cum_avg_speed(~isnan(cum_avg_speed));

% Calculating average speed of all vehicles during the entire simulationof average speeds
avg_speed_all_vehi = round(mean(cum_avg_speed));

disp(['All Vehicle Average Traffic Speed during simulation: ' num2str(avg_speed_all_vehi) ' mph']);
