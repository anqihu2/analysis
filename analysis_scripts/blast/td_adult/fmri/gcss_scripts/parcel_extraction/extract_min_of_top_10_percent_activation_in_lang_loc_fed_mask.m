%% This script is to extract the minimum activation in the Alice langugage localizer task for each participant within the group constrained lang loc mask that is made by the make_my_parcel.m script
function run_froi_resp_mag(opts)

%% Measure response magnitudes in frois

opts.PROJECT_DIR = '/Volumes/data/projects/blast/data/mri/imaging/scott_gcss_lpsa/';
%% Read in a lang loc group-constrained masks that are already resampled to a random subject's lang loc mask
%% Command to resample a mask (require afni installed): 3dresample -input unsampled_gc_mask -master reference_mask -prefix file_prefix
opts.PARCEL_DIR = [opts.PROJECT_DIR 'data/nilearn_pipeline/fedorenko_mask/resampled_seg_parcels/'];
% Read in a list of IDs that is generated before this step and that indexes
% all the subject's lang loc z-stat files
opts.SUBJ_NAME_LIST = [opts.PROJECT_DIR 'data/nilearn_pipeline/langloc_combined.txt'];
opts.SUBJ_DEFINE_DATA_DIR = [opts.PROJECT_DIR 'data/nilearn_pipeline/combined/td_adult/'];
%
opts.RESULTS_DIR = [opts.PROJECT_DIR 'data/nilearn_pipeline/fedorenko_mask/indiv_langloc_parcels/'];
if ~exist(opts.RESULTS_DIR,'dir')
    mkdir(opts.RESULTS_DIR)
end
%
 % Conditions to measure
 % Change subject numbers
opts.SUBJ_IDS = 1:57;
% Change parcel numbers
opts.VOL_VALS = 1:12;

%% Load parcels
ck = dir(opts.PARCEL_DIR)
ck(1,:) = []
ck(1,:) = []
for i = 1:length(opts.VOL_VALS)
    PARCEL_NUM_STR{i} =[ck(i).name];
    match = ['.nii', '.gz'];
    PARCEL_NUM_STR{i} = erase(PARCEL_NUM_STR{i},match)
end
disp(PARCEL_NUM_STR)
disp(PARCEL_NUM_STR{1})


for i = 1:length(opts.VOL_VALS);
    parcel = MRIread([opts.PARCEL_DIR ck(i).name],0);
    PARCEL_VOL = parcel.vol;
    PARCEL_VOLS{i} = PARCEL_VOL;
end



%% For each parcel...

n_subjs = length(opts.SUBJ_IDS);
n_parcels = length(opts.VOL_VALS);

% For each subject
for i = 1:n_subjs

    % Load stat map for defining frois
    DEFINE_VOL = MRIread([opts.SUBJ_DEFINE_DATA_DIR num2str(opts.SUBJ_IDS(i)) '_stat-z_statmap.nii.gz'],0);
    % Load cope(s) for measuring response
    % For each parcel
    for j = 1:n_parcels;
        temp_mask = PARCEL_VOLS{1,j};
        mean_in_roi(i,j) = MeanCopeFROI(temp_mask,DEFINE_VOL.vol);

    end

end


%% Setup results structure
ID = fileread(opts.SUBJ_NAME_LIST);
SUBJ_ID_STR = strsplit(ID)
disp(SUBJ_ID_STR)
results = array2table(mean_in_roi,'VariableNames',PARCEL_NUM_STR,'RowNames',SUBJ_ID_STR);
disp(results)

writetable(results, '/Volumes/data/projects/blast/data/mri/imaging/scott_gcss_lpsa/data/nilearn_pipeline/fedorenko_mask/indiv_langloc_parcels/langloc_minimum_top_10_data.csv', 'WriteRowNames', true)

end

function mean_in_roi = MeanCopeFROI(parcel_mask_vol,defining_vol)

% Mask defining volume with parcel
% Parcel mask should just be ones and zeros
voxel_idxs_in_parcel = find(parcel_mask_vol);

% Find top 10% of voxels
defining_data_voxel_values = defining_vol(voxel_idxs_in_parcel);
[~,sorted_voxel_idxs] = sort(defining_data_voxel_values,1,'descend');

n_voxels = length(voxel_idxs_in_parcel);
tenpct_n_voxels = round(n_voxels*0.10);

tenpct_sorted_voxel_idxs = sorted_voxel_idxs(1:tenpct_n_voxels);

get_min = defining_data_voxel_values(tenpct_sorted_voxel_idxs)
mean_in_roi = min(get_min)
end
