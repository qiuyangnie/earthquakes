Globe globe; 

Earthquake3DMarker[] earthquakeList;
Earthquake3DMarker selectedEarthquake = null;

// note the use of a new renderer P3D
// we are going to be working in a 3D coordinate system

String dataSource = "all_october-2018.geo.json";  // local resources: "all_october-2017.geo.json", "all_october-2018.geo.json"
//String dataSource = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson";

void setup() { 
  size(1280, 750, P3D); 
  frameRate(30);

  smooth();
  noStroke(); 

  globe = new Globe("land_ocean_ice_2048.png");  // options: "land_ocean_ice_2048.png", "earthlights.jpg",   "2000x1000-earth.png"
  earthquakeList = createEarthquakeMarkers(dataSource);
} 


void draw() { 
  background(0);

  if (selectedEarthquake != null) {
    selectedEarthquake.drawInformationAt(10, 10);
  }
  
  centre();  
  zooms();   
  rotations();
 
  globe.draw();

  for (Earthquake3DMarker eqM : earthquakeList) {
    eqM.draw(eqM == selectedEarthquake);
  }
} 

// to translate from 2D coordinates to 3D (ie. where is the mouse in 3D space)
// is difficult, so use the colour of the marker to select it
// we assume that the random allocation gives a different colour to each marker
// ~8000 earthqakes 16M colours so chances are good (but not guaranteed)
// we use mouseReleased as mousePressed is used to spin (rotate) the globe (see Control)

void mouseReleased() {
  // get the colour of the pixel under the mouse
  color pel = get(mouseX, mouseY);

  // assume there is no match
  selectedEarthquake = null;

  // check the colour of each marker for a match to the colour under the mouse
  for (Earthquake3DMarker eqM : earthquakeList) {
    if (eqM.matchMarker(pel)) {
      selectedEarthquake = eqM;
    }
  }
}
