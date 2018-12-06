import 'dart:io';
import 'dart:convert';

daySix() async {
  await partone();
}

partone() async {
  List<List<int>> rows = new List(400);
  for (int i = 0; i < rows.length; i++) {
    rows[i] = new List.filled(400, 0);
  }



  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/dayone/dayone.txt');
    Stream<List<int>> inputStream = config.openRead();

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      List<String>
      await for (var line in lines) {}
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

class Coordinate{
  int x;
  int y;
  Coordinate(String input){
    List<String> split = input.split(',');
    x = int.parse(split[0]);
    y = int.parse(split[1]);
  }
}
