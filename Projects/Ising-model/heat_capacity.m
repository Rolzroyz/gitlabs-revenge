clear all

size = 20;                      %Lattus Size
bias = 0.5;                     %How energetically favored one state is
                                %0.5 is equaly probable
T = 10;                         %Temperature
itterations = 10;             %# of points updated between frames
frames = 10;                   %number of systems plotted (minimum 1)
delay = 1/60;                   %time between plots (added to compute time)

x = initialize([size+1],bias);  %create intial array 

heat_range = [2:0.5:2.5];         %temperature range
for i = 1:length(heat_range)    %run core modeling program
     disp(sprintf('i = %d',i))  %debuging
     [foo,fox,x,magni] = ising_func(x,size,heat_range(i)... retrive values
         ,itterations,frames,delay); %of interest from ising model
     cv(i)=foo;                 %Heat capacity 
     av(i)=fox;                 %average energy
     ma(i)=sum(magni)/length(magni);% average system magnitization
     fprintf('cv = %d, av = %d\n',cv(i),av(i))%debuging
end
%%
figure(20)                      %plot stuff and make it look sorta nice
subplot(311)
plot(heat_range,av,'k')         %energy
xlabel('Temperature')
ylabel('Average Energy')
text20=sprintf('Lattus size = %dx%d Itterations Per Temperature = %d'...
    ,size,size,itterations*frames); %automate labling
title(text20)
subplot(312)
plot(heat_range,cv,'k')         %heat capacity
xlabel('Temperature')
ylabel('Heat Capacity')
subplot(313)
plot(heat_range,ma,'k')         %average magnitization
xlabel('Temperature')
ylabel('Average Magnitization')
title('Ising Model - System average magnitization')