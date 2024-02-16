% Adult ASL Activation Extraction based on Individualized Dorsal Attention
% Network (GCSS Method)
% 022 and 029 and 040 do not have ASL, but have langloc
% Please refer to indiv_att_sl.m for specific information
DIR_LIST = dir ('/Volumes/data/projects/blast/data/mri/imaging/scott_gcss_lpsa/data/nilearn_pipeline/fedorenko_mask/indiv_langloc_parcels/asl_str_minus_rand/adult/');

for i = 1:length(DIR_LIST)

    EXT_DIGIT = regexp(DIR_LIST(i).name,'\d*','Match')

    if not(isempty(EXT_DIGIT))
        % indiv_att_sl(opts, group, prefix, part_id)
        indiv_att_sl(opts, 'adult', 'blast_a_', DIR_LIST(i).name)
    end
end



% Child ASL Activation Extraction based on Individualized Dorsal Attention
% Network (GCSS Method)

DIR_LIST = dir ('/Volumes/data/projects/blast/data/mri/imaging/scott_gcss_lpsa/data/nilearn_pipeline/fedorenko_mask/indiv_langloc_parcels/asl_str_minus_rand/child/');

for i = 1:length(DIR_LIST)

    EXT_DIGIT = regexp(DIR_LIST(i).name,'\d*','Match')

    if not(isempty(EXT_DIGIT))
        indiv_att_sl(opts, 'child', 'blast_c_', DIR_LIST(i).name)
    end
end
