PImage worldMap;
EarthquakeMarker[] earthquakeList;

// Data site
//  https://earthquake.usgs.gov/earthquakes/feed/v1.0/csv.php
// Data Source
// https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv

String dataSource = "all_october-2018.csv";

void setup() {
  size (2000, 1000);

  worldMap = loadImage("2000x1000-earth.png");
  earthquakeList = createEarthquakeMarkers(dataSource);
}

void draw() {
  background(worldMap);
  
  for(EarthquakeMarker eqM : earthquakeList){
    
    eqM.draw();
    eqM.hover();
  
  }
}
