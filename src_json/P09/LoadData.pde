import java.util.Date;

// load data in GeoJSON format
// https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php
Earthquake3DMarker [] createEarthquakeMarkers(String dataSource) {
  JSONObject jsonData = loadJSONObject(dataSource);
  int numberOfEntries = jsonData.getJSONArray("features").size(); // features is the key GeoJSON array (features = earthquakes)

  Earthquake3DMarker [] eqMarkers = new Earthquake3DMarker[numberOfEntries];

  for (int i = 0; i < eqMarkers.length; i++) {

    JSONObject feature = jsonData.getJSONArray("features").getJSONObject(i);

    float magnitude = 0;
    if (feature.getJSONObject("properties").isNull("mag") == false) {

      magnitude = feature.getJSONObject("properties").getFloat("mag");
    }

    String location = feature.getJSONObject("properties").getString("place");
    Float longitude = feature.getJSONObject("geometry").getJSONArray("coordinates").getFloat(0);
    Float latitude = feature.getJSONObject("geometry").getJSONArray("coordinates").getFloat(1);

    eqMarkers[i] = new Earthquake3DMarker(longitude, latitude, magnitude, location, "");
    eqMarkers[i].setOnGlobe(globe);
  }

  return eqMarkers;
}
