import 'dart:io';
import 'dart:convert';

daySix() async {
  await partone();
  await partwo();
}

partone() async {
  List<List<int>> rows = new List(400);
  for (int i = 0; i < rows.length; i++) {
    rows[i] = new List.filled(400, 0);
  }

  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/daysix/daysix.txt');
    Stream<List<int>> inputStream = config.openRead();

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      List<Coordinate> coordinates = new List();
      int id = 1;
      await for (var line in lines) {
        coordinates.add(new Coordinate(line, id));
        id++;
      }
      populateArray(rows, coordinates);
      getLargestArea(coordinates, rows);
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

partwo() async {
  List<List<int>> rows = new List(1000);
  for (int i = 0; i < rows.length; i++) {
    rows[i] = new List.filled(1000, 0);
  }

  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/daysix/daysix.txt');
    Stream<List<int>> inputStream = config.openRead();

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      List<Coordinate> coordinates = new List();
      int id = 1;
      await for (var line in lines) {
        coordinates.add(new Coordinate(line, id));
        id++;
      }
      populatePart2(rows, coordinates);
      getArea(rows);
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

getArea(List<List<int>> rows) {
  int sum = 0;
  for (List<int> row in rows) {
    sum += row.reduce((value, element) => value + element);
  }
  print(sum);
}

populatePart2(List<List<int>> rows, List<Coordinate> coordinates) {
  for (int i = 0; i < rows.length; i++) {
    for (int j = 0; j < rows.length; j++) {
      if (isValidPos(i, j, coordinates)) {
        rows[i][j] = 1;
      }
    }
  }
}

isValidPos(int x, int y, List<Coordinate> coordinates) {
  int sum = 0;
  for (Coordinate coordinate in coordinates) {
    int dX = (coordinate.x - x).abs();
    int dY = (coordinate.y - y).abs();
    sum += dX + dY;
  }
  if (sum < 10000) {
    return true;
  }
  return false;
}

getLargestArea(List<Coordinate> coordinates, List<List<int>> rows) {
  int largestArea = 0;
  int id = 0;
  List<int> invalids = getInvalid(rows);
  for (Coordinate coordinate in coordinates) {
    if (invalids.indexOf(coordinate.id) < 0) {
      int area = calcArea(rows, coordinate.id);
      if (area > largestArea) {
        largestArea = area;
        id = coordinate.id;
      }
    }
  }
  print('ID: #$id has the largest area: $largestArea');
}

calcArea(List<List<int>> rows, int idToFind) {
  int result = 0;
  for (List<int> row in rows) {
    for (int id in row) {
      if (id == idToFind) {
        result++;
      }
    }
  }
  return result;
}

getInvalid(List<List<int>> rows) {
  List<int> invalids = new List();
  for (int id in rows[0]) {
    invalids.add(id);
  }
  for (int id in rows[rows.length - 1]) {
    invalids.add(id);
  }
  for (var row in rows) {
    invalids.add(row[0]);
    invalids.add(row[row.length - 1]);
  }
  List<int> distincts = invalids.toSet().toList();
  return distincts;
}

populateArray(List<List<int>> rows, List<Coordinate> coordinates) {
  for (Coordinate coordinate in coordinates) {
    rows[coordinate.x][coordinate.y] = coordinate.id;
  }
  for (int i = 0; i < rows.length; i++) {
    for (int j = 0; j < rows.length; j++) {
      rows[i][j] = calculateNearest(i, j, coordinates);
    }
  }
}

calculateNearest(int x, int y, List<Coordinate> coordinates) {
  int closest = 0;
  int minDist = 500;
  for (Coordinate coordinate in coordinates) {
    int dX = (coordinate.x - x).abs();
    int dY = (coordinate.y - y).abs();
    int distance = dX + dY;
    if (distance < minDist) {
      closest = coordinate.id;
      minDist = distance;
    } else if (distance == minDist) {
      closest = 0;
      minDist = distance;
    }
  }
  return closest;
}

class Coordinate {
  int x;
  int y;
  final int id;
  Coordinate(String input, this.id) {
    List<String> split = input.split(',');
    x = int.parse(split[0]);
    y = int.parse(split[1]);
  }
  @override
  String toString() {
    return '$id: ($x, $y)';
  }
}
