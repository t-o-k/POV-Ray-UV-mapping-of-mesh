// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7
/*

https://github.com/t-o-k/POV-Ray-UV-mapping-of-mesh

Copyright (c) 2022 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General
Public License version 3, which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

// Render options:
// +a0.1 +w1024 +h768 +FN

#version 3.7;

global_settings { assumed_gamma 1.0 }

#declare Bk = color rgb <0, 0, 0>;
#declare Rd = color rgb <1, 0, 0>;
#declare Gn = color rgb <0, 1, 0>;
#declare Bu = color rgb <0, 0, 1>;
#declare Cy = color rgb <0, 1, 1>;
#declare Mg = color rgb <1, 0, 1>;
#declare Ye = color rgb <1, 1, 0>;
#declare Wh = color rgb <1, 1, 1>;

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

#declare R = 1;

#declare pT = R*y;
#declare pA = vrotate(pT, +120*z);
#declare pB = vrotate(pA, -120*y);
#declare pC = vrotate(pB, -120*y);

#declare Radius = 0.01;
#declare PyramidFrame =
    union {
        sphere {
            pT, 2*Radius
            pigment { color Wh }
        }
        sphere {
            pA, 2*Radius
            pigment { color Gn }
        }
        sphere {
            pB, 2*Radius
            pigment { color Rd }
        }
        sphere {
            pC, 2*Radius
            pigment { color Bu }
        }
        union {
            cylinder { pA, pT, Radius }
            cylinder { pB, pT, Radius }
            cylinder { pC, pT, Radius }
            cylinder { pA, pB, Radius }
            cylinder { pB, pC, Radius }
            cylinder { pC, pA, Radius }
            pigment { color 0.4*Wh }
        }
    }

#declare W = 6;
#declare H = 2;

//  Some UV coordinates in the image:
//  <0/W, 0/H> for Lower Left
//  <6/W, 0/H> for Lower Right
//  <0/W, 2/H> for Upper Left
//  <6/W, 2/H> for Upper Right
  
#declare PyramidMesh =
    mesh {
        triangle {
            pA, pT, pB
            uv_vectors <0/W, 1/H>, <1/W, 2/H>, <2/W, 1/H>
        }
        triangle {
            pB, pT, pC
            uv_vectors <2/W, 1/H>, <3/W, 2/H>, <4/W, 1/H>
        }
        triangle {
            pC, pT, pA
            uv_vectors <4/W, 1/H>, <5/W, 2/H>, <6/W, 1/H>
        }
        triangle {
            pA, pB, pC
            uv_vectors <3/W, 0/H>, <2/W, 1/H>, <4/W, 1/H>
        }
        texture {
            uv_mapping
            pigment {
                image_map {
                    png "Image_for_UV-mapping.png"
                    map_type 0
                    interpolate 2
                }
            }
        }
    }

#declare Pyramid =
    union {
        object { PyramidFrame }
        object { PyramidMesh }
    }

object {
    Pyramid
    rotate 10*y
    translate -0.8*x
}

object {
    Pyramid
    rotate 140*y
    rotate 40*x
    translate +0.8*x
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

background { color (2*Bu + 1*Gn)/30 }

light_source {
    100*<-1, -1, -12>
    color 2.0*Wh
    shadowless
}

light_source {
    100*<-2, 2, -1>
    color 0.5*Wh
    shadowless
}

camera {
    location <0, 10, -28>
    look_at <0, 0, 0>
    angle 8
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

#declare URL = "https://github.com/t-o-k/POV-Ray-UV-mapping-of-mesh"

text {
    ttf "timrom.ttf" URL 1e-6, 0
    texture {
        pigment { color 0.3*Wh }
        finish {
            diffuse 0
            emission color Wh
        }
    }
    scale <1, 1, 1>/10
    translate -<1.16, 1.44, 0.00>
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7
