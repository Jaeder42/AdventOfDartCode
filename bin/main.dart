import 'dart:io';
import '../lib/day-one.dart';

Future main(List<String> arguments) async {
  stdout.writeln('Choose day');
  while (true) {
    String input = stdin.readLineSync();
    int day = int.parse(input);
    if (day > 0 && day < 26) {
      switch (day) {
        case 1:
          await dayone();
          print('Day 1 complete!');
          break;
        default:
          print('Day ${day} not yet implemented');
          print('Please pick another!');
      }
    } else {
      print('Between 1 and 25...');
    }
  }
}
