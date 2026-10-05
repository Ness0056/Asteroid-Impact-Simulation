// Collision of a meteorite with asteroid Toutatis   
// sequence post impact: 


#include "colors.inc"

#fopen U10 "transforma.dat" read
#read (U10, q11, q21, q31, q12, q22, q32, q13, q23, q33, q14, q24, q34)


// #declare T_actual= homogeneous transform matrix  {0} -> {t}:

#declare T_actual= transform { matrix  < q11, q21, q31,      // column 1 !!
                                         q12, q22, q32,      // column 2 !!
                                         q13, q23, q33,      // column 3 !!
                                         q14, q24, q34 > }   // column 4 !!

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



    transform T_actual
       }




#declare SRgeneric = union {
                        cylinder{<0, 0, 0>, <2 , 0, 0>, .02 texture { pigment { color Red   } }  }
                        cylinder{<0, 0, 0>, <0, 2 , 0>, .02 texture { pigment { color Green } }  }
                        cylinder{<0, 0, 0>, <0, 0,  3>, .02 texture { pigment { color Blue  } }  }
                           }
   object{SRgeneric
     transform T_actual
   }


