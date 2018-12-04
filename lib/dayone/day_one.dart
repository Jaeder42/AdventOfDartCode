import 'dart:io';
import 'dart:convert';

dayOne() async {
  await partone();
  await parttwo();
}

partone() async {
  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/dayone/dayone.txt');
    Stream<List<int>> inputStream = config.openRead();

    int result = 0;

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var line in lines) {
        result += int.parse(line);
      }
      print('Result $result');
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

parttwo() async {
  print('Calculating, be patient');
  bool done = false;
  int result = 0;
  List<int> reachedResults = new List();
  reachedResults.add(result);
  while (!done) {
    try {
      Directory current = Directory.current;
      var config = File('${current.path}/lib/dayone/dayone.txt');
      Stream<List<int>> inputStream = config.openRead();
      var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
      try {
        await for (var line in lines) {
          result += int.parse(line);
          if (reachedResults.contains(result)) {
            print('First to be reached twice $result');
            done = true;
            break;
          }
          reachedResults.add(result);
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }
}
