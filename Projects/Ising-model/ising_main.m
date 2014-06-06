clear all
%%variables
size = 20 ;         %width of square lattus
T = 10;           %temperature elsilon/kt
itterations = 10000;    %loops per frame
frames = 10 ;    %frames shown
%delay = 1;
delay = 1/60;       %time per frame (a man can dream)
%%
total_mag=zeros([1,itterations.*frames]);
x = initialize([size+1],.5);
energy = 0;
for i =1:size
    for ii = 1:size
        energy=energy+initU(i,ii,x);
    end
end
figure(1)
set(figure(1),'position',[1000,300,700,700])
pcolor(x)
shading flat 
axis ij
colormap(bone(2));
text1=sprintf(...
    '%s - Lattus Size = %d , Temperature %3.1f , Interations %d E = %d',...
    'Ising Model',size,T,frames*itterations,energy);
title(text1)
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
    '%s - Lattus Size = %d , Temperature %3.1f , Interations %d E = %d',...
    'Ising Model',size,T,ii*itterations,energy);
    title(text2)
    pause(delay)
    %pause
end
disp(sprintf('Energy = %d',energy))
toc
%%
figure(2) %histogram of average spin
hist(total_mag,(max(total_mag)-min(total_mag))/2);
xlabel('net magnitization')
ylabel('total occurances')
title(text2)
%%
tic
current_average=total_energy(1);
for i=2:length(total_energy) %create running average of system energy
    average_energy(i)=((i-1)*current_average+total_energy(i))/i;
    current_average = average_energy(i);
end
toc
figure(5)
subplot(211)
ubar=sum(total_energy)/(itterations*frames);
plot([1:1:length(total_energy)],total_energy,'b',[1:1:length(total_energy)],average_energy,'r')
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
hold on
plot(1:1:length(total_energy),(average_energy_sq-average_energy.^2)/T)
xlabel('itterations')
ylabel('heat capacity')
title('Time evolution of heat capacity')