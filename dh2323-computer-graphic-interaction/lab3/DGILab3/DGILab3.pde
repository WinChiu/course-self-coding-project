
// GLOBAL VARIABLES
// Here, I put all globals variables into the 'Globals' class just to keep them tidy. You don't have to do this.
public static class Globals {
  static final float PI = 3.14159265358979323846f;
  static final float epsilon = 0.000001f;

  static int SCREEN_WIDTH = 500;
  static int SCREEN_HEIGHT = 500;
  static int t;    //timer

  static ArrayList<Triangle> triangles;
  static float focalLength = SCREEN_WIDTH;
  static PVector cameraPosition = new PVector(0, 0, -3.001);
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

  return new PVector(0, 0, 0);
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
  //System.out.println("Loaded " + Globals.triangles.size() + " triangles.");
}

void draw() {
  background(0);

  ArrayList<PVector> vertices = new ArrayList<PVector>();

  // Iterate over all triangles
  for (int i = 0; i < Globals.triangles.size(); i++) {
    Triangle triangle = Globals.triangles.get(i);
    vertices.clear();
    vertices.add(triangle.v0);
    vertices.add(triangle.v1);
    vertices.add(triangle.v2);
    DrawPolygonEdges(vertices);
    //PVector projPos = new PVector(0, 0);
    //for (int v=0; v<3; v++)
    //{
    //  VertexShader (vertices.get(v), projPos);
    //  color c1 = color(255, 255, 255);
    //  set(int(projPos.x), int(projPos.y), c1);
    //}
  }
  updatePixels();
  update();  //call the update function below - for now, this is just used to calculate how long a single frame take to render

  ////draw the whole screen, pixel by pixel
  //for ( int y=0; y<Globals.SCREEN_HEIGHT; ++y )
  //{
  //  for ( int x=0; x<Globals.SCREEN_WIDTH; ++x )
  //  {
  //    //your code goes here
  //  }
  //}
}

void VertexShader (PVector v, PVector p) {
  // Translation and rotation to camerca pos


  PVector vCam =Globals.R.multiply(PVector.sub(v, Globals.cameraPosition));
  float x2D = (Globals.focalLength * vCam.x/vCam.z) + (Globals.SCREEN_WIDTH/2);
  float y2D = (Globals.focalLength * vCam.y/vCam.z) + (Globals.SCREEN_HEIGHT/2);
  p.x = x2D;
  p.y = y2D;
};

void Interpolate(PVector a, PVector b, int N, ArrayList<PVector> r) {
  if (N == 1) {
    PVector midpoint = PVector.lerp(a, b, 0.5);
    r.add(midpoint);
    return;
  }
  for (int i = 0; i < N; i++) {
    float t = float(i) / (N-1);
    PVector interpolated = PVector.lerp(a, b, t);
    r.add(interpolated);
  }
}

void DrawLine(PVector a, PVector b, PVector col) {
  PVector delta = PVector.sub(a, b);
  delta.x = abs(delta.x);
  delta.y = abs(delta.y);
  int npixels = int(max(delta.x, delta.y)) + 1;
  ArrayList<PVector> line = new ArrayList<PVector>();
  Interpolate(a, b, npixels, line);

  color c = color(col.x, col.y, col.z);
  for (int i=0; i<line.size(); ++i) {

    set(int(line.get(i).x), int(line.get(i).y), c);
  }
};

void DrawPolygonEdges(ArrayList<PVector> vertices)
{

  int V = vertices.size();


  // Transform each vertex from 3D world position to 2D image position
  
  // Q: This is a shallow copy!!!!!!!!!!!!!!!!!!!! Do not use this function
  // ArrayList<PVector> projectedVertices = new ArrayList<PVector>(vertices);

  ArrayList<PVector> projectedVertices = new ArrayList<PVector>();
  for (int i=0; i<V; ++i)
  {
    //VertexShader(vertices.get(i), projectedVertices.get(i));
    PVector p = new PVector();
    VertexShader(vertices.get(i), p);
    projectedVertices.add(p);
  }

  // Loop over all vertices and draw the edge from it to the next vertex
  for (int i =0; i<V; ++i)
  {
    int j = (i+1) % V; // The next vertex
    PVector col = new PVector(255, 255, 255);
    DrawLine(projectedVertices.get(i), projectedVertices.get(j), col);
  }
}


void updatePixels() {
  //https://processing.org/reference/updatePixels_.html
};

void update() {
  // Compute frame time:
  int t2 = millis();
  float dt = float(t2-Globals.t);
  Globals.t = t2;
  //println("Render time: " + dt + " ms.");
  updateRotation(Globals.R, 0);
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
