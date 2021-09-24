function f = Chan_Vese(phi, Image, ImageF, eps, lambda1, lambda2, Iter, dt)
% f = Chan_Vese(phi, Image, ImageF, eps, lambda1, lambda2, Iter, dt)
%
% Input:
% - phi: initial surface
% - Image: the original image
% - ImageF: the filtered image to be segmented
% - eps, lambda1, lambda2: parameters of Chan-Vese algorithm
% - Iter: number of iterations
% - dt: numerical step

% Output:
% - f: the segmented curve

figure
It = phi;
for i=1:Iter
    He=(phi>=0); % zones in which phi is positive
    Hi=(phi<0);  % zones in which phi is negative
    I0i=ImageF.*Hi; % image zones in which phi is positive
    I0e=ImageF.*He; % image zones in which phi is negative
    c1=sum(sum(I0i))./(sum(sum(Hi))); % means of velues where phi<0 (inside the boundary)
    c2=sum(sum(I0e))./(sum(sum(He))); % means of velues where phi>0 (outside the boundary)

    phi = phi + dt.*(eps*divergence(D_x(phi)./G(phi), D_y(phi)./G(phi))...
        - lambda1*(ImageF-c1).^2 + lambda2*(ImageF-c2).^2);

    if (mod(i,2)==1)
        colormap(gray);
        imagesc(Image);
        colormap gray;
        axis  image;
        hold on
        contour(phi,[0 0],'r');
        drawnow;       
    end
    
    % When it reaches stability, stop the evolution:
    if sum(sum(phi<0)) == sum(sum(It<0)) && i>2
        disp(['Number of iterations: ', num2str(i)])
        break
    end
    if mod(i,3) == 1
        It = phi;
    end
end
hold off
f = phi;
end
