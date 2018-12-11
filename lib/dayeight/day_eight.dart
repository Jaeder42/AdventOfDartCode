import 'dart:io';
import 'dart:convert';

dayEight() async {
  // await partOne();
  await partOne();
}

int index = 0;
int total = 0;
List<List<int>> childrenToGo = List();
List<List<int>> children = List();

partOne() async {
  Directory current = Directory.current;
  var config = File('${current.path}/lib/dayeight/dayeight.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
  try {
    await for (var line in lines) {
      print(line.split(' ').length);
      parse(line.split(' '));
    }
  } catch (e) {
    print(e);
  }
}

parse(List<String> input) {
  // print(children);
  if (childrenToGo.length > 0) {
    if (childrenToGo[childrenToGo.length - 1][0] > 0) {
      int numberOfChildren = int.parse(input[index]);
      int numberOfEntries = int.parse(input[index + 1]);
      if (numberOfChildren == 0) {
        int result = 0;
        int currIndex = index + 2;
        for (int i = 0; i < numberOfEntries; i++) {
          result += int.parse(input[currIndex + i]);
        }
        index += 2 + numberOfEntries;
        childrenToGo[childrenToGo.length - 1][0] -= 1;
        children[children.length - 1].add(result);
        parse(input);
      } else {
        childrenToGo.add([numberOfChildren, numberOfEntries]);
        children.add(new List());
        index += 2;
        parse(input);
      }
    } else {
      int result = 0;
      for (int i = 0; i < childrenToGo[childrenToGo.length - 1][1]; i++) {
        if (children[children.length - 1].length >=
                int.parse(input[index + i]) &&
            int.parse(input[index + i]) > -1) {
          result +=
              children[children.length - 1][int.parse(input[index + i]) - 1];
        }
      }

      children.removeLast();
      if (children.length > 0) {
        children[children.length - 1].add(result);
      }

      if (input.length > index + childrenToGo[childrenToGo.length - 1][1] + 1) {
        index += childrenToGo[childrenToGo.length - 1][1];
        childrenToGo.removeLast();
        childrenToGo[childrenToGo.length - 1][0] -= 1;

        parse(input);
      } else {
        total += result;
        print('Result: $total');
      }
    }
  } else {
    print('test');
    int numberOfChildren = int.parse(input[index]);
    int numberOfEntries = int.parse(input[index + 1]);
    childrenToGo.add([numberOfChildren, numberOfEntries]);
    children.add(new List());
    index += 2;
    parse(input);
  }
}
