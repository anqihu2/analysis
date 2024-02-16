% Adult ASL Activation Extraction based on Individualized LangLoc Masks (GCSS Method)
% 022 and 029 and 040 have ASL, but do not have langloc
% Please refer to indiv_langloc_sl.m for specific information
DIR_LIST = dir ('/Volumes/data/projects/blast/data/mri/imaging/scott_gcss_lpsa/data/nilearn_pipeline/fedorenko_mask/indiv_langloc_parcels/asl_str_minus_rand/adult/');

opts = []

for i = 1:length(DIR_LIST)

    EXT_DIGIT = regexp(DIR_LIST(i).name,'\d*','Match')

    if not(isempty(EXT_DIGIT))
        if not(ismember(EXT_DIGIT, ['022', '029', '040']))
            % indiv_langloc_sl_str_rand(opts, group, prefix, part_id)
            indiv_langloc_sl_str_rand(opts, 'adult', 'blast_a_', DIR_LIST(i).name)
        end
    end
end

indiv_langloc_sl_str_rand(opts, 'adult', 'blast_a_', '044')

% Child ASL Activation Extraction based on Individualized LangLoc Masks (GCSS Method)

DIR_LIST = dir ('/Volumes/data/projects/blast/data/mri/imaging/scott_gcss_lpsa/data/nilearn_pipeline/fedorenko_mask/indiv_langloc_parcels/asl_str_minus_rand/child/');

for i = 1:length(DIR_LIST)

    EXT_DIGIT = regexp(DIR_LIST(i).name,'\d*','Match')

    if not(isempty(EXT_DIGIT))
        if not(ismember(EXT_DIGIT, '034'))
            indiv_langloc_sl_str_rand(opts, 'child', 'blast_c_', DIR_LIST(i).name)
        end
    end
end

indiv_langloc_sl_str_rand(opts, 'child', 'blast_c_', '170')
