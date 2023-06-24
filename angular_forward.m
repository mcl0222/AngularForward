%angular momentum method for hologram design, forward propagation
%clear all;
function image =angular_forward(angf,freq,c,h,distance,hologram)
f0=freq;%frequency
cwater=c;%m/s, sound speed in water
k0=2*pi*f0/cwater;%wave vector

I1=double(hologram);
[nx, ny] = size(I1); %pixel numbers of the hologram
[X,Y]=meshgrid((-(nx/2-1):nx/2)*h/nx);

dx=h/nx;
dy=h/ny;

%figure;hold on
%subplot(1,2,1)
%imshow(abs(I1))
%title('Object, Amplitude')
%view ([0 0 90])
%axis equal 
%axis tight
%colorbar

% subplot(1,3,2)
% surf(X,Y,angle(I1))
% title('Object, Phase')
% view ([0 0 90])
% axis equal 
% axis tight
% colorbar

%backward propagation
    
nx1=angf;%number of angular frequency modes
ny1=angf;%number of angular frequency modes

dkx1=2*pi/dx/(2*nx1-1);
dky1=2*pi/dy/(2*ny1-1);

kex1=(-nx1+1:nx1-1)*dkx1;
key1=(-ny1+1:ny1-1)*dky1;
[Kx1,Ky1]=meshgrid(kex1,key1);

fftI1 = fft2(I1(1:nx,1:ny),2*nx1-1,2*ny1-1);
fftI2 = fftshift(fftI1);

%forward propagation
H=exp(1i*(distance)*sqrt(k0^2-Kx1.^2-Ky1.^2));
for j=1:2*nx1-1
    for k=1:2*ny1-1
        if Kx1(j,k)^2+Ky1(j,k)^2>k0^2
            H(j,k)=0;
%             disp('hit');
        
        end
    end
end


fftI3=fftI2.*H;

forward_propagated_fft = ifftshift((fftI3));
forward_propagated_image = ifft2(forward_propagated_fft,2*nx1-1,2*ny1-1);

%subplot(1,2,2)
%imshow(abs(forward_propagated_image(1:nx,1:ny))/max(max(abs(forward_propagated_image(1:nx,1:ny)))))

%title('Image')
%colorbar

%hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

image=abs(forward_propagated_image(1:nx,1:ny))/max(max(abs(forward_propagated_image(1:nx,1:ny))));

