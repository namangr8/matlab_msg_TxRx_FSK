######################################################################################
##    This program is created by  Naman Gupta 
##    
##    This program simulates the data transmission from the sender level 
##    to data reception to receiver level.
##    It converts the user input (digits) to Binary numbers and then converts it
##    to manchester line encoding (IEEE 802.3 standards).
##    Then it uses frequency shift keying (FSK) to convert the Digital Signal to 
##    Analog Signal which can be further complicated modulation.
##  
##    Also in this program i haven't defined the time refrence axis a static axis 
##    keeping the axis length 0 to 1 and dividing it into the sampling frquency.
##   
##    I have defined the time axis dynamically. That means each bit of the  
##    message will have its own reference axis which its divided in its sampling
##    frequency and for another bit a new refernce axis is added to the prior axis.   
################################################################################
################################################################################

clc;clear all; close all;

[analogsignal,f1,f2]=msgtx;

###############################################################################


################################################################################
# Frequency Shift Keying Demodulation
v=[0];

len=length(analogsignal);
for k=1:len/50;
vnew=linspace(max(v)+1,max(v)+50,50);
v=[v vnew];

u1=analogsignal(vnew).*sin(2*pi*f1*vnew);
u2=analogsignal(vnew).*sin(2*pi*f2*vnew);

xnew =u1-u2;

xsum=mean(xnew);

if xsum>0.2;
demod(k) = 0;
else
demod(k) = 1;
endif
endfor
#


###############################################################################
#Manchester decoding
for l=1:length(demod)/2;
  if (demod(2.*l-1)==0 && demod(2.*l)==1);
    recvbit(l)=1;
  elseif (demod(2.*l-1)==1 && demod(2.*l)==0);
    recvbit(l)=0;
  else
    recvbit(l)='E';    # Error bit
   
 endif

endfor
#


################################################################################
################################################################################

#plots
q=3;w=1;   #subplot(q,w,#)
###########################################################################
# Demodulated Signal
disp("\n Signal Received...Now Decoding the Message") 
pause()
figure(3)
subplot(q,w,1)
plot(analogsignal)
axis([1 length(analogsignal) -1.5 1.5 ]); grid on; 
title('Received Signal');ylabel('Amplitude');xlabel('Time');
waitforbuttonpress()
######################

subplot(q,w,2);
plot(demod,'m','linewidth',2);
title('Demodulated Signal FSK ()');ylabel('Amplitude');xlabel('Time');
waitforbuttonpress()
###############################

subplot(q,w,3);
stem(recvbit,'r','linewidth',2);
title('Demodulated Signal ()');ylabel('Amplitude');xlabel('Time');
##################################
###########################################################################################
