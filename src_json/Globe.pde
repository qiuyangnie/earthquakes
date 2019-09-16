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

// create a textured sphere
// see the constructor for different images

class Globe {
  PImage map;
  int globeRadius;  
  int sphereDetail;

  float texturedSphereX[][]; 
  float texturedSphereY[][]; 
  float texturedSphereZ[][]; 
  float texturedSphereU[][]; 
  float texturedSphereV[][]; 
  int texturedSphereDetail;


  Globe(String texture) {
    this(texture, 24);
  }

  Globe(String texture, int detail) {
    this(200, detail, texture);
  }

  Globe(int _radius, int _sphereDetail, String _mapFilename) {
    globeRadius = _radius;
    map = loadImage(_mapFilename);
    setTexturedSphereDetail(_sphereDetail);
  }

  // returns a Pvector representing the lat, long and altitude in 3d space
  // altitude is relative to the surface of the globe
  PVector getPoint(float lat, float lng, float alt) {
    // shift the lat by 90 degrees
    float shift_lat = lat + radians(90);
    float x = -1.0f * (globeRadius+alt) * sin(shift_lat) * cos(lng); // -1 needed cause of the orientation of the processing 3d cartesian coordinate system
    float z = (globeRadius+alt) * sin(shift_lat) * sin(lng);
    float y = (globeRadius+alt) * cos(shift_lat);

    return new PVector (x, y, z);
  }

  void drawSpike(float lat, float lng, float spikeHeight) {
    strokeWeight(3);
    noFill();

    PVector start = getPoint(lat, lng, -1);
    PVector end = getPoint(lat, lng, spikeHeight);

    beginShape(LINES);
    vertex(start.x, start.y, start.z);
    vertex(end.x, end.y, end.z);
    vertex(end.x, end.y, end.z);
    vertex(start.x, start.y, start.z);
    endShape();
  }

  // draw a textured sphere of globeRadius with map as texture
  void draw() {
    noStroke();
    int nexti; 
    for (int i = 0; i < texturedSphereDetail; i = nexti) { 
      nexti = i + 1; 
      beginShape(QUAD_STRIP); 
      texture(map); 
      for (int j = 0; j <= 2 * texturedSphereDetail; j += 1) { 
        float u = map.width * texturedSphereU[i][j]; 

        float x1 = globeRadius * texturedSphereX[i][j]; 
        float y1 = globeRadius * texturedSphereY[i][j]; 
        float z1 = globeRadius * texturedSphereZ[i][j]; 
        float v1 = map.height * texturedSphereV[i][j]; 

        float x2 = globeRadius * texturedSphereX[nexti][j]; 
        float y2 = globeRadius * texturedSphereY[nexti][j]; 
        float z2 = globeRadius * texturedSphereZ[nexti][j]; 
        float v2 = map.height * texturedSphereV[nexti][j]; 

        vertex(x1, y1, z1, u, v1); 
        vertex(x2, y2, z2, u, v2);
      }   
      endShape();
    }
  }

  /** 
   * Set the detail level for textured spheres 
   */
  private void setTexturedSphereDetail(int detail) { 
    if (detail == texturedSphereDetail) return; 

    texturedSphereDetail = detail; 

    // construct the underlying vertex and uv map data 

    float step = PI / detail; 
    float ustep = 0.5f / detail; 
    float vstep = 1.0f / detail; 

    texturedSphereX = new float[detail + 1][2 * detail + 1]; 
    texturedSphereY = new float[detail + 1][2 * detail + 1]; 
    texturedSphereZ = new float[detail + 1][2 * detail + 1]; 
    texturedSphereU = new float[detail + 1][2 * detail + 1]; 
    texturedSphereV = new float[detail + 1][2 * detail + 1]; 

    for (int i = 0; i <= detail; i += 1) { 
      float theta = step * i; 
      float y = cos(theta); 
      float sin_theta = sin(theta); 
      float v = 1.0f - vstep * i; 

      for (int j = 0; j <= 2 * detail; j += 1) { 
        float phi = step * j; 
        float x = sin_theta * cos(phi); 
        float z = sin_theta * sin(phi); 

        float u = 1.0f - ustep * j; 

        texturedSphereX[i][j] = x; 
        texturedSphereY[i][j] = y; 
        texturedSphereZ[i][j] = z; 
        texturedSphereU[i][j] = u; 
        texturedSphereV[i][j] = v;
      }
    }
  }
}
