// GLOBAL VARIABLES //<>//
// Here, I put all globals variables into the 'Globals' class just to keep them tidy. You don't have to do this.
public static class Globals {
  static final float PI = 3.14159265358979323846f;
  static final float epsilon = 0.000001f;

  static int SCREEN_WIDTH = 100;
  static int SCREEN_HEIGHT = 100;
  static int t;    //timer

  static ArrayList<Triangle> triangles;
  static float focalLength = SCREEN_HEIGHT;
  static PVector cameraPosition = new PVector(0, 0, -3);
  static PVector lightPos = new PVector(0, -0.5, -0.7);
  static PVector lightColor = new PVector(1*14.f, 1*14.f, 1*14.f);
  static PVector indirectLight = new PVector(1* 0.5f, 1* 0.5f, 1* 0.5f);

  //Movement
  static final float delta = 0.1;  //movement speed modifier for lights and camera
  static final float yaw = 0.05;
  static float cameraYaw = 0.0;
  static Matrix3x3 R = new Matrix3x3();
  
}

void updateRotation(Matrix3x3 r, float yaw) {
  r.setColumn(0, cos(yaw), 0, sin(yaw));
  r.setColumn(1, 0, 1, 0);
  r.setColumn(2, -sin(yaw), 0, cos(yaw));
}

// Represents an intersection with a triangle - see lab instructions
public static class Intersection {
  public PVector position;
  public float distance;
  public int triangleIndex;

  public Intersection() {
    position = new PVector();
    distance = Float.MAX_VALUE;
    triangleIndex = -1;
  }
}

// Main function to find the closest intersection - see lab instructions
public static boolean ClosestIntersection(PVector start, PVector dir, ArrayList<Triangle> triangles, Intersection closestIntersection, int ignoreTriangleIndex) {
  boolean intersected = false;

  for (int i = 0; i < triangles.size(); i++) {

    if (i == ignoreTriangleIndex) {
      continue;
    }

    Triangle triangle = triangles.get(i);
    PVector v0 = triangle.v0;
    PVector v1 = triangle.v1;
    PVector v2 = triangle.v2;
    //PVector e1 = v1;
    //e1.sub(v0);
    //PVector e2 = v2;
    //e2.sub(v0);
    //PVector b = start;
    //start.sub(v0);
    PVector e1 = PVector.sub(v1, v0);
    PVector e2 = PVector.sub(v2, v0);
    PVector b  = PVector.sub(start, v0);

    float[][] vals = {
      { - dir.x, e1.x, e2.x},
      {  -dir.y, e1.y, e2.y},
      { - dir.z, e1.z, e2.z}
    };

    Matrix3x3 A = new Matrix3x3(vals);

    float det = A.determinant();
    if (abs(det) < 1e-6) {
      continue;
    }

    Matrix3x3 Ainv = A.inverse();
    PVector x = Ainv.multiply(b);

    // checkintersection
    float t = x.x;
    float u = x.y;
    float v = x.z;
    // Q: do not set t >= 0. When casting from the surface to the light source while generating the shadow,
    // intersections with t ≈ 0 correspond to the surface itself (self-intersection), which causes shadow acne.
    // Instead, require t > epsilon to ignore hits that are too close to the ray origin.
    if (t >=  Globals.epsilon && u >= 0 && v >= 0 && u + v <= 1) {
      intersected = true;
      if (t < closestIntersection.distance) {
        // .set(start.add(dir.mult(t))) will also change the value of "start" and "dir", so don't do that.
        PVector intersectedPos = PVector.add(start, PVector.mult(dir, t));
        closestIntersection.position.set(intersectedPos);
        closestIntersection.distance = t;
        closestIntersection.triangleIndex = i;
      }
    }
  }

  return intersected;
}

//see lab instructions
PVector DirectLight(Intersection i)
{
  // Check if it's in shadow
  Intersection closestIntersection = new Intersection();
  PVector rayDir = PVector.sub(Globals.lightPos, i.position);
  rayDir.normalize();
  boolean isInShadow = ClosestIntersection(i.position, rayDir, Globals.triangles, closestIntersection, i.triangleIndex);
  if (isInShadow) {
    float pointToIntersectionDistance = PVector.dist(closestIntersection.position, i.position);
    float pointToLightDistance = PVector.dist(Globals.lightPos, i.position);
    if (pointToIntersectionDistance < pointToLightDistance) {
      return new PVector(0, 0, 0);
    }
  }

  // IF not in shadow...

  // Q: set the top light instead of round one
  PVector lightDir = PVector.sub(Globals.lightPos, i.position);
  lightDir.normalize();
  PVector norm = Globals.triangles.get(i.triangleIndex).normal;
  float r = PVector.dist(Globals.lightPos, i.position);
  PVector D = PVector.div(PVector.mult(Globals.lightColor, max(PVector.dot(lightDir, norm), 0)), 4*Globals.PI*r*r);


  return D;
  //return new PVector(0, 0, 0);
}

//THIS IS THE MAIN ENTRY POINT TO THE PROGRAM
void setup() {
  size(100, 100);
  background(0);

  //example of howto initialise a timer (if you want to do that)
  Globals.t = millis();

  //example of howto load a model in
  Globals.triangles = new ArrayList<>();
  CornellBox cb = new CornellBox();
  cb.loadTestModel(Globals.triangles);
  System.out.println("Loaded " + Globals.triangles.size() + " triangles.");

  //initialized rotate matrix
  updateRotation(Globals.R, Globals.cameraYaw);
}

void draw() {
  background(0);

  update();
  //call the update function below - for now, this is just used to calculate how long a single frame take to render

  // draw the whole screen, pixel by pixel
  for (int y = 0; y < Globals.SCREEN_HEIGHT; ++y)
  {
    for (int x = 0; x < Globals.SCREEN_WIDTH; ++x)
    {
      PVector dir = new PVector(x-(Globals.SCREEN_WIDTH / 2), y-(Globals.SCREEN_HEIGHT / 2), Globals.focalLength);
      dir = Globals.R.multiply(dir);
      dir.normalize();
      Intersection closestIntersection = new Intersection();
      boolean isIntersected = ClosestIntersection(Globals.cameraPosition, dir, Globals.triangles, closestIntersection, -1);

      if (isIntersected) {
        PVector triangleCol = Globals.triangles.get(closestIntersection.triangleIndex).col;
        float colorX = triangleCol.x*255;
        float colorY = triangleCol.y*255;
        float colorZ = triangleCol.z*255;
        PVector lightPower = DirectLight(closestIntersection);

        // Deal with indirect light



        //  color c = color(colorX, colorY, colorZ);
        // color c = color(lightPower.x*255, lightPower.y*255, lightPower.z*255);

        // p*D
        //color c = color(lightPower.x*colorX, lightPower.y*colorY, lightPower.z*colorZ);

        // p*(D+N)
        color c = color((lightPower.x + Globals.indirectLight.x)*colorX, (lightPower.y + Globals.indirectLight.y)*colorY, (lightPower.z + Globals.indirectLight.z)*colorZ);
        
        

        set(x, y, c);
      }
    }
  }
  
}

//updatePixels() {
//};  // https :/ /processing.org/reference/updatePixels_.html


void update() {
  //Compute frame time:
  int t2 = millis();
  float dt = float(t2 - Globals.t);
  Globals.t = t2;
  //println("Render time: " + dt +" ms.");
}

void keyPressed() {

  //Note : With the release of macOS Sierra, Apple changed how key repeat works, so keyPressed may not function as expected.
  //See https :/ /github.com/processing/processing/wiki/Troubleshooting#key-repeat-on-macos-sierra

  switch(key)
  {
  case 27 :  //ESCAPE key
    exit();
    break;
  case CODED:
    if (keyCode == UP) {
      Globals.cameraPosition.z += Globals.delta;
    } else if (keyCode == DOWN) {
      Globals.cameraPosition.z -= Globals.delta;
    } else if (keyCode == LEFT) {
      Globals.cameraYaw -= Globals.yaw;
      updateRotation(Globals.R, Globals.cameraYaw);
    } else if (keyCode == RIGHT) {
      Globals.cameraYaw += Globals.yaw;
      updateRotation(Globals.R, Globals.cameraYaw);
    }
    break;
  case 'w':
    Globals.lightPos.z += Globals.delta;
    break;
  case 's':
    Globals.lightPos.z -= Globals.delta;
    break;
  case 'a':
    Globals.lightPos.x -= Globals.delta;
    break;
  case 'd':
    Globals.lightPos.x += Globals.delta;
    break;
  case 'q':
    Globals.lightPos.y -= Globals.delta;
    break;
  case 'e':
    Globals.lightPos.y += Globals.delta;
    break;
  }
}
