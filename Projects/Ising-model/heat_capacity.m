clear all
size=20;                        %array...
x = initialize([size+1],.5);    %...setup
heat_range = [2:0.5:5];         %temperature range
for i = 1:length(heat_range)    %run really complex program
     disp(sprintf('i = %d',i))  %debuging
     [foo,fox,x,magni] = ising_func(x,size,heat_range(i),100000,20,1/600);
     cv(i)=foo;                 %extract... 
     av(i)=fox;                 %...data
     ma(i)=sum(magni)/length(magni);
     fprintf('cv = %d, av = %d\n',cv(i),av(i))%debuging
     %pause(1) %if needed
end
%%
figure(20)                      %plot stuff and make it look sorta nice
subplot(211)
plot(heat_range,av,'k')         %energy
xlabel('Temperature')
ylabel('Average Energy')
title('Ising Model - 20X20 Lattus - 10000000 Itterations - Matrix Reuse ON')
subplot(212)
plot(heat_range,cv,'k')         %heat capacity
xlabel('Temperature')
ylabel('Heat Capacity')
%%
figure(21)
plot(heat_range,ma,'k')         %average magnitization
xlabel('Temperature')
ylabel('Average Magnitization')
title('Ising Model - System average magnitization')