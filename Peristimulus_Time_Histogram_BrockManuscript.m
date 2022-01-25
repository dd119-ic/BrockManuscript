%% Peristimulus Timed Histogram Calculation

% Author: Deyl Djama
% Institution: Imperial College London

% Step 1: Calculate the delta between each input & output, then store, trim and rearrange
% the data.

stored_data = cell(length(opto_time_8hz),2);
for i = 1:length(opto_time_8hz)
    dt =  event_time_8hz - opto_time_8hz(i);
    stored_data(i,:) = {i dt};
    stored_data_trimmed = stored_data(:,2);
    rearranged_data = reshape(stored_data_trimmed, 1, []);
end

% Step 2: Convert the data from cell to array and reshape

final_data = cell2mat(rearranged_data);

reshaped_final_data = reshape(final_data,[],1);

% Step 3: Limit the window of event delta to [-2 2] to reduce the matrix
% size and detect events that fall within [-2 2] seconds of the input.

xMin = -2;
xMax = 2;
reshaped_final_data(reshaped_final_data <= xMin |reshaped_final_data >= xMax) = [];

% Step 4: Plot the Peristimulus Time Histogram for the delta that falls
% within [-2 2] seconds at a binwidth of 1ms

figure()
h2 = histogram(reshaped_final_data, 'BinWidth', 0.001), xlim([-0.5 0.5]); ylim([0 10]); xlabel('Time (seconds)'); ylabel('Count');


% Step 5: Extract the BinCounts variable and divide by total number of
% inputs at different frequencies to produce the density.


BinCounts_reshaped_h2 = reshape(h2.BinCounts, [], 1);

% 8 Hz
% BinCounts_reshaped_h2 = BinCounts_reshaped_h2/960;

% 10 Hz
% BinCounts_reshaped_h2 = BinCounts_reshaped_h2/1200;


% Step 6: Extract the BinEdges variable for plotting against the BinCounts density and further
% analysis.

BinEdges_reshaped_h2 = reshape(h2.BinEdges, [], 1);

% End of script

