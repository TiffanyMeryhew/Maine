PImage maineImage;
Table maineLocalTable;
int rowCount;
Table maineDataTable;
float maineDataMin = MAX_FLOAT;
float maineDataMax = MIN_FLOAT;


void setup(){
  size(417,619);
  maineImage = loadImage("maine.gif"); 
  maineLocalTable = new Table("maineLocal.tsv");
  rowCount = maineLocalTable.getRowCount();
  maineDataTable = new Table("maineData.tsv");
  PFont font = loadFont("Courier-Bold-12.vlw");
  textFont(font);
  
  smooth();
  noStroke();
  
  
  for(int row=0; row<rowCount; row++){
    int value1 = maineDataTable.getInt(row, 1);
    float value2 = maineDataTable.getFloat(row, 2);
    if(value1>maineDataMax){
      maineDataMax = value1;
    }
    if(value2<maineDataMin){
      maineDataMin = value2;
    }
  }
}

void draw(){
  background(255);
  image(maineImage, 0, 0);
  
  
  for(int row=0; row<rowCount; row++){
    String name = maineDataTable.getRowName(row);
    float x = maineLocalTable.getFloat(name, 1);
    float y = maineLocalTable.getFloat(name, 2);
    drawData(x, y, name);
  }
}

void drawData(float x, float y, String name){
  int value1 = maineDataTable.getInt(name, 1);
  float value2 = maineDataTable.getFloat(name, 2);
  float radius =0;
  if(value1 > 0){
    radius = map(value1, 0, maineDataMax, 1.5, 15);
    fill(#333366);  //blue
  } else {
    radius = map(value2, 0, maineDataMin, 1.5, 15);
    fill(#EC5166); //red
  }
  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);
  
  if(dist(x, y, mouseX, mouseY)<radius+2){
    fill(0);
    textAlign(CENTER);
    //String name = maineDataTable.getString(name);
    text(name + " " + value1 + " " + value2, x, y-radius-4);
  }
}
