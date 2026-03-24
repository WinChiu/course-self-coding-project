//Global variables for the screen height and width
int SCREEN_HEIGHT = 640;
int SCREEN_WIDTH = 480;

void setup() {
  size(640, 480); //Processing is pretty picky about how and where this function is placed, so be careful...
}

//this draw loop is called over and over again...
void draw() {
  background(0);   //set background to black
  for (int y = 0; y < SCREEN_WIDTH; y++) {
    for (int x = 0; x < SCREEN_HEIGHT; ++x) {
      color blue = color(183, 0, 255); //in this example, color values are between 0 and 255 (rather than 0.0 and 1.0)
      set(x, y, blue); //set the color of the pixel at (x,y) to blue
      //note that set() is slow - there is also a pixels[] function is you want to be fancy about it
    }
  }
}
