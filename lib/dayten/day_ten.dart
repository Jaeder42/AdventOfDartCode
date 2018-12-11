import 'dart:io';
import 'dart:convert';
import 'dart:math';

dayTen() async {
  await partOne();
}

partOne() async {
  Directory current = Directory.current;
  var config = File('${current.path}/lib/dayten/dayten.txt');
  Stream<List<int>> inputStream = config.openRead();
  List<Point> points = new List();
  var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
  try {
    await for (var line in lines) {
      points.add(initPoint(line));
    }
    print('Points added: ${points.length}');
    for (int i = 0; i < 1000000; i++) {
      for (var point in points) {
        point.passTime(1);
      }

      await toFilePoints(points, i);
    }
  } catch (e) {
    print(e);
  }
}

initPoint(String line) {
  String formatted = line
      .replaceFirst('position=<', '')
      .replaceFirst('> velocity=<', '|')
      .replaceFirst('>', '');
  List<String> formattedList = formatted.split('|');
  String positionString = formattedList[0];
  String speedString = formattedList[1];
  int x = int.parse(positionString.split(',')[0]);
  int y = int.parse(positionString.split(',')[1]);
  int dX = int.parse(speedString.split(',')[0]);
  int dY = int.parse(speedString.split(',')[1]);

  Point point = new Point(x, y, dX, dY);
  return point;
}

findMax(points) {
  int currMax = 0;
  for (Point point in points) {
    if (max(point.x.abs(), point.y.abs()) > currMax) {
      currMax = max(point.x, point.y);
    }
  }
  return currMax;
}

toFilePoints(List<Point> points, index) async {
  int length = 400;
  if (findMax(points) >= length ~/ 2) {
    return Future;
  } else {
    var file = new File('lib/dayten/output/out${index}.txt');
    var sink = file.openWrite();
    for (int i = 0; i < length; i++) {
      for (int j = 0; j < length; j++) {
        int rowLength = length ~/ 4;
        String toPrint = '.';
        if (points.firstWhere(
                (point) => point.x + rowLength == j && point.y + rowLength == i,
                orElse: () => null) !=
            null) {
          toPrint = '0';
        }
        sink.write(toPrint);
      }
      sink.writeln();
    }
    await sink.flush();
    sink.close();
  }
}

class Point {
  int x;
  int y;
  final int dX;
  final int dY;
  Point(this.x, this.y, this.dX, this.dY);

  passTime(int seconds) {
    for (int i = 0; i < seconds; i++) {
      x += dX;
      y += dY;
    }
  }

  @override
  String toString() {
    return 'x: $x, y:$y, dx: $dX, dy: $dY';
  }
}
