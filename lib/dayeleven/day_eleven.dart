dayEleven() {
  partOne();
}

partOne() {
  int serialNr = 7400;
  int length = 301;
  List<List<int>> rows = new List(length + 1);
  for (int i = 1; i < length + 1; i++) {
    rows[i] = new List.filled(length, 0);
  }

  for (int i = 1; i < length; i++) {
    for (int j = 1; j < length; j++) {
      int rackId = j + 10;
      int powerLevel = ((rackId * i) + serialNr) * rackId;
      String levelString = powerLevel.toString();
      int level = int.parse(levelString.split('').reversed.toList()[2]);
      rows[i][j] = level - 5;
    }
  }
  List<Square> squares = new List();
  List<List<Square>> last;

  try {
    for (int s = 1; s < length + 1; s++) {
      print('Size: $s');
      List<List<Square>> tmp = new List(length - s + 1);
      for (int i = 1; i < length - s; i++) {
        for (int j = 1; j < length - s; j++) {
          int result = 0;
          if (last == null) {
            for (int k = 0; k < s; k++) {
              for (int l = 0; l < s; l++) {
                result += rows[i + k][j + l];
              }
            }
            Square newSquare = new Square(j, i, s, result);
            squares.add(newSquare);
            if (tmp[i] == null) {
              tmp[i] = new List();
            }
            tmp[i].add(newSquare);
          } else {
            Square existing = last[i][j - 1];
            for (int k = i; k < i + s; k++) {
              result += rows[k][j + s - 1];
            }
            for (int k = j; k < j + s - 1; k++) {
              result += rows[i + s - 1][k];
            }
            Square newSquare = new Square(j, i, s, existing.value + result);
            squares.add(newSquare);
            if (tmp[i] == null) {
              tmp[i] = new List();
            }
            tmp[i].add(newSquare);
          }
        }
      }
      last = tmp;
    }
  } catch (err) {
    print(err);
  }
  try {
    squares.sort();
    print('${squares[0]} | ${squares[squares.length - 1]}');
  } catch (err) {
    print(err);
  }
}

class Square extends Comparable {
  final int x;
  final int y;
  final int size;
  int value = 0;
  Square(this.x, this.y, this.size, this.value);
  @override
  String toString() {
    return '[$x, $y, $size, $value]';
  }

  @override
  int compareTo(other) {
    return other.value - value;
  }
}
