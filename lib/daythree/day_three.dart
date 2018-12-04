import 'dart:io';
import 'dart:convert';

dayThree() async {
  await partOne();
}

class Square {
  final String id;
  final int x;
  final int y;
  final int length;
  final int height;
  int yMax;
  int xMax;

  Square(this.id, this.x, this.y, this.length, this.height) {
    this.yMax = this.y + this.height;
    this.xMax = this.x + this.length;
  }

  toString() {
    return '${this.x}, ${this.y}, ${this.length}, ${this.height}';
  }
}

partOne() async {
  List<List<int>> rows = new List(1000);
  List<Square> squares = new List();
  for (int i = 0; i < rows.length; i++) {
    rows[i] = new List<int>.filled(rows.length, 0);
  }

  Directory current = Directory.current;
  var config = File('${current.path}/lib/daythree/daythree.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
  try {
    await for (var line in lines) {
      squares.add(parseLine(line, rows));
    }
    int result = 0;
    for (List<int> row in rows) {
      for (int i in row) {
        if (i > 1) {
          result += 1;
        }
      }
    }
    print('Square inches: $result');
    partTwo(rows, squares);
  } catch (e) {
    print(e);
  }
}

partTwo(rows, squares) {
  for (Square square in squares) {
    if (findOverlaps(rows, square)) {
      print('Square ${square.id} does not overlap');
    }
  }
}

addToRows(List<List<int>> rows, Square square) {
  for (int i = square.y; i < square.yMax; i++) {
    for (int j = square.x; j < square.xMax; j++) {
      rows[i][j] += 1;
    }
  }
}

findOverlaps(rows, square) {
  for (int i = square.y; i < square.yMax; i++) {
    for (int j = square.x; j < square.xMax; j++) {
      if (rows[i][j] > 1) {
        return false;
      }
    }
  }
  return true;
}

parseLine(line, rows) {
  String id = line.split('@')[0];
  List<String> posSize = line.split('@')[1].split(':');
  List<String> size = posSize[1].split('x');
  List<String> pos = posSize[0].split(',');
  Square square = new Square(id, int.parse(pos[0]), int.parse(pos[1]),
      int.parse(size[0]), int.parse(size[1]));
  addToRows(rows, square);
  return square;
}
