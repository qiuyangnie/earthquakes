EarthquakeMarker [] createEarthquakeMarkers(String dataSource) {
  String [] rawData = loadStrings(dataSource);
  EarthquakeMarker [] earthquakes = new EarthquakeMarker[rawData.length - 1];
  
  //ignore header
  for(int i = 1; i<rawData.length; i++){
    
    String record = makeSplitFriendly(rawData[i]);
    String[] fields = split(record, ",");
    
    float x = map(float(fields[2]), -180, 180, 0, width);
    float y = map(float(fields[1]), 90, -90, 0, height);
    float magnitude = float(fields[4]);
    String location = fields[13];
    String date = fields[0];
    
    earthquakes[i-1] = new EarthquakeMarker(x, y, magnitude, location, date);

  }
  
  return earthquakes;
}

// splitting based on commas only
// however quoted text can contain commas (e.g. place names)
// find the quotes and process the text within them to replace
// commas that do not denote a field with a semi-colon
String makeSplitFriendly(String l) {
  
  int openQuote = l.indexOf("\"");
  int closeQuote = l.lastIndexOf("\"");
  
  // unlike String, StringBuilder is mutable
  // so we can change individual characters
  StringBuilder sfsBuilder = new StringBuilder(l);
  
  for (int i = (openQuote + 1); i < closeQuote; i += 1) {
    if (sfsBuilder.charAt(i) == ',') {
      sfsBuilder.setCharAt(i, ';');
    }
  }
  sfsBuilder.deleteCharAt(openQuote);
  sfsBuilder.deleteCharAt(closeQuote-1); // already deleted the first quote

  return sfsBuilder.toString();
}
