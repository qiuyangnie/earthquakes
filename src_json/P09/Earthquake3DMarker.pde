// same as last week
class Earthquake3DMarker {
  private float longitude;
  private float latitude;
  private float magnitude;
  private String location;
  private String date;
  private color markerColour;
  private PFont descriptionFont;

  private Globe onGlobe;

  Earthquake3DMarker(float longitude, float latitude, float im, String iloc, String idate) {
    this.longitude = radians(longitude);
    this.latitude = radians(latitude);
    this.magnitude = im;
    this.location = iloc;
    this.date = idate;

    colorMode(HSB);
    this.markerColour = color(random(0, 255), random(100, 250), random(200, 255), 255);
    this.descriptionFont = createFont("Helvetica Neue", 14);
  }

  void setOnGlobe(Globe globe) {
    this.onGlobe = globe;
  }

  void draw() {
    colorMode(HSB);
    stroke(this.markerColour); 
    float mag = map(this.magnitude, 0, 10, 0, 20);
    onGlobe.drawSpike(this.latitude, this.longitude, mag);
  }

  // draw the marker by placing a spike on the globe
  // but if this marker is the selected one animate it
  void draw(boolean selected) {
    this.draw();

    if (selected) {
      float highlight = random(0,30);  // different random value each time so the spike will animate up and down
      onGlobe.drawSpike(this.latitude, this.longitude, highlight);
    }
  }

  void drawInformationAt(float x, float y) {
    rectMode(CORNER);
    textFont(descriptionFont);
    textAlign(LEFT, TOP);
    String s1 = "Mag: " + this.magnitude + "  in " + this.location + " occurred on ";
    String s2 = this.date;
    fill(255);
    noStroke();
    rect(x, y + 20, 220, 80);
    fill(0);
    text(s1, x + 5, y + 25, 210, 60);
    text(s2, x + 5, y + 70, 210, 60);
  }

  boolean matchMarker(color c) {
    return c == this.markerColour;
  }
}
