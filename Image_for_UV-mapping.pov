// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7
/*

https://github.com/t-o-k/POV-Ray-UV-mapping-of-mesh

Copyright (c) 2022 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General
Public License version 3, which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

// Render options:
// +a0.1 +w1680 +h970 +FN

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

default {
    finish {
        diffuse 0
        emission color Wh
    }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

background { color 0.2*Wh }

camera {
    orthographic
    direction +z
    right +image_width*x
    up +image_height*y
    sky +y
    location -z
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

#macro ObjectTexture(Object, ColorInside, ColorOutside)

    texture {
        pigment {
            object {
                Object
                color ColorInside
                color ColorOutside
            }
        }
    }

#end // macro ObjectTexture

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

#declare S = 560; // Length of sides in equilateral triangle 

#declare DX = S/2;
#declare DY = S/2*sqrt(3);
 
#debug concat("Image Width:",  str(6*DX, 0, -1), "\n")  // 1680
#debug concat("Image Height:", str(2*DY, 0, -1), "\n")  // 969.9

#declare pA = <-2*DX, +1*DY, 0>; // Upper left
#declare pB = < 0*DX, +1*DY, 0>; // Upper center
#declare pC = <+2*DX, +1*DY, 0>; // Upper right
#declare pD = <-3*DX,  0*DY, 0>; // Middle outer left
#declare pE = <-1*DX,  0*DY, 0>; // Middle inner left 
#declare pF = <+1*DX,  0*DY, 0>; // Middle inner right 
#declare pG = <+3*DX,  0*DY, 0>; // Middle outer right
#declare pH = < 0*DX, -1*DY, 0>; // Lower center

#declare Torus =
    torus {
        DX, 20
        rotate 90*x
    }
    
#declare BigTorus =
    torus {
        DX, 34
        rotate 90*x
    }

#declare TorusD = object { Torus translate pD }
#declare TorusE = object { Torus translate pE }
#declare TorusF = object { Torus translate pF }
#declare TorusG = object { Torus translate pG }
#declare TorusH = object { Torus translate pH }

#declare BigTorusD = object { BigTorus translate pD }
#declare BigTorusE = object { BigTorus translate pE }
#declare BigTorusF = object { BigTorus translate pF }
#declare BigTorusG = object { BigTorus translate pG }

#declare Tori_DE =
    union {
        object { TorusD }
        object { TorusE }
    }
#declare Tori_EF =
    union {
        object { TorusE }
        object { TorusF }
    }
#declare Tori_FG =
    union {
        object { TorusF }
        object { TorusG }
    }
#declare Tori_FHE =
    union {
        object { TorusF }
        object { TorusH }
        object { TorusE }
    }

#declare BigTori_DE =
    union {
        object { BigTorusD }
        object { BigTorusE }
    }
#declare BigTori_EF =
    union {
        object { BigTorusE }
        object { BigTorusF }
    }
#declare BigTori_FG =
    union {
        object { BigTorusF }
        object { BigTorusG }
    }

mesh2 {
    vertex_vectors {
        8,
        pA, pB, pC, pD, pE, pF, pG, pH
    }
    texture_list {
        12,
        // DAE
        ObjectTexture(Tori_DE, Gn, Bk),
        ObjectTexture(BigTori_DE, Wh, Bk),
        ObjectTexture(Tori_DE, Rd, Bk),
        // EBF
        ObjectTexture(Tori_EF, Rd, Bk),
        ObjectTexture(BigTori_EF, Wh, Bk),
        ObjectTexture(Tori_EF, Bu, Bk),
        // FCG
        ObjectTexture(Tori_FG, Bu, Bk),
        ObjectTexture(BigTori_FG, Wh, Bk),
        ObjectTexture(Tori_FG, Gn, Bk),
        // FHE
        ObjectTexture(Tori_FHE, Bu, Bk),
        ObjectTexture(Tori_FHE, Gn, Bk),
        ObjectTexture(Tori_FHE, Rd, Bk)
    }
    face_indices {
        4,
        <3, 0, 4>,  0,  1,  2,
        <4, 1, 5>,  3,  4,  5,
        <5, 2, 6>,  6,  7,  8
        <5, 7, 4>,  9, 10, 11
    }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7

#declare URL = "https://github.com/t-o-k/POV-Ray-UV-mapping-of-mesh"

text {
    ttf "timrom.ttf" URL 1, 0
    pigment { color (2*Bu + 1*Gn)/30 }
    scale 30*<1, 1, 1>
    translate 100*x -420*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7
