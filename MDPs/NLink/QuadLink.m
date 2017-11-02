classdef QuadLink < NLinkEnv
% REFERENCE
% http://www.cs.cmu.edu/~cga/kdc/dynamics-2d/

    %% Properties
    properties
        % Environment variables
        lengths = [1 1 1 1];
        masses = [1 1 1 1];
        friction_coeff = [2.5 2.5 2.5 2.5]'; % Viscous friction coefficients
        g = 9.81; % If 0, the problem becames a simpler planar reaching task
        dt = 0.02;

        x_des = [4 0]'; % Goal in task space
        q_des = [0 0 0 0]'; % Goal in joint space
        
        % MDP variables
        dstate = 8;
        daction = 4;
        dreward = 1;
        isAveraged = 0;
        gamma = 1;

        % Bounds : state = [q1 qd1 q2 qd2 q3 qd3 q4 qd4]
        stateLB = [-pi, -50, -pi, -50, -pi, -50, -pi, -50]';
        stateUB = [pi, 50, pi, 50, pi, 50, pi, 50]';
        actionLB = [-10, -10, -10, -10]';
        actionUB = [10, 10, 10, 10]';
        rewardLB = -inf;
        rewardUB = 0;
    end
    
    methods

        %% Dynamics
        function nextstate = dynamics(obj, state, action)
            tau1 = action(1,:);
            tau2 = action(2,:);
            tau3 = action(3,:);
            tau4 = action(4,:);
            
            a1 = state(1,:);
            a1 = a1 + pi;
            a1d = state(2,:);
            a2 = state(3,:);
            a2d = state(4,:);
            a3 = state(5,:);
            a3d = state(6,:);
            a4 = state(7,:);
            a4d = state(8,:);
            
            dt = obj.dt;
            m1 = obj.masses(1);
            m2 = obj.masses(2);
            m3 = obj.masses(3);
            m4 = obj.masses(4);
            l1 = obj.lengths(1);
            l2 = obj.lengths(2);
            l3 = obj.lengths(3);
            l4 = obj.lengths(4);
            
            I = obj.masses .* (obj.lengths.^2 + 0.00001) ./ 3.0;
            I1 = I(1);
            I2 = I(2);
            I3 = I(3);
            I4 = I(4);
            
            G = obj.g;
            VISCOUS_FRICTION1 = obj.friction_coeff(1);
            VISCOUS_FRICTION2 = obj.friction_coeff(2);
            VISCOUS_FRICTION3 = obj.friction_coeff(3);
            VISCOUS_FRICTION4 = obj.friction_coeff(4);
            
            l1cm = l1 / 2.0;
            l2cm = l2 / 2.0;
            l3cm = l3 / 2.0;
            l4cm = l4 / 2.0;
            
            s1 = sin( a1 );
            c1 = cos( a1 );
            s2 = sin( a2 );
            c2 = cos( a2 );
            s3 = sin( a3 );
            c3 = cos( a3 );
            s4 = sin( a4 );
            c4 = cos( a4 );
            s12 = s1.*c2 + c1.*s2;
            c12 = c1.*c2 - s1.*s2;
            s23 = s2.*c3 + c2.*s3;
            c23 = c2.*c3 - s2.*s3;
            s34 = s3.*c4 + c3.*s4;
            c34 = c3.*c4 - s3.*s4;
            s1234 = s12.*c34 + c12.*s34;
            s123 = s12.*c3 + c12.*s3;
            s234 = s2.*c34 + c2.*s34;
            c234 = c2.*c34 - s2.*s34;
            
            a1d_a1d = a1d.*a1d;
            a2d_a2d = a2d.*a2d;
            a3d_a3d = a3d.*a3d;
            a4d_a4d = a4d.*a4d;
            a1d_p_a2d_2 = (a1d + a2d).*(a1d + a2d);
            
            l4cm_m4 = l4cm.*m4;
            l3_l4cm_m4 = l3.*l4cm_m4;
            l2_l4cm_m4 = l2.*l4cm_m4;
            l2_l4cm_m4_c34 = l2_l4cm_m4.*c34;
            l1_l4cm_m4 = l1.*l4cm_m4;
            l3_m4 = l3.*m4;
            l3cm_m3 = l3cm.*m3;
            l3cm_m3_l3_m4 = l3cm_m3 + l3_m4;
            l2cm_m2 = l2cm.*m2;
            l2cm_m2_p_l2_m3_p_m4 = l2cm_m2 + l2.*(m3 + m4);
            l2_l3cm_m3_l3_m4 = l2.*l3cm_m3_l3_m4;
            l1_l3cm_m3_l3_m4 = l1.*l3cm_m3_l3_m4;
            a123d = a1d + a2d + a3d;
            l1_l3cm_m3_l3_m4_s23 = l1_l3cm_m3_l3_m4.*s23;
            l2_l4cm_m4_s34 = l2_l4cm_m4.*s34;
            
            expr1 = G.*(s123.*l3cm_m3_l3_m4 + s1234.*l4cm_m4);
            expr2 = (2.*a123d + a4d).*a4d.*l3_l4cm_m4.*s4;
            expr3 = G.*l2cm_m2_p_l2_m3_p_m4*s12;
            expr4a = 2.*a1d.*a4d + 2.*a2d.*a4d + 2.*a3d.*a4d + a4d_a4d;
            expr4b = 2.*a1d.*a3d + 2.*a2d.*a3d + a3d_a3d;
            expr4 = (expr4b + expr4a).*l2_l4cm_m4_s34;
            expr5a = a1d_a1d.*l1.*s234;
            expr5 = l4cm_m4.*expr5a;
            expr6 = expr4b.*l2_l3cm_m3_l3_m4.*s3;
            expr7 = l1.*l2cm_m2_p_l2_m3_p_m4;
            expr8 = l1.*(m2+m3+m4);
            expr9a = 2.*a1d.*a2d + a2d_a2d;
            expr9 = (expr9a + expr4b);
            
            % Fourth link
            p = I4 + l4cm.*l4cm_m4;
            o = p + l3_l4cm_m4.*c4;
            n = o + l2_l4cm_m4_c34;
            m = n + l1_l4cm_m4.*c234;
            
            t = tau4 - VISCOUS_FRICTION4.*a4d ...
                -(l4cm_m4.*(a123d.*a123d.*l3.*s4 + ...
                a1d_p_a2d_2.*l2.*s34 + ...
                expr5a + G.*s1234));
            
            % Third link
            l = o;
            k = I3 + o + l3cm.*l3cm_m3 + l3.*l3_m4 + l3_l4cm_m4.*c4;
            j = k + l2_l3cm_m3_l3_m4.*c3 + l2_l4cm_m4_c34;
            i = j + l1_l3cm_m3_l3_m4.*c23 + l1_l4cm_m4.*c234;
            
            s = tau3 - VISCOUS_FRICTION3.*a3d ...
                -((a1d_p_a2d_2.*l2_l3cm_m3_l3_m4.*s3 + a1d_a1d.*l1_l3cm_m3_l3_m4_s23) + ...
                - expr2 ...
                + a1d_p_a2d_2.*l2_l4cm_m4_s34 ...
                + expr5 ...
                + expr1 ...
                );
            
            % Second link
            h = n;
            g = j;
            f = j + I2 + l2cm.*l2cm_m2  + (l2).^2.*(m3 + m4) ...
            + l2_l3cm_m3_l3_m4.*c3 + l2_l4cm_m4_c34; ...
            e = f + i - j + expr7.*c2;
            
            r = tau2 - VISCOUS_FRICTION2.*a2d ...
                - ( ...
                a1d_a1d.*expr7.*s2 ...
                - expr6 ...
                + a1d_a1d.*l1_l3cm_m3_l3_m4_s23 ...
                - expr2 ...
                - expr4 ...
                + expr5 ...
                + expr3 ...
                + expr1 ...
                );
            
            % First link
            d = m;
            c = i;
            b = e;
            a = 2.*e + I1 - f + (l1cm).^2.*m1 + l1.*expr8;
            
            q = tau1 - VISCOUS_FRICTION1.*a1d ...
                - ( -expr9a.*expr7.*s2 ...
                - expr6 ...
                - expr9.*l1_l3cm_m3_l3_m4_s23 ...
                - expr2 ...
                - expr4 ...
                - (expr9 + expr4a).*l1_l4cm_m4.*s234 ...
                + expr3 ...
                + G.*(l1cm.*m1 + expr8).*s1 ...
                + expr1 ...
                );
            
            determinant = ...
                (d.*g.*j.*m - c.*h.*j.*m - d.*f.*k.*m + b.*h.*k.*m + c.*f.*l.*m - b.*g.*l.*m - d.*g.*i.*n + ...
                c.*h.*i.*n + d.*e.*k.*n - a.*h.*k.*n - c.*e.*l.*n + a.*g.*l.*n + d.*f.*i.*o - b.*h.*i.*o - ...
                d.*e.*j.*o + a.*h.*j.*o + b.*e.*l.*o - a.*f.*l.*o - c.*f.*i.*p + b.*g.*i.*p + c.*e.*j.*p - ...
                a.*g.*j.*p - b.*e.*k.*p + a.*f.*k.*p);
            
            a1dd = q.*(-(h.*k.*n) + g.*l.*n + h.*j.*o - f.*l.*o - g.*j.*p + f.*k.*p) ...
                + r.*(d.*k.*n - c.*l.*n - d.*j.*o + b.*l.*o + c.*j.*p - b.*k.*p) ...
                + s.*(-(d.*g.*n) + c.*h.*n + d.*f.*o - b.*h.*o - c.*f.*p + b.*g.*p) ...
                + t.*(d.*g.*j - c.*h.*j - d.*f.*k + b.*h.*k + c.*f.*l - b.*g.*l);
            
            a2dd = q.*(h.*k.*m - g.*l.*m - h.*i.*o + e.*l.*o + g.*i.*p - e.*k.*p) ...
                + r.*(-(d.*k.*m) + c.*l.*m + d.*i.*o - a.*l.*o - c.*i.*p + a.*k.*p) ...
                + s.*(d.*g.*m - c.*h.*m - d.*e.*o + a.*h.*o + c.*e.*p - a.*g.*p) ...
                + t.*(-(d.*g.*i) + c.*h.*i + d.*e.*k - a.*h.*k - c.*e.*l + a.*g.*l);
            
            a3dd = q.*(-(h.*j.*m) + f.*l.*m + h.*i.*n - e.*l.*n - f.*i.*p + e.*j.*p) ...
                + r.*(d.*j.*m - b.*l.*m - d.*i.*n + a.*l.*n + b.*i.*p - a.*j.*p) ...
                + s.*(-(d.*f.*m) + b.*h.*m + d.*e.*n - a.*h.*n - b.*e.*p + a.*f.*p) ...
                + t.*(d.*f.*i - b.*h.*i - d.*e.*j + a.*h.*j + b.*e.*l - a.*f.*l);
            
            a4dd = q.*(g.*j.*m - f.*k.*m - g.*i.*n + e.*k.*n + f.*i.*o - e.*j.*o) ...
                + r.*(-(c.*j.*m) + b.*k.*m + c.*i.*n - a.*k.*n - b.*i.*o + a.*j.*o) ...
                + s.*(c.*f.*m - b.*g.*m - c.*e.*n + a.*g.*n + b.*e.*o - a.*f.*o) ...
                + t.*(-(c.*f.*i) + b.*g.*i + c.*e.*j - a.*g.*j - b.*e.*k + a.*f.*k);
            
            a1dd = a1dd/determinant;
            a2dd = a2dd/determinant;
            a3dd = a3dd/determinant;
            a4dd = a4dd/determinant;
            
            a1 = a1 + dt.*a1d;
            a1d = a1d + dt.*a1dd;
            a2 = a2 + dt.*a2d;
            a2d = a2d + dt.*a2dd;
            a3 = a3 + dt.*a3d;
            a3d = a3d + dt.*a3dd;
            a4 = a4 + dt.*a4d;
            a4d = a4d + dt.*a4dd;
            
            a1 = (a1 - pi);
            nextstate = [a1; a1d; a2; a2d; a3; a3d; a4; a4d];
        end

        %% Kinematics
        function X = getJointsInTaskSpace(obj, state)
        % X = [ x1 y1 x1d y1d x2 y2 x2d y2d x3 y3 x3d y3d x4 y4 x4d y4d ]
            q1 = state(1,:);
            qd1 = state(2,:);
            q2 = state(3,:);
            qd2 = state(4,:);
            q3 = state(5,:);
            qd3 = state(6,:);
            q4 = state(7,:);
            qd4 = state(8,:);
            
            xy1 = obj.lengths(1) .* [cos(q1); sin(q1)];
            xy2 = xy1 + obj.lengths(2) .* [cos(q2+q1); sin(q2+q1)];
            xy3 = xy2 + obj.lengths(3) .* [cos(q3+q2+q1); sin(q3+q2+q1)];
            xy4 = xy3 + obj.lengths(4) .* [cos(q4+q3+q2+q1); sin(q4+q3+q2+q1)];
            
            xy1d = obj.lengths(1) .* [qd1.*cos(q1); -qd1.*sin(q1)];
            xy2d = xy1d + obj.lengths(2) .* [(qd1+qd2).*cos(q1+q2); -(qd1+qd2).*sin(q1+q2)];
            xy3d = xy2d + obj.lengths(3) .* [(qd1+qd2+qd3).*cos(q1+q2+q3); -(qd1+qd2+qd3).*sin(q1+q2+q3)];
            xy4d = xy3d + obj.lengths(4) .* [(qd1+qd2+qd3+qd4).*cos(q1+q2+q3+q4); -(qd1+qd2+qd3+qd4).*sin(q1+q2+q3+q4)];
            
            X = [xy1; xy1d; xy2; xy2d; xy3; xy3d; xy4; xy4d];
        end
        
    end
 
end