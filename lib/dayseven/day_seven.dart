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

    var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
    try {
      await for (var line in lines) {
        Step tmp = new Step(line);
        Step existing =
            steps.firstWhere((step) => step.id == tmp.id, orElse: () => null);
        if (steps.length > 0 && existing != null) {
          existing.addPrerequesite(line);
        } else {
          steps.add(tmp);
        }
      }
      print(steps);
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}

class Step {
  String id;
  List<String> prerequesites;
  Step(String input) {
    List<String> asArray = input.split('');
    this.id = asArray[5];
    prerequesites = new List();
    prerequesites.add(asArray[36]);
  }

  addPrerequesite(String input) {
    List<String> asArray = input.split('');
    prerequesites.add(asArray[36]);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$id : $prerequesites';
  }
}
