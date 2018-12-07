import 'dart:io';
import 'dart:convert';

daySeven() async {
  await partone();
}

partone() async {
  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/dayseven/dayseven.txt');
    Stream<List<int>> inputStream = config.openRead();
    List<Step> steps = new List();
    int c = "a".codeUnitAt(0);
    int end = "z".codeUnitAt(0);
    while (c <= end) {
      steps.add(new Step(new String.fromCharCode(c).toUpperCase()));
      c++;
    }
    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var line in lines) {
        String id = line.split('')[36];
        Step existing =
            steps.firstWhere((step) => step.id == id, orElse: () => null);
        if (steps.length > 0 && existing != null) {
          existing.addPrerequesite(line);
        }
      }
      steps.sort();
      run(new List<String>(), steps);
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

run(List<String> completed, List<Step> steps) {
  if (steps.length < 1) {
    print(completed.join(''));
    return null;
  }
  Step toAdd =
      steps.firstWhere((step) => step.prerequesites.length == 0, orElse: null);
  if (toAdd == null) {
    print(completed.join(''));
    return null;
  } else {
    completed.add(toAdd.id);
    steps.remove(toAdd);
    removeCompleted(toAdd.id, steps);
    return run(completed, steps);
  }
}

removeCompleted(String completed, List<Step> steps) {
  for (Step step in steps) {
    step.prerequesites.remove(completed);
  }
}

class Step extends Comparable {
  final String id;
  List<String> prerequesites;
  Step(this.id) {
    prerequesites = new List();
  }

  addPrerequesite(String input) {
    List<String> asArray = input.split('');
    prerequesites.add(asArray[5]);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$id : $prerequesites';
  }

  @override
  int compareTo(other) {
    // TODO: implement compareTo
    return this.id.compareTo(other.id);
  }
}
