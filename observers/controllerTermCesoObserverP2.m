function [ out ] = controllerTermCesoObserverP2( input )
    global controllerTermCascadedESO Controller

    b_hat = Controller.adrc.inputMatrixEstimate;
    L1 = controllerTermCascadedESO.gainVectorFirst;
    L2 = controllerTermCascadedESO.gainVectorSecond;
    k2 = controllerTermCascadedESO.controllerGains(2);

    z_hat1 = input(1:3);
    z_hat2 = input(4:6);
    y = input(7);
    u = input(8);

    Ao = [0 1 0;...
         0 -k2 1;...
         0 0 0];
    Bo = [0; -b_hat; 0];

    z_hat1_p = Ao*z_hat1 + Bo*u + L1*(y - z_hat1(1));
    z_hat2_p = Ao*z_hat2 + Bo*u - Bo*1/b_hat*z_hat1(3) + L2*(z_hat1(1) - z_hat2(1));
    
    out = [z_hat1_p; z_hat2_p]; 
end

