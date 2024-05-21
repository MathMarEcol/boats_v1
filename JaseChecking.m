clear
close all

% load('outputBoats_LEx_m250_m0_1_h_ind_6290.mat')

load('outputBoats180360_LEx_m250_m0_1_h_ind_6290.mat') % Go back to original global resolution

conv = 1e-9;

figure
subplot(4,1,1)
title("effort_gi_t", "Interpreter", "none")
hold on
plot(boats.output.annual.effort_gi_t * conv)

subplot(4,1,2)
title("effort_gi_g", "Interpreter", "none")
hold on
plot(sum(boats.output.annual.effort_gi_g, 2, "omitnan") * conv)

subplot(4,1,3)
title("effort_g_out", "Interpreter", "none")
hold on
tmp = sum(boats.output.annual.effort_g_out, 4, "omitnan") .* conv;
tmp2 = tmp .* permute(repmat(boats.forcing.surf, [1, 1, 250]), [3 1 2]);
tmp3 = sum(tmp2, [2 3], "omitnan");

plot(tmp3)


subplot(4,1,4)
title("effort_t_out", "Interpreter", "none")
hold on
tmp = boats.output.annual.effort_t_out .* permute(repmat(boats.forcing.surf, [1, 1, 250]), [3 1 2]);
tmp2 = sum(tmp, [2 3], "omitnan") .* conv;
plot(tmp2)


% plot(sum(boats.output.annual.effort_t_out, [2 3], "omitnan") * conv)



figure
% Look at revenue

size(boats.output.annual.revenue)
tmp = sum(boats.output.annual.revenue, 4, "omitnan");
tmp2 = tmp .* permute(repmat(boats.forcing.surf, [1, 1, 250]), [3 1 2]);
tmp3 = sum(tmp2, [2 3], "omitnan");

subplot(4,1,1)
title("Revenue", "Interpreter", "none")
hold on
plot(tmp3)



% Look at cost

size(boats.output.annual.cost)
tmp = sum(boats.output.annual.cost, 4, "omitnan");
tmp2 = tmp .* permute(repmat(boats.forcing.surf, [1, 1, 250]), [3 1 2]);
tmp3 = sum(tmp2, [2 3], "omitnan");

subplot(4,1,2)
title("Cost", "Interpreter", "none")
hold on
plot(tmp3)

% Effort
tmp = sum(boats.output.annual.effort_g_out, 4, "omitnan");
tmp2 = tmp .* permute(repmat(boats.forcing.surf, [1, 1, 250]), [3 1 2]);
tmp3 = sum(tmp2, [2 3], "omitnan") .* 1e-9;
subplot(4,1,3)
title("Effort", "Interpreter", "none")
hold on
plot(tmp3)


% Effort Change
tmp = mean(boats.output.annual.effort_change, 4, "omitnan");
tmp2 = tmp .* permute(repmat(boats.forcing.surf, [1, 1, 250]), [3 1 2]);
tmp3 = mean(tmp2, [2 3], "omitnan");

subplot(4,1,4)
title("Effort Change", "Interpreter", "none")
hold on
plot(tmp3)





% Effort Change
% tmp = mean(boats.output.annual.effort_change, 4, "omitnan");

tmp = squeeze(mean(boats.output.annual.effort_change, [1 4], "omitnan"));

title("Mean Effort Change", "Interpreter", "none")
hold on
pcolor(tmp)
colorbar



figure

subplot(4,2,1)
title("Effort", "Interpreter", "none")
hold on
tmp = squeeze(mean(boats.output.annual.effort_g_out(51:100,:,:,:), [1 4], "omitnan"));
p = pcolor(tmp);
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar

subplot(4,2,3)
title("Effort", "Interpreter", "none")
hold on
tmp = squeeze(mean(boats.output.annual.effort_g_out(101:150,:,:,:), [1 4], "omitnan"));
p = pcolor(tmp);
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar

subplot(4,2,5)
title("Effort", "Interpreter", "none")
hold on
tmp = squeeze(mean(boats.output.annual.effort_g_out(151:200,:,:,:), [1 4], "omitnan"));
p = pcolor(tmp);
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar

subplot(4,2,7)
title("Effort", "Interpreter", "none")
hold on
tmp = squeeze(mean(boats.output.annual.effort_g_out(201:250,:,:,:), [1 4], "omitnan"));
p = pcolor(tmp);
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar

subplot(4,2,2)
title("Effort Change", "Interpreter", "none")
hold on
tmp = squeeze(mean(boats.output.annual.effort_change(51:100,:,:,:), [1 4], "omitnan"));
p = pcolor(tmp);
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar

subplot(4,2,4)
title("Effort Change", "Interpreter", "none")
hold on
tmp = squeeze(mean(boats.output.annual.effort_change(101:150,:,:,:), [1 4], "omitnan"));
p = pcolor(tmp);
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar

subplot(4,2,6)
title("Effort Change", "Interpreter", "none")
hold on
tmp = squeeze(mean(boats.output.annual.effort_change(151:200,:,:,:), [1 4], "omitnan"));
p = pcolor(tmp);
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar

subplot(4,2,8)
title("Effort Change", "Interpreter", "none")
hold on
tmp = squeeze(mean(boats.output.annual.effort_change(201:250,:,:,:), [1 4], "omitnan"));
p = pcolor(tmp);
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar



tmp = squeeze(mean(boats.output.annual.effort_g_out(150:200,:,:,:), [1 4], "omitnan"));

figure
title("Effort", "Interpreter", "none")
hold on
pcolor(tmp)
colorbar







%% Lets look at the forcings

load Ecological.mat
Eco1 = Ecological; % -74.5 to 74.5
clear Ecological

load Ecological_Original.mat
Eco2 = Ecological;
clear Ecological

dim_red = 16:165; % Dimension Reduction

out = Eco2.npp(dim_red,:,:) - Eco1.npp;
min(out(:)) % No difference in npp
max(out(:))

out = Eco2.npp_ed(dim_red,:,:) - Eco1.npp_ed;
min(out(:)) % No difference in npp_ed
max(out(:))

out = Eco2.temperature(dim_red,:,:) - Eco1.temperature;
min(out(:)) % No difference in temp
max(out(:))





load("~/GitHub/boats_v1/data_monthly_orig_Carozza2017.mat")
dat_monthly_orig = data_monthly;
clear("data_monthly")

load Ecological_Original.mat



figure

subplot(2, 2, 1)
p = pcolor(squeeze(mean(data_monthly.npp, "omitnan")));
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar
title("npp")

subplot(2, 2, 2)
p = pcolor(squeeze(mean(data_monthly.npp_mean, "omitnan")));
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar
title("npp_mean")

subplot(2, 2, 3)
p = pcolor(squeeze(mean(Ecological.npp, 3, "omitnan")));
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar
title("Ecological npp")

subplot(2, 2, 4)
p = pcolor(squeeze(mean(Ecological.npp_ed, 3, "omitnan")));
set(p, "linestyle", "none")
set(gca, "xlim", [0 360], "ylim", [0 180], "XTickLabel", "", "YTickLabel", "")
colorbar
title("Ecological npp_ed")

out = data_monthly.npp_mean - permute(Ecological.npp, [3 1 2]);

out = data_monthly.npp - data_monthly.npp_mean;




%% DO EFFORT BY LME
clear
close all

load('outputBoats180360_LEx_m250_m0_1_h_ind_6290.mat') % Go back to original global resolution

load("gmd-9-1545-2016-supplement/LME_mask.mat")
not_used = [0 11 47 55 56 57 61 62 63 64 65 66]; % LME's not used in the analysis
LME_mask(ismember(LME_mask,not_used)) = NaN; % Remove unused
LME_mask(LME_mask > 0) = 1; % Make binary
LME_mask(LME_mask <= 0) = NaN; % Make binary
LME_rep = permute(repmat(LME_mask, [1 1 250]), [3 1 2]);


conv = 1e-9; % Deal with grid area
effort = sum(boats.output.annual.effort_g_out, 4, "omitnan") .* conv;
effort_area = effort .* permute(repmat(boats.forcing.surf, [1, 1, 250]), [3 1 2]);
effort_LME = sum(effort_area .* LME_rep, [2,3], "omitnan");

plot(1:250, effort_LME)

