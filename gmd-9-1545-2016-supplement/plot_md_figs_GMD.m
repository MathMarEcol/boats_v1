% plot_md_figures.m
%-----------------------------------------------------------------------------------------
% plot figures for model description paper submitted to Geoscientific Model Development
%-----------------------------------------------------------------------------------------
% This version is for running on Earth
%-----------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------
% initialize paths, parameters, and necessary arrays
%-----------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------
% set indices for figures to plot

 do_fig_scal_rep                      = 0;
 do_fig_recruitment                   = 1;
 do_fig_boats0d_df_NH                 = 0;
 do_fig_boats0d_eval_NH_ST            = 0;

 dir_print = '/archive/dcarozza/writing/model_description/figs';

%-----------------------------------------------------------------------------------------
% start index for figure plots
 ind_plot                             = 1;

%-----------------------------------------------------------------------------------------
% load 0-d boats transients files
 load boats0d_md_EBS_NH.mat
 boats0d_md_EBS_NH = boats;
 load boats0d_md_BEN_NH.mat
 boats0d_md_BEN_NH = boats;

%-----------------------------------------------------------------------------------------
% load NPP vs. T sensitivity test
 load suite_NPP_vs_T_HR.mat
 suite_NPP_T = suite_NPP_vs_T_HR;
 temp75_vec  = suite_NPP_T.temp75;
 npp_vec     = suite_NPP_T.npp;

%-----------------------------------------------------------------------------------------
% load primary production and temperature data
 load data_monthly-review.mat

%-----------------------------------------------------------------------------------------
% load geographical and time structure
 load geo_time.mat

%-----------------------------------------------------------------------------------------
% set geographical and time parameters
 spery        = geo_time.spery;

%-----------------------------------------------------------------------------------------
% Set coordinates (latitude,longitude) of sites
 lat_EBS = 154; lon_EBS = 195; % East Bering Sea site Large Marine Ecosystem Coordinates
 lat_BC = 70;   lon_BC = 12; % Benguela Current site Large Marine Ecosystem Coordinates

%-----------------------------------------------------------------------------------------
% Set fmass vector
 log10fmass  = log10(boats.parameters.fmass);

%-----------------------------------------------------------------------------------------
% Quantities required to take averages of time series
 yave_nh = 10;   % number of years at end of run used to calculate run with no harvest
 yave_h  = 10;   % number of years at end of run used to calculate run with harvest
 tpery   = 12*2; % timesteps per year

%-----------------------------------------------------------------------------------------
% Net primary production values
 npp.EBS    = nanmean(data_monthly.npp(:,lat_EBS,lon_EBS),1)*12;
 npp.BC     = nanmean(data_monthly.npp(:,lat_BC,lon_BC),1)*12;

%-----------------------------------------------------------------------------------------
% Temperature values (75-meter average)
 temp75.EBS = nanmean(data_monthly.temp75(:,lat_EBS,lon_EBS),1);
 temp75.BC  = nanmean(data_monthly.temp75(:,lat_BC,lon_BC),1);

%-----------------------------------------------------------------------------------------
% FIGURE
% Plot structure of energy to reproduction allocation and overall allocation to reproduction
%-----------------------------------------------------------------------------------------

if (do_fig_scal_rep)

 rep_scale = boats0d_md_EBS_NH.rep_scale;
 rep_scale(boats0d_md_EBS_NH.mask_notexist) = NaN;
 rep_alloc_frac = boats0d_md_EBS_NH.rep_alloc_frac;
 rep_alloc_frac(boats0d_md_EBS_NH.mask_notexist) = NaN;

 figure(ind_plot)
 plot(log10fmass,rep_alloc_frac(1,:),'k','linewidth',2)
 hold on
 plot(log10fmass,rep_alloc_frac(2,:),'k--','linewidth',2)
 plot(log10fmass,rep_alloc_frac(3,:),'k-.','linewidth',2)

 plot(log10fmass,rep_scale(1,:),'k','linewidth',1)
 plot(log10fmass,rep_scale(2,:),'k--','linewidth',1)
 plot(log10fmass,rep_scale(3,:),'k-.','linewidth',1)
 
 hold off
 title('Scaling and fraction to reproduction by group','fontsize',14);
 xlabel('Mass (log10 g)','fontsize',14);
 ylabel('Fraction','fontsize',14);
 xlim([log10fmass(1) log10fmass(end)]); ylim([0 1.05])
 leg = legend('Small','Medium','Large',3,'Location','best');
 set(leg,'FontSize',10)

 ind_plot = ind_plot + 1;

% print(figure(1),'-dpsc2',[dir_print '/gmd-2015-232-discussions-f02.eps']);

end % do_fig_scal_rep

%-----------------------------------------------------------------------------------------
% Recruitment map as a function of the two recruitment types
%-----------------------------------------------------------------------------------------

if (do_fig_recruitment)

 R_e_vec = (0:2e-7:1e-5)*spery;
 R_p_vec = (0:2e-8:1e-6)*spery;

 epsln = 1e-30;

 [R_p R_e] = meshgrid(R_p_vec,R_e_vec);

 R = (R_p + epsln) .* R_e ./ (R_p + R_e + epsln);

 figure(ind_plot)
 imagesc(R_p_vec,flipud(R_e_vec),R); colorbar
 set(gca,'YDir','normal') 
 xlabel('R_P (gwB m^{-2} yr^{-1})','fontsize',18); ylabel('R_e (gwB m^{-2} yr^{-1})','fontsize',18);
 title('Recruitment flux','fontsize',18);
 xlim([0 30]); ylim([0 300]); caxis([0 30]);
 colormap(flipud(lbmap(256,'RedBlue')));
 set(gca,'YDir','normal')
 hold on
 [C,h] = contour(R_p_vec,flipud(R_e_vec),R,[5:5:30],'color','k','LineWidth',1);
 clabel(C,h,[5:5:30],'FontSize',12);

 ind_plot = ind_plot + 1;
 
 % print(figure(1),'-dpsc2',[dir_print '/gmd-2015-232-discussions-f03.eps']);

end % do_fig_recruitment

%-----------------------------------------------------------------------------------------
% FIGURE: dfish spectra NO HARVEST (NH)
%-----------------------------------------------------------------------------------------

if (do_fig_boats0d_df_NH)

 figure(ind_plot)

 subplot(2,2,1)
 plot(log10fmass,log10(squeeze(nanmean(boats0d_md_EBS_NH.dfish(end-yave_nh*tpery:end-1,1,:),1))'),'k','linewidth',2)
 hold on
 plot(log10fmass,log10(squeeze(nanmean(boats0d_md_EBS_NH.dfish(end-yave_nh*tpery:end-1,2,:),1))'),'k--','linewidth',2)
 plot(log10fmass,log10(squeeze(nanmean(boats0d_md_EBS_NH.dfish(end-yave_nh*tpery:end-1,3,:),1))'),'k-.','linewidth',2)
 plot(log10fmass,log10(squeeze(nansum(nanmean(boats0d_md_EBS_NH.dfish(end-yave_nh*tpery:end-1,:,:),1),2))'),'color',[0.7 0.7 0.7],'linewidth',2)
 hold off
 xlim([1 5]); ylim([-3 2]);
 title('(a) Cold-water site f_k','fontsize',14)
 xlabel('Mass (log10 g)','fontsize',14); ylabel('Spectra (log10 gwB m^{-2}g^{-1})','fontsize',14)
 leg = legend('Small','Medium','Large','Total');
 set(leg,'FontSize',8)

 subplot(2,2,2)
 plot(log10fmass,log10(squeeze(nanmean(boats0d_md_BEN_NH.dfish(end-yave_nh*tpery:end-1,1,:),1))'),'k','linewidth',2)
 hold on
 plot(log10fmass,log10(squeeze(nanmean(boats0d_md_BEN_NH.dfish(end-yave_nh*tpery:end-1,2,:),1))'),'k--','linewidth',2)
 plot(log10fmass,log10(squeeze(nanmean(boats0d_md_BEN_NH.dfish(end-yave_nh*tpery:end-1,3,:),1))'),'k-.','linewidth',2)
 plot(log10fmass,log10(squeeze(nansum(nanmean(boats0d_md_BEN_NH.dfish(end-yave_nh*tpery:end-1,:,:),1),2))'),'color',[0.7 0.7 0.7],'linewidth',2)
 hold off
 xlim([1 5]); ylim([-3 2]);
 title('(b) Warm-water site f_k','fontsize',14)
 xlabel('Mass (log10 g)','fontsize',14);

 ind_plot = ind_plot + 1;

% print(figure(1),'-dpsc2',[dir_print '/gmd-2015-232-discussions-f04.eps']);

end % do_fig_boats0d_df_NH

%-----------------------------------------------------------------------------------------
% FIGURE: 0-D sensitivity results
% 4 panels
% (A) total fish (NPP vs T)
% (B) Intercept (NPP vs. T)
% (C) Total non-reproducing slope (NPP vs. T)
%-----------------------------------------------------------------------------------------

if (do_fig_boats0d_eval_NH_ST)

 figure(ind_plot)

%-----------------------------------------------------------------------------------------
% total fish (NPP vs T)

 subplot(2,2,1)
 imagesc(temp75_vec,flipud(npp_vec),log10(suite_NPP_T.diagnostics.total_fish)); colorbar; caxis([-0.5 3.5])
 colormap(flipud(lbmap(256,'RedBlue')));
 set(gca,'YDir','normal')
 hold all
 plot(temp75.EBS,npp.EBS,'.k','MarkerSize',30);
 plot(temp75.EBS,npp.EBS,'.b','MarkerSize',20);
 plot(temp75.BC,npp.BC,'.k','MarkerSize',30);
 plot(temp75.BC,npp.BC,'.r','MarkerSize',20);
 hold off
 xlabel('Temperature (^oC)'); ylabel('NPP (mg C m^{-2} d^{-1})')
 title('(a) Total biomass (log10 gwB m^{-2})')
 hold on
 [C,h] = contour(temp75_vec,flipud(npp_vec),log10(suite_NPP_T.diagnostics.total_fish),[-0.5:0.5:3.5],'color','k','LineWidth',1);
 clabel(C,h,[-0.5:0.5:3.5],'FontSize',12);

%-----------------------------------------------------------------------------------------
% total intercept (NPP vs. T)

 subplot(2,2,2)
 imagesc(temp75_vec,flipud(npp_vec),suite_NPP_T.diagnostics.total_intercept_mc1); colorbar; caxis([-1 2])
 colormap(flipud(lbmap(256,'RedBlue')));
 set(gca,'YDir','normal')
 hold all
 plot(temp75.EBS,npp.EBS,'.k','MarkerSize',30);
 plot(temp75.EBS,npp.EBS,'.b','MarkerSize',20);
 plot(temp75.BC,npp.BC,'.k','MarkerSize',30);
 plot(temp75.BC,npp.BC,'.r','MarkerSize',20);
 hold off
 xlabel('Temperature (^oC)'); ylabel('NPP (mg C m^{-2} d^{-1})')
 title('(b) Intercept of total biomass spectra (log10 gwB m^{-2}g^{-1})')
 caxis([-1.5 2])
 hold on
 [C,h] = contour(temp75_vec,flipud(npp_vec),suite_NPP_T.diagnostics.total_intercept_mc1,[-2:0.5:2],'color','k','LineWidth',1);
 clabel(C,h,[-2:0.5:2],'FontSize',12);

%-----------------------------------------------------------------------------------------
% group and total non-reproducing slope (NPP vs. T)
% remove the simulations with collapsed groups
% for total only define simulations where all three group slopes were defined

 bad_group1 = (suite_NPP_T.diagnostics.group1_intercept_mc1(1,:) < -10);
 bad_group2 = (suite_NPP_T.diagnostics.group2_intercept_mc1(1,:) < -10);
 bad_group3 = (suite_NPP_T.diagnostics.group3_intercept_mc1(1,:) < -10);

 group1_nr_slope_loglog = suite_NPP_T.diagnostics.group1_nr_slope_loglog(1,:);
 group1_nr_slope_loglog(bad_group1) = NaN;
 group2_nr_slope_loglog = suite_NPP_T.diagnostics.group2_nr_slope_loglog(1,:);
 group2_nr_slope_loglog(bad_group2) = NaN;
 group3_nr_slope_loglog = suite_NPP_T.diagnostics.group3_nr_slope_loglog(1,:);
 group3_nr_slope_loglog(bad_group3) = NaN;

 total_nr_slope_loglog = suite_NPP_T.diagnostics.total_nr_slope_loglog(1,:);
 total_nr_slope_loglog(bad_group1|bad_group2|bad_group3) = NaN;

 subplot(2,2,4)
 hold on
 plot(temp75_vec,group1_nr_slope_loglog,'k','LineWidth',2)
 plot(temp75_vec,group2_nr_slope_loglog,'k--','LineWidth',2)
 plot(temp75_vec,group3_nr_slope_loglog,'k-.','LineWidth',2)
 plot(temp75_vec,total_nr_slope_loglog(1,:),'color',[0.7 0.7 0.7],'LineWidth',2)
 hold off
 leg = legend('Small','Medium','Large','Total',4,'Location','best');
 set(leg,'FontSize',8)
 xlabel('Temperature (^oC)'); ylabel('Slope (log10 gwB m^{-2}g^{-1}/log10 g) ')
 title('(c) Slope of nonreproducing biomass spectra')
 xlim([-2 30])

 ind_plot = ind_plot + 1;
 
 % print(figure(1),'-dpsc2',[dir_print '/gmd-2015-232-discussions-f05.eps']);

end % do_fig_boats0d_eval_NH_ST

%-----------------------------------------------------------------------------------------
% END OF SCRIPT