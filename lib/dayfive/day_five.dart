import 'dart:io';
import 'dart:convert';

dayFive() async {
  await partone();
  await partTwo();
}

partone() async {
  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/dayfive/dayfive.txt');
    Stream<List<int>> inputStream = config.openRead();

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var line in lines) {
        String result = replaceAll(line);

        print('Length of reacted polymer ${result.length}');
      }
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

partTwo() async {
  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/dayfive/dayfive.txt');
    Stream<List<int>> inputStream = config.openRead();

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var line in lines) {
        findOptimal(line);
      }
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

findOptimal(String line) {
  int currMin = line.length;
  String unitToRemove = 'a';
  for (String unit in units) {
    String removed =
        line.replaceAll(unit, '').replaceAll(unit.toUpperCase(), '');
    String result = replaceAll(removed);
    if (result.length < currMin) {
      currMin = result.length;
      unitToRemove = unit;
    }
  }
  print(
      'Removing $unitToRemove/${unitToRemove.toUpperCase()} results in length: $currMin');
}

replaceAll(String line) {
  int initial = line.length;
  int formatted = 0;
  while (initial != formatted) {
    initial = line.length;
    for (var pattern in removes) {
      line = line.replaceFirst(pattern, '');
    }
    formatted = line.length;
  }
  return line;
}

List<String> units = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

List<String> removes = [
  'Aa',
  'aA',
  'Bb',
  'bB',
  'Cc',
  'cC',
  'Dd',
  'dD',
  'Ee',
  'eE',
  'Ff',
  'fF',
  'Gg',
  'gG',
  'Hh',
  'hH',
  'Ii',
  'iI',
  'Jj',
  'jJ',
  'Kk',
  'kK',
  'Ll',
  'lL',
  'Mm',
  'mM',
  'Nn',
  'nN',
  'Oo',
  'oO',
  'Pp',
  'pP',
  'Qq',
  'qQ',
  'Rr',
  'rR',
  'Ss',
  'sS',
  'Tt',
  'tT',
  'Uu',
  'uU',
  'Vv',
  'vV',
  'Ww',
  'wW',
  'Xx',
  'xX',
  'Yy',
  'yY',
  'Zz',
  'zZ'
];
