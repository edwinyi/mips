#ifndef LQR3_P1_mix1_DL2_H
#define LQR3_P1_mix1_DL2_H

double LQR3_P1_mix1_DL2(double* tv, int tdim, double* param, int pdim) {

double t1 = tv[0], t2 = tv[1];

double r1 = param[0];
double r2 = param[1];
double r3 = param[2];
double r4 = param[3];
double r5 = param[4];
double r6 = param[5];
double r7 = param[6];
double r8 = param[7];
double r9 = param[8];

double t4 = r8*t1;
double t5 = r9*t2;
double t6 = r7+t4+t5;
double t7 = exp(t6);
double t8 = t7+1.0;
double t9 = 1.0/t8;
double t10 = 1.0/(t8*t8);
double t11 = t9*1.8E1;
double t42 = t10*9.0;
double t12 = t11-t42+1.0;
double t13 = r2*t1;
double t14 = r3*t2;
double t15 = r1+t13+t14;
double t16 = exp(t15);
double t17 = t16+1.0;
double t18 = 1.0/t17;
double t19 = 1.0/(t17*t17);
double t20 = t18*1.8E1;
double t22 = t19*9.0;
double t21 = t20-t22+1.0;
double t23 = 1.0/t21;
double t24 = t18*t23*2.18E2;
double t25 = t19*(1.0/1.0E1);
double t26 = t25+9.0/1.0E1;
double t27 = t20-1.8E1;
double t28 = 1.0/(t21*t21);
double t29 = t26*t27*t28*1.09E3;
double t30 = t24+t29;
double t31 = fabs(t30);
double t32 = r5*t1;
double t33 = r6*t2;
double t34 = r4+t32+t33;
double t35 = exp(t34);
double t36 = t35+1.0;
double t37 = 1.0/t36;
double t38 = 1.0/(t36*t36);
double t39 = t37*1.8E1;
double t59 = t38*9.0;
double t40 = t39-t59+1.0;
double t60 = 1.0/t40;
double t61 = t37*t60*1.962E3;
double t62 = t38*(9.0/1.0E1);
double t63 = t62+1.0/1.0E1;
double t64 = t39-1.8E1;
double t65 = 1.0/(t40*t40);
double t66 = t63*t64*t65*1.09E3;
double t67 = t61+t66;
double t41 = fabs(t67);
double t43 = 1.0/t12;
double t44 = t9*t43*1.962E3;
double t45 = t10*(9.0/1.0E1);
double t46 = t45+1.0/1.0E1;
double t47 = t11-1.8E1;
double t48 = 1.0/(t12*t12);
double t49 = t46*t47*t48*1.09E3;
double t50 = t44+t49;
double t51 = fabs(t50);
double t85 = t9*t43*2.18E2;
double t86 = t10*(1.0/1.0E1);
double t87 = t86+9.0/1.0E1;
double t88 = t47*t48*t87*1.09E3;
double t89 = t85+t88;
double t52 = fabs(t89);
double t53 = t18*t23*1.962E3;
double t54 = t19*(9.0/1.0E1);
double t55 = t54+1.0/1.0E1;
double t56 = t27*t28*t55*1.09E3;
double t57 = t53+t56;
double t58 = fabs(t57);
double t68 = t41*t41;
double t69 = t37*t60*2.18E2;
double t70 = t38*(1.0/1.0E1);
double t71 = t70+9.0/1.0E1;
double t72 = t64*t65*t71*1.09E3;
double t73 = t69+t72;
double t74 = fabs(t73);
double t75 = t58*t58;
double t76 = t51*t51;
double t77 = t31*t31;
double t78 = t68+t76+t77;
double t79 = 1.0/sqrt(t78);
double t80 = t30*t79;
double t81 = t74*t74;
double t82 = t75+t76+t81;
double t83 = 1.0/sqrt(t82);
double t84 = t67*t79;
double t90 = t52*t52;
double t91 = t68+t75+t90;
double t92 = 1.0/sqrt(t91);
double t102 = t57*t83;
double t93 = t80-t102;
double t100 = t57*t92;
double t94 = t80-t100;
double t95 = t50*t79;
double t103 = t67*t92;
double t96 = t84-t103;
double t108 = t50*t83;
double t97 = t95-t108;
double t101 = t73*t83;
double t98 = t84-t101;
double t107 = t89*t92;
double t99 = t95-t107;
double t104 = t93*t96;
double t180 = t94*t98;
double t105 = t104-t180;
double t106 = fabs(t105);
double t109 = t94*t97;
double t182 = t93*t99;
double t110 = t109-t182;
double t111 = fabs(t110);
double t112 = t96*t97;
double t184 = (t84-t101)*(t95-t107);
double t185 = -t112+t184;
double t113 = fabs(t185);
double t114 = r8*t7*t10*t50;
double t115 = r2*t16*t19*t57;
double t116 = r5*t35*t38*t67;
double t117 = r5*t35*t38*t73;
double t118 = t114+t115+t117;
double t119 = r2*t16*t19*t30;
double t120 = t114+t116+t119;
double t121 = r8*t7*t10*t89;
double t122 = t115+t116+t121;
double t123 = r9*t7*t10*t50;
double t124 = r3*t16*t19*t57;
double t125 = r6*t35*t38*t67;
double t126 = r6*t35*t38*t73;
double t127 = t123+t124+t126;
double t128 = r3*t16*t19*t30;
double t129 = t123+t125+t128;
double t130 = r9*t7*t10*t89;
double t131 = t124+t125+t130;
double t132 = t30*t120;
double t133 = t57*t118;
double t134 = t57*t122;
double t135 = t132+t133+t134;
double t136 = t73*t118;
double t137 = t67*t120;
double t138 = t67*t122;
double t139 = t136+t137+t138;
double t140 = t89*t122;
double t141 = t50*t120;
double t142 = t50*t118;
double t143 = t140+t141+t142;
double t144 = t30*t129;
double t145 = t57*t127;
double t146 = t57*t131;
double t147 = t144+t145+t146;
double t148 = t73*t127;
double t149 = t67*t129;
double t150 = t67*t131;
double t151 = t148+t149+t150;
double t152 = t89*t131;
double t153 = t50*t129;
double t154 = t50*t127;
double t155 = t152+t153+t154;
double t156 = 1.0/AUp1;
double t157 = t23*t26*1.09E3;
double t158 = t60*t63*1.09E3;
double t159 = t43*t46*1.09E3;
double t160 = t157+t158+t159+1.9E1;
double t161 = t156*t160;
double t162 = t161-1.0;
double t163 = 1.0/(t17*t17*t17);
double t164 = 1.0/AUp2;
double t165 = t23*t55*1.09E3;
double t166 = t60*t71*1.09E3;
double t167 = t159+t165+t166+1.9E1;
double t168 = t164*t167;
double t169 = t168-1.0;
double t170 = t1*t16*t19*1.8E1;
double t177 = t1*t16*t163*1.8E1;
double t171 = t170-t177;
double t172 = 1.0/AUp3;
double t173 = t43*t87*1.09E3;
double t174 = t158+t165+t173+1.9E1;
double t175 = t172*t174;
double t176 = t175-1.0;
double t178 = t28*t55*t171*1.09E3;
double t179 = t178-t1*t16*t23*t163*1.962E3;
double t181 = t50*t79*t105;
double t183 = t67*t79*t110;
double t186 = t106*t106;
double t187 = t111*t111;
double t188 = t113*t113;
double t189 = t186+t187+t188;
double t190 = 1.0/(t21*t21*t21);
double t191 = (t30/fabs(t30));
double t192 = 1.0/pow(t78,3.0/2.0);
double t193 = t1*t16*t19*t23*2.18E2;
double t194 = t1*t16*t19*t26*t28*1.962E4;
double t195 = t1*t16*t27*t28*t163*2.18E2;
double t202 = t18*t28*t171*2.18E2;
double t203 = t26*t27*t171*t190*2.18E3;
double t196 = t193+t194+t195-t202-t203;
double t197 = (t57/fabs(t57));
double t198 = t1*t16*t19*t23*1.962E3;
double t199 = t1*t16*t19*t28*t55*1.962E4;
double t200 = t1*t16*t27*t28*t163*1.962E3;
double t205 = t18*t28*t171*1.962E3;
double t206 = t27*t55*t171*t190*2.18E3;
double t201 = t198+t199+t200-t205-t206;
double t204 = 1.0/pow(t82,3.0/2.0);
double t207 = t31*t67*t191*t192*t196;
double t208 = 1.0/pow(t91,3.0/2.0);
double t222 = t58*t73*t197*t201*t204;
double t209 = t207-t222;
double t223 = t58*t67*t197*t201*t208;
double t210 = t207-t223;
double t211 = t79*t196;
double t212 = t31*t50*t191*t192*t196;
double t227 = t58*t89*t197*t201*t208;
double t213 = t212-t227;
double t229 = t50*t58*t197*t201*t204;
double t214 = t212-t229;
double t215 = t57*t58*t197*t201*t204;
double t217 = t30*t31*t191*t192*t196;
double t226 = t83*t201;
double t216 = t211+t215-t217-t226;
double t218 = t57*t58*t197*t201*t208;
double t219 = t30*t79*t185;
double t220 = t181+t183+t219;
double t221 = 1.0/sqrt(t189);
double t224 = t93*t210;
double t230 = t92*t201;
double t225 = t211-t217+t218-t230;
double t228 = t93*t213;
double t231 = t97*t225;
double t232 = t228+t231-t94*t214-t99*t216;
double t233 = t96*t214;
double t234 = t97*t210;
double t235 = r2*t16*t19*t135;
double t236 = r5*t35*t38*t139;
double t237 = r8*t7*t10*t143;
double t238 = t235+t236+t237;
double t239 = r3*t16*t19*t147;
double t240 = r6*t35*t38*t151;
double t241 = r9*t7*t10*t155;
double t242 = t239+t240+t241;
double t243 = t238*t242;
double t244 = r3*t16*t19*t135;
double t245 = r6*t35*t38*t139;
double t246 = r9*t7*t10*t143;
double t247 = t244+t245+t246;
double t248 = r2*t16*t19*t147;
double t249 = r5*t35*t38*t151;
double t250 = r8*t7*t10*t155;
double t251 = t248+t249+t250;
double t261 = t247*t251;
double t252 = t243-t261;
double t253 = sqrt(t252);
double t254 = fabs(t162);
double t255 = fabs(t169);
double t256 = fabs(t176);
double t257 = t98*t225;
double t258 = t224+t257-t94*t209-t96*t216;
double t259 = t233+t234-t99*t209-t98*t213;
double t260 = fabs(t220);
double t262 = t254*t254;
double t263 = t255*t255;
double t264 = t256*t256;
double t265 = t262+t263+t264;
double t266 = r1*2.0;
double t267 = r2*t1*2.0;
double t268 = r3*t2*2.0;
double t269 = t266+t267+t268;
double t270 = exp(t269);
double t271 = t16*t19*t30;
double t272 = r2*t1*t16*t19*t30;
double t279 = r2*t16*t19*t196;
double t280 = r2*t1*t30*t163*t270*2.0;
double t273 = t271+t272-t279-t280;
double t274 = t16*t19*t57;
double t275 = r2*t1*t16*t19*t57;
double t277 = r2*t16*t19*t201;
double t278 = r2*t1*t57*t163*t270*2.0;
double t276 = t274+t275-t277-t278;
double t281 = r3*t16*t19*t201;
double t282 = r3*t1*t57*t163*t270*2.0;
double t287 = r3*t1*t16*t19*t57;
double t283 = t281+t282-t287;
double t284 = r3*t16*t19*t196;
double t285 = r3*t1*t30*t163*t270*2.0;
double t288 = r3*t1*t16*t19*t30;
double t286 = t284+t285-t288;
double t289 = t120*t196;
double t290 = t118*t201;
double t291 = t122*t201;
double t292 = t289+t290+t291-t30*t273-t57*t276*2.0;
double t293 = t67*t273;
double t294 = t73*t276;
double t295 = t67*t276;
double t296 = t293+t294+t295;
double t297 = t50*t273;
double t298 = t89*t276;
double t299 = t50*t276;
double t300 = t297+t298+t299;
double t301 = t67*t286;
double t302 = t73*t283;
double t303 = t67*t283;
double t304 = t301+t302+t303;
double t305 = t50*t286;
double t306 = t89*t283;
double t307 = t50*t283;
double t308 = t305+t306+t307;
double t309 = t30*t286;
double t310 = t57*t283*2.0;
double t311 = t129*t196;
double t312 = t127*t201;
double t313 = t131*t201;
double t314 = t309+t310+t311+t312+t313;
double t0 = -t253*t265*(beta*t221*((t220/fabs(t220)))*(-t30*t79*t259-t67*t79*t232+t50*t79*t258-t79*t185*t196+t31*t50*t105*t191*t192*t196+t31*t67*t110*t191*t192*t196+t30*t31*t185*t191*t192*t196)+beta*1.0/pow(t189,3.0/2.0)*t260*(t111*t232*((t110/fabs(t110)))*2.0-t106*t258*((t105/fabs(t105)))*2.0+t113*t259*((t185/fabs(t185)))*2.0)*(1.0/2.0))-t253*(beta*t221*fabs(t181+t183-t30*t79*(t112-t98*t99))-1.0)*(t156*t254*((t162/fabs(t162)))*(t26*t28*t171*1.09E3-t1*t16*t23*t163*2.18E2)*2.0+t164*t179*t255*((t169/fabs(t169)))*2.0+t172*t179*t256*((t176/fabs(t176)))*2.0)-1.0/sqrt(t252)*t265*(beta*t221*t260-1.0)*(t242*(t16*t19*t135+r8*t7*t10*t300-r2*t16*t19*t292+r5*t35*t38*t296+r2*t1*t16*t19*t135-r2*t1*t135*t163*t270*2.0)+t247*(-t16*t19*t147+r8*t7*t10*t308+r2*t16*t19*t314+r5*t35*t38*t304-r2*t1*t16*t19*t147+r2*t1*t147*t163*t270*2.0)-t251*(r9*t7*t10*t300-r3*t16*t19*t292+r6*t35*t38*t296+r3*t1*t16*t19*t135-r3*t1*t135*t163*t270*2.0)-t238*(r9*t7*t10*t308+r3*t16*t19*t314+r6*t35*t38*t304-r3*t1*t16*t19*t147+r3*t1*t147*t163*t270*2.0))*(1.0/2.0);

return t0;
}

#endif