######################################################################################
##    This program is created by  Naman Gupta 
##    It is a function used in main_fsk.m
##    It contains Major Demodulated Portion Of the Program
######################################################################################
function [analogsignal,f1,f2] = msgtx


# clock
clk=[];
a_clk = 1; # amplitude
N_clk = 20; # length clock for how much cycle the machine will remain on
clkwidth = 4;  # length of clockbit
for i = 0:N_clk
    a_clk = -a_clk;
    clk = [clk a_clk*ones(1,clkwidth)];
endfor
#


###############################################################################
# Message binary conversion
in=input("Enter the Message (in numbers) you want to send : ");

bits=dec2bin(in);

numb=str2num(bits);

binary=sprintf('%d',numb) - '0'; #splits the number to single digits



################################################################################
# Line encoding Manchester
# If input=1 then signal does a transition from -1 to  1
# If input=0 then signal does a transition from  1 to -1
#
encodedsig=[];     # initialising


for i=1:length(binary)
  if binary(i)==1
    encodedsig=[encodedsig -1.*ones(1,clkwidth/2)]; 
    encodedsig=[encodedsig ones(1,clkwidth/2)];
    
  else
    encodedsig=[encodedsig ones(1,clkwidth/2)];
    encodedsig=[encodedsig -1.*ones(1,clkwidth/2)];
   
  endif
  
endfor



################################################################################
# Frequency Shift Keying
f1=0.02;   # frequency for low
f2=0.1;    # frequency for high
r=[0];      #new refrence axis

analogsignal=[];    #Initialisation

for j=1:length(binary)
 rnew=linspace(max(r)+1,max(r)+50,50);   #Increment of reference axis 
 r=[r rnew];
 
 if (binary(j)==1)
   analogsignal=[analogsignal sin(2*pi*f1*rnew)];
   analogsignal=[analogsignal sin(2*pi*f2*rnew)];
 else
   analogsignal=[analogsignal sin(2*pi*f2*rnew)];
   analogsignal=[analogsignal sin(2*pi*f1*rnew)];

 endif
endfor
#
###############################################################################



###############################################################################
###############################################################################


#plots
q=3;w=1;   #subplot(q,w,#)
###   Plot Message Signal

disp("You Entered The following Message..")
disp(in)
pause()
disp("Its Binary Equivalent is..")
disp(binary)
pause()
disp("Plotting Graph")

figure(1)
stem(binary,'linewidth',4 )
axis([1 length(binary) -0.5 1.5 ]);
title('Sender Message in Binary ()');ylabel('Amplitude');xlabel('Clk Cycle');

waitforbuttonpress()
close(1)
figure(2)
subplot(q,w,1)
stem(binary,'linewidth',4,'r' )
axis([1 length(binary) -0.5 1.5 ]);
title('Sender Message in Binary ()');ylabel('Amplitude');xlabel('Clk Cycle');
waitforbuttonpress()



####################################################################
# Plot Line Encoding Manchester
disp("Encoding the given bit in Manchester") 
figure(1)
plot(clk, '-')
axis([1 length(encodedsig) -1.5 1.5 ]); grid on; 
title('Encoded Message Manchester LE ()');ylabel('Amplitude');xlabel('Clk Cycle');
waitforbuttonpress()
hold ON
plot(encodedsig,'r', "linewidth",2);
waitforbuttonpress()
close(1)

figure(2)
subplot(q,w,2)
plot(clk)
axis([1 length(encodedsig) -1.5 1.5 ]); grid on; 
title('Encoded Message Manchester LE ()');ylabel('Amplitude');xlabel('Clk Cycle');
hold ON
plot(encodedsig,'r', "linewidth",2);

waitforbuttonpress()



##########################################################################
# Plot FSK
disp("Using Frequency Shift Keying to Convert it to analog Signal") 

figure(1)
plot(analogsignal)
axis([1 length(analogsignal) -1.5 1.5 ]);
waitforbuttonpress()
close(1)

figure(2)
subplot(q,w,3)
plot(analogsignal)
axis([1 length(analogsignal) -1.5 1.5 ]); grid on; 
title('Frequency Shift Keying Signal');ylabel('Amplitude');xlabel('Time');


end
  ##############
##################################################################################
