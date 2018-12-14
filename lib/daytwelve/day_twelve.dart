import 'dart:io';
import 'dart:convert';

dayTwelve() async {
  await partOne();
}

final int length = 3000;
partOne() async {
  Directory current = Directory.current;
  var config = File('${current.path}/lib/daytwelve/daytwelve.txt');
  Stream<List<int>> inputStream = config.openRead();
  List<String> pots = new List.filled(length, '.');
  List<Rule> rules = new List();
  List<List<String>> generations = new List();
  var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
  try {
    await for (var line in lines) {
      if (line.indexOf('initial state:') > -1) {
        List<String> initial = line.replaceAll('initial state: ', '').split('');
        for (int i = 0; i < initial.length; i++) {
          pots[i + 10] = initial[i];
        }
      } else if (line.length > 0) {
        List<String> ruleInput = line.split(' => ');
        rules.add(new Rule(ruleInput[0], ruleInput[1]));
      }
    }
    generations.add(pots);
    for (int i = 1; i < 2001; i++) {
      addGeneration(generations, rules, i);
    }

    int result = 0;
    for (int i = 0; i < length; i++) {
      int potNr = i - (10);
      if (generations.last[i] == '#') {
        result += potNr;
      }
    }
    print('Result: $result');
    double sum = (50000000000.0 - 2000.0) * 58 + result;
    print('Sum: $sum');
  } catch (e) {
    print(e);
  }
}

addGeneration(
    List<List<String>> generations, List<Rule> rules, int generation) {
  List<String> nextGeneration = new List.filled(length, '.');
  List<String> currentGeneration = generations[generation - 1];
  for (int i = 2; i < length - 5; i++) {
    List<String> prevPots = new List();
    prevPots.add(currentGeneration[i - 2]);
    prevPots.add(currentGeneration[i - 1]);
    prevPots.add(currentGeneration[i - 0]);
    prevPots.add(currentGeneration[i + 1]);
    prevPots.add(currentGeneration[i + 2]);
    Rule rule = rules.firstWhere((rule) => rule.ruleString == prevPots.join(),
        orElse: () => null);
    if (rule == null) {
      nextGeneration[i] = '.';
    } else {
      nextGeneration[i] = rule.result;
    }
  }
  generations.add(nextGeneration);

  // print('$generation: ${nextGeneration.join()}');
  int result = 0;
  for (int i = 0; i < length; i++) {
    int potNr = i - (10);
    if (nextGeneration[i] == '#') {
      result += potNr;
    }
  }
  print('generation: $generation result:$result');
}

class Rule {
  final String ruleString;
  final String result;
  Rule(this.ruleString, this.result);
  toString() {
    return '$ruleString => $result';
  }
}
