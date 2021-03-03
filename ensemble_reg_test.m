clc;
clear all;
close all;
t=0:0.01:1;
s=ones(length(t),1);
cm=[s,t'];
for i=2:25
    cm=[cm,(t.^i)'];
end
rng(2500);
rm=rand(size(cm,2),2);
rm=rm-mean(rm);
rec=cm*rm;
rec=rec+(rand(size(rec))-0.5)*0.05;
%
fit=cm\rec;
calc=cm*fit;
% plot(rec(:,1),rec(:,2),'o','LineWidth',3);hold on; plot(calc(:,1),calc(:,2),'r-','LineWidth',3);hold off;
%
n_est=50;
est_size=10;
clear cal fit_est est;
for i=1:n_est
    rand_sam=randperm(size(cm,2));
    est(:,:,i)=cm(:,rand_sam(1:est_size));
    fit_est(:,:,i)=pinv(est(:,:,i))*rec;
    cal(:,:,i)=est(:,:,i)*fit_est(:,:,i);
    cal_m=mean(cal,3);
subplot(1,2,1),plot(rec(:,1),rec(:,2),'o','LineWidth',3);
    hold on; plot(calc(:,1),calc(:,2),'r-','LineWidth',3);
    plot(cal_m(:,1),cal_m(:,2),'g-','LineWidth',3);axis('square');
    err(i)=mean2((cal_m-rec).^2);
    
    legend('Ground truth data','Least squares','Bagged predictor');
    hold off;
    subplot(1,2,2),plot(err,'LineWidth',3);axis('square');ylabel('Error');xlabel('Number of estimators');
    pause(0.03);
end
%

