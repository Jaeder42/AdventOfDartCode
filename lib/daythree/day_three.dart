import 'dart:io';
import 'dart:convert';

dayThree() async {
  await partOne();
}

class Square {
  final int x;
  final int y;
  final int length;
  final int height;

 int yMax;

  Square(this.x, this.y, this.length, this.height){
    this.yMax = this.y + this.height;
  }

  toString() {
    return '${this.x}, ${this.y}, ${this.length}, ${this.height}';
  }
}

partOne() async {
  List<int> row = new List();
  List<List<int>> rows = new List();

  for (int i = 0; i < 1000; i++) {
    rows.add(row);
  }

  Directory current = Directory.current;
  var config = File('${current.path}/lib/daythree/daythree.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
  try {
    await for (var line in lines) {
      parseLine(line);
    }
  } catch (e) {
    print(e);
  }
}

addToRows(List<List<int>> rows, Square square){
  for(int i = square.y; i< )
}

parseLine(line) {
  List<String> posSize = line.split('@')[1].split(':');
  List<String> size = posSize[1].split('x');
  List<String> pos = posSize[0].split(',');
  Square square = new Square(int.parse(pos[0]), int.parse(pos[1]),
      int.parse(size[0]), int.parse(size[1]));
  print(square);
}
