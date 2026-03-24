
import java.util.ArrayList; // import the ArrayList class
import java.util.Random;
//Global variables for the screen height and width
int SCREEN_HEIGHT = 640;
int SCREEN_WIDTH = 480;


//====== Task 3.1 ======//

//ArrayList<PVector> stars = new ArrayList<PVector>( 1000 );

//void setup() {
//  size(640, 480);
//  Random rnd = new Random();
//  for (int i = 0; i < 1000; i++) {
//    float x = rnd.nextFloat()*2-1;
//    float y = rnd.nextFloat()*2-1;
//    float z = rnd.nextFloat();
//    while (z==0.0) {
//      z = rnd.nextFloat();
//    }
//    PVector tempVector = new PVector(x, y, z);
//    stars.add(tempVector);
//    print(stars.get(i));
//    print("\n");
//  }
//}

//void draw() {
//  background(0);
//}


//====== Task 3.2 ======//


ArrayList<PVector> stars = new ArrayList<PVector>( 1000 );

void setup() {
  size(640, 480);
  Random rnd = new Random();
  for (int i = 0; i < 1000; i++) {
    float x = rnd.nextFloat()*2-1;
    float y = rnd.nextFloat()*2-1;
    float z = rnd.nextFloat();
    while (z==0.0) {
      z = rnd.nextFloat();
    }
    PVector tempVector = new PVector(x, y, z);
    stars.add(tempVector);
    print(stars.get(i));
    print("\n");
  }
}

void draw() {
  background(0);
}
