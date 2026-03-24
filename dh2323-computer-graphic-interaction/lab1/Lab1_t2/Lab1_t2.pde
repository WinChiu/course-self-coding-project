
import java.util.ArrayList; // import the ArrayList class

//Global variables for the screen height and width
int SCREEN_HEIGHT = 640;
int SCREEN_WIDTH = 480;


//====== Task 2.1 ======//

//void Interpolate(float a, float b, int numResults, FloatList r) {
//  float d = abs(a - b)/(numResults-1);
//  for (int i = 0; i < numResults; i++) {
//    r.append(a + i * d);
//  }
//}

//void setup() {
//  size(640, 480);
//  FloatList result = new FloatList();
//  Interpolate(5.0, 14.0, 10, result);
//  for (int i = 0; i < result.size(); i++) {
//    print(String.format("%.0f ", result.get(i)));
//  }
//}

//void draw() {
//  background(0);
//  for (int y = 0; y < SCREEN_WIDTH; y++) {
//    for (int x = 0; x < SCREEN_HEIGHT; ++x) {
//      color blue = color(183, 0, 255);
//      set(x, y, blue);
//    }
//  }
//}


//====== Task 2.2 ======//

//ArrayList<PVector> resultVectors = new ArrayList<PVector>();

//void Interpolate(PVector a, PVector b, int numResults, ArrayList<PVector> r) {
//  int dCount  = numResults-1;
//  float dx = (b.x-a.x)/dCount;
//  float dy = (b.y-a.y)/dCount;
//  float dz = (b.z-a.z)/dCount;
//  for (float i = 0.0; i < numResults; i++) {
//    PVector tempPVector = new PVector(
//      a.x + dx * i,
//      a.y + dy * i,
//      a.z + dz * i
//      );
//    r.add(tempPVector);
//  }
//}


//void setup() {
//  size(640, 480);
//  PVector a = new PVector(1, 4, 9.2);
//  PVector b = new PVector(4, 1, 9.8);
//  Interpolate(a, b, 4, resultVectors);
//  for (int i = 0; i < resultVectors.size(); ++i) {
//    PVector r = resultVectors.get(i);
//    print(String.format("( %.0f, ", r.x));
//    print(String.format("%.0f, ", r.y));
//    print(String.format("%.1f )", r.z));
//  }
//}

//void draw() {
//  background(0);
//  for (int y = 0; y < SCREEN_WIDTH; y++) {
//    for (int x = 0; x < SCREEN_HEIGHT; ++x) {
//      color blue = color(183, 0, 255);
//      set(x, y, blue);
//    }
//  }
//}


//====== Task 2.3 ======//

ArrayList<PVector> leftSide = new ArrayList<PVector>();
ArrayList<PVector> rightSide = new ArrayList<PVector>();
PVector topLeft = new PVector(255, 0, 0); // red
PVector topRight = new PVector(0, 0, 255); // blue
PVector bottomLeft = new PVector(255, 255, 0); // yellow
PVector bottomRight = new PVector(0, 255, 0); // green

void Interpolate(PVector a, PVector b, int numResults, ArrayList<PVector> r) {
  int dCount  = numResults-1;
  float dx = (b.x-a.x)/dCount;
  float dy = (b.y-a.y)/dCount;
  float dz = (b.z-a.z)/dCount;
  for (float i = 0.0; i < numResults; i++) {
    PVector tempPVector = new PVector(
      a.x + dx * i,
      a.y + dy * i,
      a.z + dz * i
      );
    r.add(tempPVector);
  }
}

void setup() {
  size(640, 480);
  Interpolate(topLeft, bottomLeft, height, leftSide);
  Interpolate(topRight, bottomRight, height, rightSide);
}

void draw() {
  background(0);
  for (int y = 0; y < SCREEN_WIDTH; y++) {
    ArrayList<PVector> row = new ArrayList<PVector>();
    Interpolate(leftSide.get(y), rightSide.get(y), width, row);
    for (int x = 0; x < SCREEN_HEIGHT; ++x) {
      color colorBlock = color(row.get(x).x, row.get(x).y, row.get(x).z);
      set(x, y, colorBlock);
    }
  }
}
