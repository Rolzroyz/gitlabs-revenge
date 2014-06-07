function [ heat_capacity_out,energy_out,x,total_mag ] = ising_func( x,size, T ,itterations,frames,delay )
%ising_func Main Iteration Loop for the ising model of a ferromagnet
%   RETURNS average heat capacity and average energy over all itterations
%
%   The fuction takes a NxN matrix x of size=length(x)-1 as the lattus of points
%   T controls the temperature which ditacts the probably of an unfavorable
%   energy flip (DeltaU>0)
%   itterations,frames,delay control how long and how often the model is
%   graphed, each frame is graphed with the given number of itteration
%   between giving frames*itterations = total random samplings (aka all
%   itterations or net itterations)
%   delay is the minimum time the compter will wait before reploting the
%   data. In most cases the system will be large enough to ignore this but
%   if you want to ponder some of the smaller systems freel free to slow
%   them down 
%   
%   typical compute times vary greatly with parameters (see console output) 
%   exponetially growing as you try to increase size and net itterations,
%   which is a must if you expect consistant data analysis, a rapid
%   method for estimating the quality (cosistancy) of the heat capacity and
%   energy output is to  check figure 102 (Average manitization over all 
%   itterations) to see if you have a smooth gausian or bifercated
%   distribution (giant U / half of a giant U) if it looks like you made 
%   it up then it's probably good (please don't make it up)
%   
%   The graphs here are purely for debugging and analysis they give you
%   quite a bit of information about how the end result was computed. 
%   Figure(101) is the main checkboard that displays the spin configuration
%   of the system over time. 
%   Figure(102) shows the number of times each average manatization occured
%   in the main contol loop. it should be a smooth gausian above the
%   critical temperature (2.5ish) ans some sort of bimodal distrabution
%   below, near it might be wonky but it should be smooth (make it smooth)
%   Figure(105) shows the system energy and the heat capacity as a function
%   of the running average. Each point on the bottom subplot gives the heat
%   capacity returned if the system was truncated at that point. 
%   
%   As a final note the system does use a memory index on every loop (as
%   part of an array) this means that in long samples (lots of itterations)
%   the program will crash, this is not a function of matrix size but
%   total times recursed please be careful with exceed the memory limit on
%   your compter. MATLAB is nice but everytime you ignore a memory limit a
%   C++ programmer dies 
%
%   Good Luck
%
%   Royce Cribbs
%   6/4/2014

%%
%--------------------
%size = 20
%x = initialize([size+1],.5)
%T = 10
%itterations = 1000
%frames = 100
%delay = 1/60
%--------------------

total_mag=zeros([1,itterations.*frames]);
energy = 0;
for i =1:size  %calculate intial system energy
    for ii = 1:size
        energy=energy+initU(i,ii,x);
    end
end
figure(102)
set(figure(1),'position',[1000,300,700,700])
pcolor(x)
shading flat
axis square
axis ij
colormap(bone(2));
text1=sprintf(...
'%s-GridSize = %d Temperature %3.1f Interations %d E= %d',...
'Colormap',size,T,0,energy);
title(text1)
dir='C:\Users\Rolzroyz\Pictures\Temp\';
if isdir(dir)==0
        mkdir(dir)
end
Suffix='.png';
filename=[dir text1 Suffix];
print('-dpng',filename);
%%
tic
for ii = 1:frames         %outer loop, used to control display
    for iii = 1:itterations   %inner loop, used to itterate between frames
        i = ceil(rand(1,1).*size);
        j = ceil(rand(1,1).*size);
        Ediff = deltaU(i,j,x);
        if Ediff<=0
            x(i,j) =  - x(i,j);
            energy=energy+Ediff;
        elseif rand < exp(-Ediff/T)       %flip chance
            x(i,j) = -x(i,j);
            energy=energy+Ediff;
        end 
        index=iii+(itterations.*ii)-(itterations); %used for magnitazation
        total_mag(index) = sum(sum(x(1:size,1:size))); %magnatization
        total_energy(index)=energy;
    end
    pcolor(x) %plot data 
    shading flat   
    axis square
    axis ij
    text2=sprintf(...
    '%s-LattusSize=%d,Temperature%3.1f,Interations%d',...
    'IsingModel',size,T,ii*itterations);
    title(text2)
    dir=sprintf('C:\\Users\\Rolzroyz\\Pictures\\Temp\\T=%3.1f\\',T);
    if isdir(dir)==0
        mkdir(dir)
    end
    filename=[dir text2 Suffix];
    print('-dpng',filename);
    pause(delay)
end
disp(sprintf('Energy = %d',energy))
toc
%%
figure(102) %histogram of average spin
hist(total_mag,(max(total_mag)-min(total_mag))/2);
xlabel('net magnitization')
ylabel('total occurances')
title(text2)
%%
average_energy=zeros([1,itterations.*frames]);
average_energy_sq=zeros([1,itterations.*frames]);
current_average=total_energy(1);
for i=2:length(total_energy) %create running average of system energy
    average_energy(i)=((i-1)*current_average+total_energy(i))/i;
    current_average = average_energy(i);
end

figure(105)
subplot(211)
plot([1:1:length(total_energy)],total_energy,'b'...
    ,[1:1:length(total_energy)],average_energy,'r')
xlabel('itterations')
ylabel('system energy')
legend('Current','Running Average','Location','SouthEast')
title(text2)

subplot(212)
current_average=total_energy(1).^2;
for i=2:length(total_energy) %create running average of system energy
    average_energy_sq(i)=((i-1)*current_average+(total_energy(i)).^2)/i;
    current_average = average_energy_sq(i);
end
heat_capacity=(average_energy_sq-average_energy.^2)/T;
plot(1:1:length(total_energy),heat_capacity);
xlabel('itterations')
ylabel('heat capacity')
title('Time evolution of heat capacity')
energy_out = average_energy(end);
heat_capacity_out = heat_capacity(end);
end
