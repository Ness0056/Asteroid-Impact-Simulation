// Collision of a meteorite with asteroid Toutatis

// meteorite data:

#declare Mass2 = 0.027;    // In units of Toutatis mass

#declare Xc = 0.333;        // Collision point
#declare Yc = 0.465;
#declare Zc = 1.333;

#declare Vx = -0.450;         // Meteorite velocity before impact
#declare Vy = -0.015;
#declare Vz = -0.161;

#declare Xt = Xc + Vx * clock;   // Meteorite trajectory
#declare Yt = Yc + Vy * clock;   // before collision:
#declare Zt = Zc + Vz * clock;   // (  -2 <  t = clock < 0 )

// Toutatis data: (at rest at origin, before collision occurs):

#declare Mass  = 1.0;      // In units of Toutatis mass

#declare I11   = 0.686;    // Inertia matrix,
#declare I22   = 0.726;    // describing Toutatis
#declare I33   = 0.213;    // mass distribution

#declare I12   = 0.0;      // I21 = I12
#declare I23   = 0.0;      // I32 = I23
#declare I31   = 0.0;      // I13 = I31

#include "colors.inc"


global_settings {
    ambient_light
    rgb <1.0,1.0,1.0>
 }

/*{{{ background, light_source, camera */

 background {
    color rgb <0,0,0>
 }

 light_source {
    < 2,4, -2>
    color rgb <.5,.5,.5> * 2
 }

 light_source {
    < 4, 0, -5>
    color rgb <.5,.5,.5> * 2
 }

 light_source {
    < 3, -6, -1>
    color rgb <.1,.1,.1>
 }

 camera {
    location <6,0,0>
    up y
    right -4*x/3
    angle 60
    sky <0,1,0>
    look_at <0,0,0>
 }

/*}}}*/

/*{{{ Definim object {Meteorite} */
#declare Meteorite = 
sphere {0,1
       texture {
        pigment {spotted turbulence .5 frequency -1
                 color_map {
                [0 color rgb <.8,.4,.5>]
                [.25 color rgb <.9,.6,.4>]
                [.33 color rgb <.8,.7,.6>]
                [.67 color rgb <.9,.8,.6>]
                [.9 color rgb <.8,.7,.7>]
                [1 color rgb <.9,.85,.8>]
                            } scale .25
 warp {black_hole <.25,.25,.5>,.125 falloff 2 strength 2 repeat <.8,.8,.8> turbulence .125 inverse}
                 }
 finish {ambient .06 diffuse .5 phong .05 phong_size 5 specular .025 roughness .025}
       }        
   scale  0.02  
}

/*}}}*/

/*{{{ asteroid texture */

#declare asteroidfinish = finish {
  ambient 0.5
  diffuse 1
  specular 0.3
  roughness .1
  }
#declare asteroidnormal = normal {
   bumps 0.5
   scale 0.02
   }

#declare asteroidmat = texture {
  pigment {
  color rgb <0.5,0.5,0.5>
  }
  finish { asteroidfinish }
  normal { asteroidnormal }
                                                                                                        }
/*}}}*/



// Scene:  

// Asteroid:

object{
        union{
                #include "./toutatis.inc"
        }

        texture {
                pigment {color rgb <1,0.9,0.8>}
                finish {specular 0.2 roughness 0.4 ambient 0.0}
                normal{wrinkles 0.2 scale 0.1 }
        }


 }

// Meteorite:

object {Meteorite

           translate < Xt, Yt, Zt >

       }

#declare SRgeneric = union {
                        cylinder{<0, 0, 0>, <2 , 0, 0>, .02 texture { pigment { color Red   } }  }
                        cylinder{<0, 0, 0>, <0, 2 , 0>, .02 texture { pigment { color Green } }  }
                        cylinder{<0, 0, 0>, <0, 0,  3>, .02 texture { pigment { color Blue  } }  }
                           }
   object{SRgeneric
   }


