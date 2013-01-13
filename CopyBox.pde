class CopyBox {
  
  PImage copySign, minus;
  PGraphics grid;
  
  int x, y, w, h;
  color currentColor = color(255);
  int id = 104;
  
  String rVal = "255", gVal = "000", bVal = "000", hexVal = "FFFFFF", alphaVal = "255";
  
  CopyBox(int x, int y, int w){
    this.x = x;
    this.y = y;
    this.w = w;
    h = w;
    
    copySign = loadImage("/data/copy.png");
    minus = loadImage("/data/minus.png");
    grid = createGraphics(w, w, JAVA2D);
    
    drawGrid();
  }
  
  void draw(){
    image(grid, x, y);
    fill( currentColor );
    noStroke();
    rect(x, y, w, h);
    
    if(graphics.mouseOverID == id && !graphics.swatchViewer.isEmpty()){
      stroke(255);
      line(x, y + w/2, x + w - 1, y + w/2);
      line(x - 8, y + w/2 + 8, x, y + w/2);
      if(mouseY < y + w/2){
        image(minus, x, y);
      } else {
        image(copySign, x, y + w/2);
      }
    }
    
    fill(0);
    text(rVal + ", " + gVal + ", " + bVal + "\n" + "alpha: " + alphaVal + "\n" + "#" + hexVal, x, y + h + 22);
  }
  
  void clicked(int mx, int my){
    if(!graphics.swatchViewer.isEmpty()){
      if(my < y + w/2){
        graphics.removeSwatch();
      } else {
        inputController.clipboard(currentColor);
      }
    }
  }
  
  void colorIs(color c){
    currentColor = c;
    rVal = nf( int(red(c)), 3);
    gVal = nf( int(green(c)), 3);
    bVal = nf( int(blue(c)), 3);
    hexVal = hex( c );
    hexVal = hexVal.substring(2, hexVal.length());
    alphaVal = nf( int(alpha(c)), 3 );
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
