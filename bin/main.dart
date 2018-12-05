import 'dart:io';
import '../lib/dayone/day_one.dart';
import '../lib/daytwo/day_two.dart';
import '../lib/daythree/day_three.dart';
import '../lib/dayfour/day_four.dart';
import '../lib/dayfive/day_five.dart';

Future main(List<String> arguments) async {
  stdout.writeln('Choose day');
  while (true) {
    String input = stdin.readLineSync();
    int day = int.parse(input);
    if (day > 0 && day < 26) {
      switch (day) {
        case 1:
          await dayOne();
          print('Day 1 complete!');
          break;
        case 2:
          await dayTwo();
          print('Day 2 complete');
          break;
        case 3:
          await dayThree();
          print('Day 3 complete');
          break;
        case 4:
          await dayFour();
          print('Day 4 complete');
          break;
        case 5:
          await dayFive();
          print('Day 5 complete');
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
