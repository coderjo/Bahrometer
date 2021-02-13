This is the format used by the saveInputPatternToFile and loadInputPatterFromFile functions
on the ptPerceptron object. It is used to save and load the gestures being input into the
preceptron class. (Yes, the function is actually named "loadInputPatterFromFile".)

All multi-byte values are little endian.

Coordinates are in the range of 0.0 to 1.0. Origin is currently presumed to be top-left.

**FILE**

| Type    | Count | Decription |
| :------ | ----: | :--------- |
| uint16  |     1 | number of bytes in the description of this pattern (nLen) |
| char    | nLen  | A description of this pattern. No terminating null. |
| uint32  |     1 | The number of gestures in the file (nGest) |
| GESTURE | nGest | The gestures |


**GESTURE**

| Type    | Count | Decription |
| :------ | ----: | :--------- |
| float   |     1 | The minimum X value contained in this gesture |
| float   |     1 | The minimum Y value contained in this gesture |
| float   |     1 | The maximum X value contained in this gesture |
| float   |     1 | The maximum Y value contained in this gesture |
| uint32  |     1 | The number of points that make up this gesture (nPt) |
| POINT   | nPt   | The points that make up this gesture |

**POINT**

| Type    | Count | Decription |
| :------ | ----: | :--------- |
| float   | 1     | X coordinate |
| float   | 1     | Y coordinate |
