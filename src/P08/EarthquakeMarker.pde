class EarthquakeMarker {
  float x;
  float y;
  float magnitude;
  String location;
  String date;
  
  color markerColour;
  float markerSize;


  public EarthquakeMarker(float x, float y, float m, String loc, String date) {
    this.x = x;
    this.y = y;
    this.magnitude = m;
    this.location = loc;
    this.date = date;
    
    this.markerSize = this.magnitude * 3;
  }

  public void draw() {
    
    colorMode(HSB);
    this.markerColour = color(random(0,255), random(100,250), random(200,255), 200);

    stroke(255);
    fill(this.markerColour);

    ellipse(this.x, this.y, this.markerSize, this.markerSize);
  }
  
  void hover(){
    
    float distanceMarkerandMouse = dist(this.x, this.y, mouseX, mouseY); 
    
    if(distanceMarkerandMouse < this.markerSize){
      
      //fill(0);
      //textAlign(LEFT, TOP);
      //text(this.location, this.x, this.y);
      //fill(255);
      //rect(min(mouseX, width - 220), mouseY + 20, 220, 80);
      
      fill(255);
      textAlign(LEFT, TOP);
      String s1 = "Mag: " + this.magnitude;
      text(this.location, this.x, this.y);
      text(s1, this.x, this.y);
    
    }
  
  }
  
  
}
