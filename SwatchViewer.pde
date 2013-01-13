class SwatchViewer {
  
  int x, y, w, h;
  int offset = 6;
  int id = 103;
  
  int selection = 0;
  boolean full = false;
  
  Swatch[] swatches = new Swatch[0];
  PrintWriter output;
  
  String[] saved;
  
  SwatchViewer(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    //grab some swatches.
    saved = loadStrings("/data/swatches.txt");
    loadSwatches(saved);
    
    if(swatches.length > 0){
      selection = 0;
      swatches[selection].selected = true;
    }
  }
  
  //---------------------------------------------------------------------------------
  
  void draw(){
    if(frameCount == 1 && swatches.length != 0){
      graphics.copyBox.colorIs( swatches[0].c );
    }
    fill(255);
    noStroke();
    rect(x, y, w, h);
    
    drawGrid();
  }
  
  void drawGrid(){
    int row = 0;
    for(int i = 0; i < swatches.length; i++){
      if(i % 12 == 0 && i != 0){
        row++;
      }
      swatches[i].draw( x + offset + (i%12)*24, y + offset + row*24 );
    }
  }
  
  //--------------------------------------------------------------------------------
  
  void mouseIsDragging(int mx, int my){
    // constrain mouse to swatch box
    mx -= x + 4;
    my -= y + 4;
    mx = constrain(mx, 0, 264);
    my = constrain(my, 0, 110);
    int mouseSelect = int(mx / 24) + int(my / 24)*12;
    if(mouseSelect < swatches.length){
      newSelection(mouseSelect);
    }
  }
  
  void newSelection(int index){
    if(swatches.length > 1){
      swatches[selection].selected = false;
    }
    swatches[index].selected = true;
    selection = index;
    graphics.copyBox.colorIs( swatches[index].c );
  }
  
  void addSwatch(color c){
    Swatch s = new Swatch(c);
    s.selected = true;
    swatches = (Swatch[]) append(swatches, s);
    if(swatches.length != 0){
      newSelection(swatches.length - 1);
    }
    if(swatches.length == 60){
      full = true;
    }
  }
  
  void removeSwatch(){
    if(swatches.length > 2){
      Swatch[] firsthalf = (Swatch[]) subset(swatches, 0, selection);
      Swatch[] secondhalf = (Swatch[]) subset(swatches, selection + 1);
      swatches = (Swatch[]) concat(firsthalf, secondhalf);
    } else if(swatches.length == 2){
      if(selection == 1){
        swatches = (Swatch[]) shorten(swatches);
      } else {
        swatches = (Swatch[]) subset(swatches, 1);
      }
    } else if(swatches.length == 1){
      swatches = (Swatch[]) shorten(swatches);
    }
    
    if(selection > 0){
      selection--;
      newSelection(selection);
    } else if(selection == 0 && swatches.length > 0) {
      newSelection(0);
    }
    
    if(swatches.length == 0){
      graphics.copyBox.colorIs( color(255) );
    }
  }
  
  boolean isFull(){
    return full;
  }
  
  boolean isEmpty(){
    if(swatches.length == 0){
      return true;
    } else {
      return false;
    }
  }
  
  color selection(){
    if(swatches.length != 0){
      return swatches[selection].c;
    } else {
      return color(255);
    }
  }
  
  void left(){
    if(selection > 0){
      newSelection(selection - 1);
    }
  }
  
  void right(){
    if(selection + 1 < swatches.length){
      newSelection(selection + 1);
    }
  }
  
  void down(){
    if(selection + 12 < swatches.length){
      newSelection(selection + 12);
    }
  }
  
  void up(){
    if(selection - 12 > 0){
      newSelection(selection - 12);
    }
  }
  
  //----------------------------------------------------------------------------------------------------SAVE

  void saveSwatches(){
    try {
      BufferedWriter writer = new BufferedWriter( new FileWriter(dataPath("swatches.txt"), false) );
      for(int i = 0; i < swatches.length; i++){
        writer.write( hex(swatches[i].c) + "\n" );
      }
      writer.flush();
      writer.close();
    } catch (IOException ioe){
      println("error: " + ioe);
    }
  }
  
  void loadSwatches(String[] sw){
    if(sw != null){
      int l = sw.length;
      l = constrain(l, 0, 59);
      for(int i = 0; i < l; i++){
        Swatch s = new Swatch( unhex(sw[i]) );
        swatches = (Swatch[]) append(swatches, s);
      }
    }
  }
  
}


//----------------------------------------------------------------------------------------------------SWATCH

class Swatch {
  
  color c;
  boolean selected = false;
  
  Swatch(color c){
    this.c = c;
  }
  
  void draw(int x, int y){
    if(selected){
      noStroke();
      fill(0);
      rect(x - 4, y - 4, 28, 28);
      fill(255);
      rect(x - 2, y - 2, 24, 24);
    }
    
    if(c == color(255)){
      stroke(220);
    } else {
      noStroke();
    }
    
    fill(c);
    rect(x, y, 20, 20);
  }
  
}
