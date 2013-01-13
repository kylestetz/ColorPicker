class ColorViewer {
  
  PImage img, slider;
  int x, y;
  int w = 256, h = 256;
  int id = 100;
  
  int colorX = 276;
  int colorY = 20;
  
  // slider
  int sliderX, sliderY;
  
  PImage alphaMask;
  PGraphics grid;
  
  ColorViewer(int x, int y){
    this.x = x;
    this.y = y;
    
    img = createImage(256, 256, ARGB);
    alphaMask = createImage(256, 256, RGB);
    colorX = x + img.width - 1;
    colorY = y;
    
    presetAlpha(255);
    
    make(0.0);
    
    grid = createGraphics(256, 256, JAVA2D);
    drawGrid();
  }
  
  void draw(){
    // gradient
    image(grid, x, y);
    image(img, x, y);
    
    // selector circle
    stroke(0);
    noFill();
    ellipse(colorX, colorY, 10, 10);
    
  }
  
  void update(float h){
    img.loadPixels();
    for(int i = 0; i < 256; i++){
      for(int j = 0; j < 256; j++){
        
        int loc = i + (255 - j) * img.width;
        int c = Color.HSBtoRGB(h, i/255.0, j/255.0);
        img.pixels[loc] = c;
        
      }
    }
    img.updatePixels();
    img.mask(alphaMask);
    graphics.colorBox.colorIs( img.pixels[ (colorX - x) + (colorY - y)*img.width ] );
  }
  
  void mouseIsDragging(int mx, int my){
    //mouse offset
    mx -= x;
    my -= y;
    mx = constrain(mx, 0, 255);
    my = constrain(my, 0, 255);
    colorX = mx + x;
    colorY = my + y;
    
    int loc = mx + my*256;
    img.loadPixels();
    graphics.colorBox.colorIs(img.pixels[loc]);
  }
  
  void setAlpha(float val){
    alphaMask.loadPixels();
    for(int i = 0; i < alphaMask.pixels.length; i++){
      alphaMask.pixels[i] = color(val);
    }
    alphaMask.updatePixels();
    img.mask(alphaMask);
    graphics.colorBox.colorIs(img.pixels[colorX-x + (colorY-y)*img.width]);
  }
  
  void presetAlpha(float val){
    alphaMask.loadPixels();
    for(int i = 0; i < alphaMask.pixels.length; i++){
      alphaMask.pixels[i] = color(val);
    }
    alphaMask.updatePixels();
    img.mask(alphaMask);
  }
  
  //---------------------------------------------------------------------------
  
  void make(float h){
    img.loadPixels();
    for(int i = 0; i < 256; i++){
      for(int j = 0; j < 256; j++){
        
        int loc = i + (255 - j) * img.width;
        int c = Color.HSBtoRGB(h, i/255.0, j/255.0);
        img.pixels[loc] = c;
        
      }
    }
    img.updatePixels();
    img.mask(alphaMask);
  }
  
  void drawGrid(){
    grid.beginDraw();
    grid.noStroke();
    grid.background(255);
    grid.fill(200);
    for(int i = 0; i < grid.width/4; i++){
      for(int j = 0; j < grid.height/4; j++){
        if(i % 4 == 0 && j % 4 == 0){
          grid.rect(i*4, j*4, 8, 8);
        } else if(i % 4 == 0 && j % 4 == 2){
          grid.rect(i*4 + 8, j*4, 8, 8);
        }
      }
    }
    grid.endDraw();
  }
  
}
