# Assignment 3

Name: Hazmi Bin Badrunsham
Matric No: 2216595

//I did modify the logic for 2x2 rubic cube rotation as such adding:

1.  // Rotate top face //
    // Rotate the top face (faces[4]) clockwise:
    // The bottom-left becomes the top-left, top-left becomes the top-right,
    // bottom-right becomes bottom-left, and top-right becomes bottom-right.
    List<Color> tempTop = [...faces[4]];
    faces[4] = [tempTop[2], tempTop[0], tempTop[3], tempTop[1]];

2. Modifying the layout using grid and Gridview.builder for cleaner layout.
