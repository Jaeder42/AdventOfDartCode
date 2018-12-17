import 'dart:io';
import '../lib/dayone/day_one.dart';
import '../lib/daytwo/day_two.dart';
import '../lib/daythree/day_three.dart';
import '../lib/dayfour/day_four.dart';
import '../lib/dayfive/day_five.dart';
import '../lib/daysix/day_six.dart';
import '../lib/dayseven/day_seven.dart';
import '../lib/dayeight/day_eight.dart';
import '../lib/daynine/day_nine.dart';
import '../lib/dayten/day_ten.dart';
import '../lib/dayeleven/day_eleven.dart';
import '../lib/daytwelve/day_twelve.dart';
import '../lib/daythirteen/day_thirteen.dart';
import '../lib/dayfourteen/day_fourteen.dart';

Future main(List<String> arguments) async {
  stdout.writeln('Choose day');
  while (true) {
    String input = stdin.readLineSync();
    try {
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
          case 6:
            await daySix();
            print('Day 6 complete');
            break;
          case 7:
            await daySeven();
            print('Day 7 complete');
            break;
          case 8:
            await dayEight();
            print('Day 8 complete');
            break;
          case 9:
            dayNine();
            print('Day 9 complete');
            break;
          case 10:
            await dayTen();
            print('Day 10 complete');
            break;
          case 11:
            dayEleven();
            print('Day 11 complete');
            break;
          case 12:
            await dayTwelve();
            print('Day 12 complete');
            break;
          case 13:
            await dayThirteen();
            print('Day 13 complete');
            break;
          case 14:
            dayFourteen();
            print('Day 14 complete');
            break;
          default:
            print('Day ${day} not yet implemented');
            print('Please pick another!');
        }
      } else {
        print('Between 1 and 25...');
      }
    } catch (err) {
      print('... a number ...');
    }
  }
}
