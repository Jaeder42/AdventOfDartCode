import 'dart:io';
import 'dart:convert';

dayEight() async {
  // await partOne();
  await partOne();
}

int index = 0;
int result = 0;
List<List<int>> childrenToGo = List();

partOne() async {
  Directory current = Directory.current;
  var config = File('${current.path}/lib/dayeight/dayeight.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
  try {
    await for (var line in lines) {
      parse(line.split(' '));
    }
  } catch (e) {
    print(e);
  }
}

parse(List<String> input) {
  print('------------');
  print(index);
  print(childrenToGo);
  if (childrenToGo.length > 0) {
    if (childrenToGo[childrenToGo.length - 1][0] > 0) {
      int numberOfChildren = int.parse(input[index]);
      int numberOfEntries = int.parse(input[index + 1]);
      print(numberOfChildren);
      if (numberOfChildren == 0) {
        int currIndex = index + 2;
        for (int i = 0; i < numberOfEntries; i++) {
          result += int.parse(input[currIndex + i]);
        }
        index += 2 + numberOfEntries;
        childrenToGo[childrenToGo.length - 1][0] -= 1;
        parse(input);
      } else {
        print('adding, [$numberOfChildren, $numberOfEntries]');
        childrenToGo.add([numberOfChildren, numberOfEntries]);
        index += 2;
        parse(input);
      }
    } else {
      for (int i = 0; i < childrenToGo[childrenToGo.length - 1][1]; i++) {
        print(i);
        result += int.parse(input[index + i]);
      }
      if (input.length > index + childrenToGo[childrenToGo.length - 1][1] + 1) {
        index += childrenToGo[childrenToGo.length - 1][1];
        childrenToGo.removeAt(childrenToGo.length - 1);
        childrenToGo[childrenToGo.length - 1][0] -= 1;
        parse(input);
      } else {
        print('Result: $result');
      }
    }
  } else {
    int numberOfChildren = int.parse(input[index]);
    int numberOfEntries = int.parse(input[index + 1]);
    childrenToGo.add([numberOfChildren, numberOfEntries]);
    index += 2;
    parse(input);
  }
}
