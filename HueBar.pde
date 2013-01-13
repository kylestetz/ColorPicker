class HueBar {
  
  PImage img;
  int x, y, w, h;
  int id = 101;
  int locator = 0;
  
  HueBar(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    img = createImage(w, h, RGB);
    createBar();
  }
  
  void draw(){
    image(img, x, y);
    //stroke(150);
    stroke(0);
    line(x, y + locator, x + w - 1, y + locator);
  }
  
  void createBar(){
    img.loadPixels();
    for(int i = 0; i < img.height; i++){
      int c = Color.HSBtoRGB( i/256.0, 1.0, 1.0);
      for(int j = 0; j < img.width; j++){
        img.pixels[j + i*img.width] = c;
      }
    }
    img.updatePixels();
  }
  
  void mouseIsDragging(int mx, int my){
    
    //mouse offset
    my -= y;
    my = constrain(my, 0, img.height);
    locator = my;
    graphics.colorViewer.update( my / float(img.height) );
    
  }
  
}
