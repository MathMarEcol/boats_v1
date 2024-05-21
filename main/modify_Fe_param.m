function ens_param = modify_Fe_param(kfei,path, ens_d)
%     load(['/Users/kimscherrer/Documents/PhD/BOATS/BOATS_VB1/ensemble_parameters.mat'])
%     load(['/home/kscherrer/BOATS/BOATS_VB1_regsim/ensemble_parameters.mat'])
    load(ens_d)
%     cd 'Nitrate Files'
%     load(['/home/kscherrer/BOATS/BOATS_VB1_regsim/input/nitrate_files/woa05_lat']);
    load(['' path 'input/nitrate_files/woa05_lat_original.mat'],'lat')
%     load(['/home/kscherrer/BOATS/BOATS_VB1_regsim/input/nitrate_files/woa05_lon']);
    load(['' path 'input/nitrate_files/woa05_lon_original.mat'],'long')
%     load(['/home/kscherrer/BOATS/BOATS_VB1_regsim/input/nitrate_files/woa05_min_no3']);
    load(['' path 'input/nitrate_files/woa05_min_no3_original.mat'],'min_no3')
%     cd ..
    nlat = size(lat,1);
    nlon = size(long,1);
    te_no3 = zeros(5,nlat(1),nlon(1));
    tro_sca_no3 = zeros(5,nlat(1),nlon(1));
    kfe = kfei;
    for ens=1:5
        for i=1:nlat
            for j=1:nlon
                if isnan(min_no3(i,j))         % if there's no no3 limitation??
                    te_no3(ens,i,j) = ens_param.te(ens); % choose the transfer efficiency from the parameter ensemble
                    tro_sca_no3(ens,i,j) = ens_param.tro_sca(ens); % choose the trophic scaling from param ens
                else
                    te_no3(ens,i,j) = ens_param.te(ens)*(1 - (min_no3(i,j)/(kfe + min_no3(i,j))));
                    tro_sca_no3(ens,i,j) = log10(te_no3(ens,i,j))/log10(ens_param.ppmr(ens));
                end
            end
        end
    end
    ens_param.te_no3 = te_no3;
    ens_param.tro_sca_no3 = tro_sca_no3;
    ens_param.kfe = kfe;
%     output = kfe;
%     save('ensemble_parameters.mat','ens_param','ens_index','-v7.3')

