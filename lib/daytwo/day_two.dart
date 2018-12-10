import 'dart:io';
import 'dart:convert';

dayTwo() async {
  await partOne();
  await partTwo();
}

partOne() async {
  int twos = 0;
  int threes = 0;
  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/daytwo/daytwo.txt');
    Stream<List<int>> inputStream = config.openRead();

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var line in lines) {
        if (countDuplicates(line, 2)) {
          ++twos;
        }
        if (countDuplicates(line, 3)) {
          ++threes;
        }
      }
      print('checksum: $twos * $threes = ${twos * threes}');
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

partTwo() async {
  List<String> gottenLines = new List();
  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/daytwo/daytwo.txt');
    Stream<List<int>> inputStream = config.openRead();

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var line in lines) {
        gottenLines.add(line);
      }
      for (int i = 0; i < gottenLines.length; i++) {
        for (int j = i; j < gottenLines.length; j++) {
          var result = compareStrings(gottenLines[i], gottenLines[j]);
          if (result != null) {
            print('Box id: $result');
          }
        }
      }
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

compareStrings(String input1, String input2) {
  List<String> input1Arr = input1.split('');
  List<String> input2Arr = input2.split('');
  int faults = 0;
  int faultIndex = -1;
  for (int i = 0; i < input1Arr.length; i++) {
    if (faults > 1) {
      break;
    }
    if (input1Arr[i] != input2Arr[i]) {
      faultIndex = i;
      ++faults;
    }
  }

  if (faults == 1) {
    List<String> result = new List<String>.from(input1Arr);
    result.removeAt(faultIndex);
    return result.join('');
  }
  return null;
}

countDuplicates(String input, int limit) {
  List<String> inputArray = input.split('');
  for (int i = 0; i < inputArray.length; i++) {
    List<String> tmp = input.split(inputArray[i]);
    if (tmp.length == (limit + 1)) {
      return true;
    }
  }
  return false;
}
