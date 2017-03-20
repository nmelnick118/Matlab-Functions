% Start reading in files
cd /Users/Nitai/Desktop/TimeCourses/'TimeCourse 0224'/CB15N;

files = dir('*pill_MESH.mat');
data = [];
time = [];
for i = 1:length(files)
    cells = load(files(i).name);
    C = strsplit(files(i).name, {'t', '_'});
    timestamp = char(C(3));
    timestamp = str2double(timestamp);
    % max_min = TwotoCenter(cells, 0);
    
    max_min = AreaPerimRatio(cells); % (larger value is LESS pointy!)
    max_min = transpose(max_min);
    
    temptime = [];
    for i = 1:length(max_min)
        temptime(i) = timestamp;
    end
    time = horzcat(time, temptime);
    
    data = vertcat(data, max_min);
end
time = transpose(time);
data = horzcat(data, time);
table = array2table(data);
table.Properties.VariableNames = {'SmallPole', 'LargePole', 'Time'};

name = sprintf('%s.txt', char(C(1))); 
writetable(table, name);

figure
scatter(table.Time, table{:, 'SmallPole'});

