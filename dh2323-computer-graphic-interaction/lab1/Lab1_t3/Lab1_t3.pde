
import java.util.ArrayList; // import the ArrayList class
import java.util.Random;


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

// 要用數學??? 好像不需要用程式碼吧???
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

////====== Task 3.3 ======//
//ArrayList<PVector> stars = new ArrayList<PVector>( 1000 );
//int H = 480;
//int W = 640;
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
//  }
//}

//void draw() {
//  background(0);
//  int f = H/2;
//  PVector center = new PVector(W/2, H/2);
//  color white = color(255, 255, 255);
//  // Project All Point to 2D
//  for (int i = 0; i < stars.size(); i++) {
//    PVector star = stars.get(i);
//    int u = round(f * (star.x/star.z) + center.x);
//    int v = round(f * (star.y/star.z) + center.y);
//    set(u, v, white);
//  }
//}


//====== Task 3.4 ======//

ArrayList<PVector> stars = new ArrayList<PVector>( 1000 );
int H = 480;
int W = 640;
int t = millis();
float v = 0.0001;
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
  }
}

void update() {
  int t2 = millis();
  float dt = t2-t;
  t = t2;

  for (int s = 0; s < stars.size(); s++) {
    PVector star = stars.get(s);
    star.z = star.z - v*dt;
    if (star.z <= 0) {
      star.z +=1;
    }
    if (star.z > 1) {
      star.z -=1;
    }
  }
};


void draw() {
  update();
  background(0);
  
  int f = H/2;
  PVector center = new PVector(W/2, H/2);

  // Project All Point to 2D
  for (int i = 0; i < stars.size(); i++) {
    PVector star = stars.get(i);
    float bright = 0.2*255/pow(star.z, 2);
    colorMode(HSB, 255);
    color c = color(0, 0, bright);
    int u = round(f * (star.x/star.z) + center.x);
    int v = round(f * (star.y/star.z) + center.y);
    set(u, v, c);
  }
}
