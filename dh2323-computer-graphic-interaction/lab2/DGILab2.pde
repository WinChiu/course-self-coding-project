
// GLOBAL VARIABLES
// Here, I put all globals variables into the 'Globals' class just to keep them tidy. You don't have to do this.
public static class Globals{
  static final float PI = 3.14159265358979323846f;
  static final float epsilon = 0.000001f;

  static int SCREEN_WIDTH = 500;
  static int SCREEN_HEIGHT = 500;
  static int t;    //timer

  static ArrayList<Triangle> triangles;
  //static float focalLength = 
  //static PVector cameraPosition = 
  //static PVector lightPos = 
  //static PVector lightColor = 
  //static PVector indirectLight =

  // Movement
  static final float delta = 0.1;  //movement speed modifier for lights and camera
  static final float yaw = 0.05;
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
public static boolean ClosestIntersection(PVector start, PVector dir, ArrayList<Triangle> triangles, Intersection closestIntersection) {
    boolean intersected = false;

    //your code here...

    return intersected;
}

//see lab instructions
PVector DirectLight(Intersection i)
{
  //your code here
  
  return R;
}

//THIS IS THE MAIN ENTRY POINT TO THE PROGRAM
void setup() {
  size(500, 500);
  background(0);
  
  //example of how to initialise a timer (if you want to do that)
  Globals.t = millis();  
  
  //example of how to load a model in
  Globals.triangles = new ArrayList<>();
  CornellBox cb = new CornellBox();
  cb.loadTestModel(Globals.triangles);
  System.out.println("Loaded " + Globals.triangles.size() + " triangles.");
}

void draw() {
    background(0);
    
    update();  //call the update function below - for now, this is just used to calculate how long a single frame take to render

    //draw the whole screen, pixel by pixel
    for( int y=0; y<Globals.SCREEN_HEIGHT; ++y )
    {
      for( int x=0; x<Globals.SCREEN_WIDTH; ++x )
      {
          //your code goes here
          
        }
      }
    }
    
    updatePixels();  //https://processing.org/reference/updatePixels_.html
}

void update() {
  // Compute frame time:
  int t2 = millis();
  float dt = float(t2-Globals.t);
  Globals.t = t2;
  println("Render time: " + dt + " ms.");
}

void keyPressed() {
  
  //Note: With the release of macOS Sierra, Apple changed how key repeat works, so keyPressed may not function as expected. 
  //See https://github.com/processing/processing/wiki/Troubleshooting#key-repeat-on-macos-sierra
  
  switch(key)
  {
    case 27:  //ESCAPE key
      exit();
      break;
    case CODED: 
      if (keyCode == UP) {
        // Move camera forward
      } else if (keyCode == DOWN) {
        // Move camera backwards
      } else if (keyCode == LEFT) {
        // Move camera left
      } else if (keyCode == RIGHT) {
        // Move camera right
      }
      break;
    case 'w':

      break;
    case 's':

      break;
    case 'a':

      break;
    case 'd':

      break;
    case 'q':

      break;
    case 'e':

      break;
  }
}
