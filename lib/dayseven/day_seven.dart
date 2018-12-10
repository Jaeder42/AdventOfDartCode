import 'dart:io';
import 'dart:convert';
import 'dart:math';

daySeven() async {
  await partOne();
  await partTwo();
}

partOne() async {
  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/dayseven/dayseven.txt');
    Stream<List<int>> inputStream = config.openRead();
    List<Step> steps = new List();
    int c = "a".codeUnitAt(0);
    int end = "z".codeUnitAt(0);
    while (c <= end) {
      steps.add(new Step(new String.fromCharCode(c).toUpperCase(), 0));
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

partTwo() async {
  try {
    Directory current = Directory.current;
    var config = File('${current.path}/lib/dayseven/dayseven.txt');
    Stream<List<int>> inputStream = config.openRead();
    List<Step> steps = new List();
    int c = "a".codeUnitAt(0);
    int end = "z".codeUnitAt(0);
    while (c <= end) {
      steps.add(new Step(new String.fromCharCode(c).toUpperCase(), c - 36));
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
      List<WorkerElf> elves = new List();
      for (int i = 0; i < 5; i++) {
        elves.add(new WorkerElf());
      }
      runpartTwo(new List<String>(), steps, elves, 0);
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

runpartTwo(
    List<String> completed, List<Step> steps, List<WorkerElf> elves, int time) {
  if (steps.length < 1) {
    print('Completed in $time seconds');
    return null;
  }
  List<Step> toDos = steps
      .where((step) => step.prerequesites.length < 1 && !step.assigned)
      .toList();
  List<WorkerElf> available = elves.where((elf) => elf.step == null).toList();
  for (int i = 0; i < min(available.length, toDos.length); i++) {
    available[i].assign(toDos[i]);
    toDos[i].assign();
  }
  for (WorkerElf elf in elves) {
    elf.doWork();
    if (elf.isDone()) {
      Step tmp = elf.step;
      completed.add(tmp.id);
      removeCompleted(tmp.id, steps);
      steps.remove(tmp);
      elf.unAssign();
    }
  }
  return runpartTwo(completed, steps, elves, time += 1);
}

class WorkerElf {
  Step step = null;
  WorkerElf();

  toString() {
    if (this.step != null) {
      return 'Elf assigned ${this.step.timeToComplete}';
    }
    return 'Elf unassigned';
  }

  assign(Step step) {
    this.step = step;
  }

  doWork() {
    if (this.step != null) {
      step.timeToComplete -= 1;
    }
  }

  isDone() {
    if (this.step != null) {
      return step.timeToComplete < 1;
    } else
      return false;
  }

  unAssign() {
    this.step = null;
  }
}

class Step extends Comparable {
  final String id;
  List<String> prerequesites;
  bool assigned;
  int timeToComplete;
  Step(this.id, this.timeToComplete) {
    prerequesites = new List();
    assigned = false;
  }
  assign() {
    assigned = true;
  }

  addPrerequesite(String input) {
    List<String> asArray = input.split('');
    prerequesites.add(asArray[5]);
  }

  @override
  String toString() {
    return '$id : $prerequesites, assigned: $assigned';
  }

  @override
  int compareTo(other) {
    return this.id.compareTo(other.id);
  }
}
