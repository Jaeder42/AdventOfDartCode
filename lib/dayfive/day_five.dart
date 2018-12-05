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
        replaceAll(line);
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
        replaceAll(line);
      }
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
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
  print(line);
  print(line.length);
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
