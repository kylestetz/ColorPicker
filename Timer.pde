class Timer {
  
  int ms; int prevms;
  boolean done = false;
  boolean firstframe = true;
  
  Timer(){
  }
  
  void run(int interval){
    if(firstframe == true && done == false){
      prevms = millis();
      firstframe = false;
    }
    
    if(prevms + interval < millis() ){
      done = true;
    }
  }
  
  void reset(){
    firstframe = true;
    done = false;
  }
}
