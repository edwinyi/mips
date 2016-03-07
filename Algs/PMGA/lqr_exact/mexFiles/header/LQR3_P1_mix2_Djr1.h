#ifndef LQR3_P1_mix2_Djr1_H
#define LQR3_P1_mix2_Djr1_H

double LQR3_P1_mix2_Djr1(double* tv, int tdim, double* param, int pdim) {

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

double t4 = 1.0/AUp1;
double t5 = r2-3.338299811;
double t6 = t2*t5;
double t7 = r1*t1;
double t8 = t1*t1;
double t9 = t2*t2;
double t13 = r1*t8;
double t14 = r2*t9;
double t15 = r3*t1*t2;
double t10 = t6+t7-t13-t14-t15+1.151035476;
double t11 = exp(t10);
double t12 = t11+1.0;
double t16 = 1.0/(t12*t12);
double t17 = r4-3.338299811;
double t18 = t1*t17;
double t19 = r5*t2;
double t23 = r4*t8;
double t24 = r5*t9;
double t25 = r6*t1*t2;
double t20 = t18+t19-t23-t24-t25+1.151035476;
double t21 = exp(t20);
double t22 = t21+1.0;
double t26 = 1.0/(t22*t22);
double t27 = r7+3.338299811;
double t28 = t1*t27;
double t29 = r8+3.338299811;
double t30 = t2*t29;
double t34 = r7*t8;
double t35 = r8*t9;
double t36 = r9*t1*t2;
double t31 = t28+t30-t34-t35-t36-2.187264336;
double t32 = exp(t31);
double t33 = t32+1.0;
double t37 = 1.0/(t33*t33);
double t38 = t16*(1.0/1.0E1);
double t39 = t38+9.0/1.0E1;
double t40 = 1.0/t12;
double t41 = t40*1.8E1;
double t63 = t16*9.0;
double t42 = t41-t63+1.0;
double t43 = 1.0/t42;
double t44 = t39*t43*1.09E3;
double t45 = t26*(9.0/1.0E1);
double t46 = t45+1.0/1.0E1;
double t47 = 1.0/t22;
double t48 = t47*1.8E1;
double t66 = t26*9.0;
double t49 = t48-t66+1.0;
double t50 = 1.0/t49;
double t51 = t46*t50*1.09E3;
double t52 = t37*(9.0/1.0E1);
double t53 = t52+1.0/1.0E1;
double t54 = 1.0/t33;
double t55 = t54*1.8E1;
double t67 = t37*9.0;
double t56 = t55-t67+1.0;
double t57 = 1.0/t56;
double t58 = t53*t57*1.09E3;
double t59 = t44+t51+t58+1.9E1;
double t60 = t4*t59;
double t61 = t60-1.0;
double t62 = t1-t8;
double t64 = 1.0/(t12*t12*t12);
double t65 = 1.0/AUp2;
double t68 = t16*(9.0/1.0E1);
double t69 = t68+1.0/1.0E1;
double t70 = t43*t69*1.09E3;
double t71 = t26*(1.0/1.0E1);
double t72 = t71+9.0/1.0E1;
double t73 = t50*t72*1.09E3;
double t74 = t58+t70+t73+1.9E1;
double t75 = t65*t74;
double t76 = t75-1.0;
double t77 = t11*t16*t62*1.8E1;
double t87 = t11*t62*t64*1.8E1;
double t78 = t77-t87;
double t79 = 1.0/(t42*t42);
double t80 = 1.0/AUp3;
double t81 = t37*(1.0/1.0E1);
double t82 = t81+9.0/1.0E1;
double t83 = t57*t82*1.09E3;
double t84 = t51+t70+t83+1.9E1;
double t85 = t80*t84;
double t86 = t85-1.0;
double t88 = t69*t78*t79*1.09E3;
double t111 = t11*t43*t62*t64*1.962E3;
double t89 = t88-t111;
double t96 = 1.0/Up1;
double t97 = t59*t96;
double t98 = t97-1.0;
double t90 = fabs(t98);
double t100 = 1.0/Up2;
double t101 = t74*t100;
double t102 = t101-1.0;
double t91 = fabs(t102);
double t104 = 1.0/Up3;
double t105 = t84*t104;
double t106 = t105-1.0;
double t92 = fabs(t106);
double t93 = fabs(t61);
double t94 = fabs(t76);
double t95 = fabs(t86);
double t99 = t90*t90;
double t103 = t91*t91;
double t107 = t92*t92;
double t108 = t99+t103+t107;
double t109 = t39*t78*t79*1.09E3;
double t110 = t109-t11*t43*t62*t64*2.18E2;
double t112 = t47*t50*2.18E2;
double t113 = t48-1.8E1;
double t114 = 1.0/(t49*t49);
double t115 = t72*t113*t114*1.09E3;
double t116 = t112+t115;
double t117 = t47*t50*1.962E3;
double t118 = t46*t113*t114*1.09E3;
double t119 = t117+t118;
double t120 = r4*t1*2.0;
double t121 = r6*t2;
double t122 = -r4+t120+t121+3.338299811;
double t123 = t55-1.8E1;
double t124 = 1.0/(t56*t56);
double t138 = r7*t1*2.0;
double t139 = r9*t2;
double t125 = r7-t138-t139+3.338299811;
double t126 = t40*t43*1.962E3;
double t127 = t41-1.8E1;
double t128 = t69*t79*t127*1.09E3;
double t129 = t126+t128;
double t130 = r1*t1*2.0;
double t131 = r3*t2;
double t132 = -r1+t130+t131;
double t133 = t11*t16*t129*t132;
double t134 = t21*t26*t119*t122;
double t135 = t54*t57*1.962E3;
double t136 = t53*t123*t124*1.09E3;
double t137 = t135+t136;
double t140 = t54*t57*2.18E2;
double t141 = t82*t123*t124*1.09E3;
double t142 = t140+t141;
double t152 = t32*t37*t125*t142;
double t143 = t133+t134-t152;
double t144 = t21*t26*t116*t122;
double t146 = t32*t37*t125*t137;
double t145 = t133+t144-t146;
double t147 = t40*t43*2.18E2;
double t148 = t39*t79*t127*1.09E3;
double t149 = t147+t148;
double t150 = t11*t16*t132*t149;
double t151 = t134-t146+t150;
double t153 = r2*t2*2.0;
double t154 = r3*t1;
double t155 = -r2+t153+t154+3.338299811;
double t162 = r8*t2*2.0;
double t163 = r9*t1;
double t156 = r8-t162-t163+3.338299811;
double t157 = r5*t2*2.0;
double t158 = r6*t1;
double t159 = -r5+t157+t158;
double t160 = t21*t26*t119*t159;
double t161 = t11*t16*t129*t155;
double t170 = t32*t37*t142*t156;
double t164 = t160+t161-t170;
double t165 = t11*t16*t149*t155;
double t167 = t32*t37*t137*t156;
double t166 = t160+t165-t167;
double t168 = t21*t26*t116*t159;
double t169 = t161-t167+t168;
double t171 = t149*t151;
double t172 = t129*t145;
double t173 = t129*t143;
double t174 = t171+t172+t173;
double t175 = t142*t143;
double t176 = t137*t145;
double t177 = t137*t151;
double t178 = t175+t176+t177;
double t179 = t116*t145;
double t180 = t119*t143;
double t181 = t116*t169;
double t182 = t119*t166;
double t183 = t119*t164;
double t184 = t181+t182+t183;
double t185 = t142*t164;
double t186 = t137*t166;
double t187 = t137*t169;
double t188 = t185+t186+t187;
double t189 = t149*t166;
double t190 = t129*t164;
double t191 = t119*t151;
double t192 = t179+t180+t191;
double t193 = t11*t16*t132*t174;
double t194 = t129*t169;
double t195 = t189+t190+t194;
double t196 = t21*t26*t159*t184;
double t197 = t11*t16*t155*t174;
double t198 = t21*t26*t159*t192;
double t251 = t32*t37*t156*t178;
double t199 = t197+t198-t251;
double t200 = t21*t26*t122*t184;
double t201 = t11*t16*t132*t195;
double t266 = t32*t37*t125*t188;
double t202 = t200+t201-t266;
double t203 = t93*t93;
double t204 = t94*t94;
double t205 = t95*t95;
double t206 = t203+t204+t205;
double t207 = 1.0/t108;
double t208 = t21*t26*t122*t192;
double t209 = t193+t208-t32*t37*t125*t178;
double t210 = 1.0/(t42*t42*t42);
double t211 = t2*t5*2.0;
double t219 = r1*t8*2.0;
double t220 = r2*t9*2.0;
double t221 = r3*t1*t2*2.0;
double t212 = t130+t211-t219-t220-t221+2.302070952;
double t213 = exp(t212);
double t214 = t11*t16*t43*t62*1.962E3;
double t215 = t11*t16*t62*t69*t79*1.962E4;
double t216 = t11*t62*t64*t79*t127*1.962E3;
double t228 = t40*t78*t79*1.962E3;
double t229 = t69*t78*t127*t210*2.18E3;
double t217 = t214+t215+t216-t228-t229;
double t218 = t11*t16*t155*t217;
double t222 = t62*t64*t129*t155*t213*2.0;
double t235 = t11*t16*t62*t129*t155;
double t223 = t218+t222-t235;
double t224 = t11*t16*t43*t62*2.18E2;
double t225 = t11*t16*t39*t62*t79*1.962E4;
double t226 = t11*t62*t64*t79*t127*2.18E2;
double t230 = t40*t78*t79*2.18E2;
double t231 = t39*t78*t127*t210*2.18E3;
double t227 = t224+t225+t226-t230-t231;
double t232 = t11*t16*t155*t227;
double t233 = t62*t64*t149*t155*t213*2.0;
double t236 = t11*t16*t62*t149*t155;
double t234 = t232+t233-t236;
double t237 = t11*t16*t155*t195;
double t238 = t196+t237-t32*t37*t156*t188;
double t239 = t1*2.0;
double t240 = t239-1.0;
double t241 = t11*t16*t132*t217;
double t242 = t62*t64*t129*t132*t213*2.0;
double t247 = t11*t16*t129*t240;
double t248 = t11*t16*t62*t129*t132;
double t243 = t241+t242-t247-t248;
double t244 = t11*t16*t132*t227;
double t245 = t62*t64*t132*t149*t213*2.0;
double t249 = t11*t16*t149*t240;
double t250 = t11*t16*t62*t132*t149;
double t246 = t244+t245-t249-t250;
double t252 = t119*t234;
double t253 = t116*t223;
double t254 = t119*t223;
double t255 = t252+t253+t254;
double t256 = t137*t234;
double t257 = t142*t223;
double t258 = t137*t223;
double t259 = t256+t257+t258;
double t260 = t166*t227;
double t261 = t164*t217;
double t262 = t169*t217;
double t263 = t149*t234;
double t264 = t129*t223*2.0;
double t265 = t260+t261+t262+t263+t264;
double t267 = t119*t246;
double t268 = t116*t243;
double t269 = t119*t243;
double t270 = t151*t227;
double t271 = t145*t217;
double t272 = t143*t217;
double t273 = t137*t246;
double t274 = t142*t243;
double t275 = t137*t243;
double t276 = t273+t274+t275;
double t277 = t267+t268+t269;
double t278 = t129*t243*2.0;
double t279 = t149*t246;
double t280 = t270+t271+t272+t278+t279;
double t0 = (beta1*t207*(t4*t93*t110*((t61/fabs(t61)))*2.0+t65*t89*t94*((t76/fabs(t76)))*2.0+t80*t89*t95*((t86/fabs(t86)))*2.0)-beta1*1.0/(t108*t108)*t206*(t89*t91*t100*((t102/fabs(t102)))*2.0+t89*t92*t104*((t106/fabs(t106)))*2.0+t90*t96*t110*((t98/fabs(t98)))*2.0))*sqrt(-t199*t202+(t193-t32*t37*t125*t178+t21*t26*t122*(t179+t180+t119*(t134+t150-t32*t37*t125*t137)))*(t196-t32*t37*t156*t188+t11*t16*t155*(t189+t190+t129*(t161+t168-t32*t37*t137*t156))))+(beta2-beta1*t206*t207)*1.0/sqrt(-t199*t202+t209*t238)*(t209*(t11*t16*t155*t265+t21*t26*t159*t255-t32*t37*t156*t259-t11*t16*t62*t155*t195+t62*t64*t155*t195*t213*2.0)-t202*(t11*t16*t155*t280+t21*t26*t159*t277-t32*t37*t156*t276-t11*t16*t62*t155*t174+t62*t64*t155*t174*t213*2.0)-t199*(t11*t16*t132*t265+t21*t26*t122*t255-t32*t37*t125*t259-t11*t16*t195*t240-t11*t16*t62*t132*t195+t62*t64*t132*t195*t213*2.0)+t238*(t11*t16*t132*t280-t11*t16*t174*t240+t21*t26*t122*t277-t32*t37*t125*t276-t11*t16*t62*t132*t174+t62*t64*t132*t174*t213*2.0))*(1.0/2.0);

return t0;
}

#endif