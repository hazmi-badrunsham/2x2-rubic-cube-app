import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2x2 Rubik\'s Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 212, 212, 212), 
      ),
      home: const CubeScreen(),
    );
  }
}

class CubeState {
  List<List<Color>> faces = [
    [Colors.red, Colors.red, Colors.red, Colors.red], // Front
    [Colors.blue, Colors.blue, Colors.blue, Colors.blue], // Left
    [Colors.green, Colors.green, Colors.green, Colors.green], // Right
    [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], // Back
    [Colors.orange, Colors.orange, Colors.orange, Colors.orange], // Top
    [Colors.white, Colors.white, Colors.white, Colors.white], // Bottom
  ];

  // Rotate top face to the left, modify if necessary // clockwise rotation kat row atas
  void rotateTop() {
    // Store the top row of each face
    List<Color> topRowFront = [faces[0][0], faces[0][1]];
    List<Color> topRowLeft = [faces[1][0], faces[1][1]];
    List<Color> topRowRight = [faces[2][0], faces[2][1]];
    List<Color> topRowBack = [faces[3][0], faces[3][1]];

    // Rotate top face //
    // Rotate the top face (faces[4]) clockwise:
    // The bottom-left becomes the top-left, top-left becomes the top-right,
    // bottom-right becomes bottom-left, and top-right becomes bottom-right.
    List<Color> tempTop = [...faces[4]];
    faces[4] = [tempTop[2], tempTop[0], tempTop[3], tempTop[1]];


    // Update adjacent faces
    faces[0][0] =  topRowLeft[0]; //top row of front cube move to left 
    faces[0][1] =  topRowLeft[1]; 

    faces[1][0] = topRowBack[0]; //top row of left cube move to back
    faces[1][1] = topRowBack[1];
  
    faces[3][0] = topRowRight[0]; //top row of back cube move to right
    faces[3][1] = topRowRight[1];

    faces[2][0] = topRowFront[0]; //top row of right cube move to ront
    faces[2][1] = topRowFront[1];

  }
  
  // Rotate top face to the left, modify if necessary
void rotateBottom() {
  // Store the current bottom row states of adjacent faces
  List<Color> botRowFront = [faces[0][2], faces[0][3]]; // Front face bottom row
  List<Color> botRowLeft = [faces[1][2], faces[1][3]];  // Left face bottom row
  List<Color> botRowRight = [faces[2][2], faces[2][3]]; // Right face bottom row
  List<Color> botRowBack = [faces[3][2], faces[3][3]];  // Back face bottom row

  // Rotate the bottom face (faces[5]) clockwise:
  // The bottom-left becomes the top-left, top-left becomes the top-right,
  // bottom-right becomes bottom-left, and top-right becomes bottom-right.
  List<Color> tempBot = [...faces[5]];
  faces[5] = [tempBot[2], tempBot[0], tempBot[3], tempBot[1]];

  // Update adjacent faces' bottom rows in clockwise direction
  faces[0][2] = botRowLeft[0];
  faces[0][3] = botRowLeft[1];

  faces[1][2] = botRowBack[0];
  faces[1][3] = botRowBack[1];

  faces[3][2] = botRowRight[0];
  faces[3][3] = botRowRight[1];

  faces[2][2] = botRowFront[0];
  faces[2][3] = botRowFront[1];
}


  void rotateLeft() {
  // Store the left column of adjacent faces
  List<Color> leftColFront = [faces[0][0], faces[0][2]];
  List<Color> leftColTop = [faces[4][0], faces[4][2]];
  List<Color> leftColBack = [faces[3][0], faces[3][2]]; 
  List<Color> leftColBottom = [faces[5][0], faces[5][2]];

  // Rotate the left face (faces[1]) clockwise
  List<Color> tempLeft = [...faces[1]];
  faces[1] = [tempLeft[2], tempLeft[0], tempLeft[3], tempLeft[1]];

  // Update adjacent columns
  faces[0][0] = leftColTop[0];
  faces[0][2] = leftColTop[1];

  faces[4][0] = leftColBack[0];
  faces[4][2] = leftColBack[1];

  faces[3][0] = leftColBottom[0];
  faces[3][2] = leftColBottom[1];

  faces[5][0] = leftColFront[0];
  faces[5][2] = leftColFront[1];
}
void rotateRight() {
  // Store the right column of adjacent faces
  List<Color> rightColFront = [faces[0][1], faces[0][3]];
  List<Color> rightColTop = [faces[4][1], faces[4][3]];
  List<Color> rightColBack = [faces[3][1], faces[3][3]]; 
  List<Color> rightColBottom = [faces[5][1], faces[5][3]];

  // Rotate the right face (faces[2]) clockwise
  List<Color> tempRight = [...faces[2]];
  faces[2] = [tempRight[2], tempRight[0], tempRight[3], tempRight[1]];

  // Update adjacent columns
  faces[0][1] = rightColTop[0];
  faces[0][3] = rightColTop[1];

  faces[4][1] = rightColBack[1];
  faces[4][3] = rightColBack[0];

  faces[3][1] = rightColBottom[0];
  faces[3][3] = rightColBottom[1];

  faces[5][1] = rightColFront[0];
  faces[5][3] = rightColFront[1];
}

}

class CubeScreen extends StatefulWidget {
  const CubeScreen({Key? key}) : super(key: key);

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  CubeState cube = CubeState();

  void rotateTop() {
    setState(() {
      cube.rotateTop();
    });
  }

    void rotateBottom() {
    setState(() {
      cube.rotateBottom();
    });
  }
  
    void rotateLeft() {
    setState(() {
      cube.rotateLeft();
    });
  }

    void rotateRight() {
    setState(() {
      cube.rotateRight();
    });
  }


  Widget buildFace(String label, List<Color> faceColors) {
    return Column(
      children: [
        Text(label),
        SizedBox(
          height: 100,
          width: 100,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) => Container(color: faceColors[index]),
          ),
        ),
      ],
    );
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2x2 Rubik\'s Cube'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildFace("Top", cube.faces[4]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildFace("Left", cube.faces[1]),
              buildFace("Front", cube.faces[0]),
              buildFace("Right", cube.faces[2]),
            ],
          ),
          buildFace("Bottom", cube.faces[5]),
          buildFace("Back", cube.faces[3]),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: rotateTop,
                child: const Text("Rotate Top"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: rotateBottom,
                child: const Text("Rotate Bottom"),
              ),
              ElevatedButton(
                onPressed: rotateLeft,
                child: const Text("Rotate Left"),
              ),
                ElevatedButton(
                onPressed: rotateRight,
                child: const Text("Rotate Right"),
              ),


            ],
          ),
        ],
      ),
    );
  }
}