/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
 *
 *  Copyright 2008 Aaron Koblin 
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at 
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 *
 *//////////////////////////////////////////////////////////////

// Enable the mouse rotation and up and down arrow zooming

float rX, rY, vX, vY;
float zoomScale = 1.0;
float zoomScaleTarget = 1.2;
float currentMaxZoom = zoomScaleTarget;

// an alternative way of drawing is to manipulate the coordinate system
// the shapes are always drawn in the same position but the coordinate system refers to 
// different locations
// to rotate the sphere rotate the 3D corrdinates arounf the X or Y axis
// controlled using the mouse

void rotations() {
  rX += vX;
  rY += vY;
  vX *= 0.95;
  vY *= 0.95;

  if (mousePressed) {
    vX += (mouseY-pmouseY) * 0.01;
    vY += (mouseX-pmouseX) * 0.01;
  }

  rotateX( radians(-rX) );  
  rotateY( radians(rY) );
}

// to zoom change the scale of the coordinate system
// so that a one unit (pixel) displacement is scaled 
// the UP/DOWN keys scale up or down the interpretation of a one unit step in the corodinate system
// no attempt to bound the range of the maximum zoom 
// so it might cause unusual behaviour!
void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
    case UP : 
      currentMaxZoom += 0.1;
      zoomScaleTarget = currentMaxZoom;
      break;
    case DOWN: 
      currentMaxZoom -= 0.1;
      zoomScaleTarget = currentMaxZoom;
      break;
    }
  }
}

// perform the scaling using scale()
// a bit of animation (lerp) to go from current zoom to target zoom
// the max zoom sets an upper limit to avoid excessive zooming

void zooms() {
  if (zoomScaleTarget > currentMaxZoom) zoomScaleTarget = currentMaxZoom;
  zoomScale = lerp(zoomScale, zoomScaleTarget, 0.1); 
  scale(zoomScale);
}

// if the coordinate system is zoomed up reset it back to unzoomed (zoom = 1)
// cannot just do scale(1) because 1 now 1 is interpreted in the scaled coordinate system

void unzoom() {
  scale(1/zoomScale);
}

// move the drawing position to the centre of the display window
// (0, 0) is now located at the centre of the display window
void centre() {
  translate(width/2, height/2);
}
