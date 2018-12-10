import 'dart:io';
import 'dart:convert';

dayFour() async {
  await partOne();
}

partOne() async {
  Directory current = Directory.current;
  var config = File('${current.path}/lib/dayfour/dayfour.txt');
  Stream<List<int>> inputStream = config.openRead();
  List<Entry> entries = new List();
  List<Guard> guards = new List();
  var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
  try {
    await for (var line in lines) {
      entries.add(new Entry(line));
    }
    entries.sort();
    String guardID = entries[0].guardId();
    for (var entry in entries) {
      if (entry.guardId() != null) {
        guardID = entry.guardId();
      }
      Guard guard =
          guards.firstWhere((guard) => guard.id == guardID, orElse: () => null);
      if (guard == null) {
        guard = new Guard(guardID);
        guards.add(guard);
      }
      guard.addEntry(entry);
    }
    guards.sort();
    for (Guard guard in guards) {
      print(guard);
    }
  } catch (e) {
    print(e);
  }
}

class Entry extends Comparable {
  DateTime dateTime;
  String event;
  Entry(String entryString) {
    dateTime = DateTime.parse(entryString.split(']')[0].replaceAll('[', ''));
    event = entryString.split(']')[1];
  }
  String guardId() {
    if (event.contains('#')) {
      return event.split('#')[1].split(' ')[0];
    }
    return null;
  }

  @override
  String toString() {
    return '$event, ${this.dateTime.toString()}';
  }

  @override
  int compareTo(other) {
    if (this.dateTime.isBefore(other.dateTime)) {
      return -1;
    }
    return 1;
  }
}

class Guard extends Comparable {
  final String id;
  List<Entry> entries;
  int sleepingTime;
  List<List<int>> minutesAsleep;

  Guard(this.id) {
    this.entries = new List();
    this.minutesAsleep = new List();
  }
  @override
  String toString() {
    return 'Guard #${this.id}, asleep at minute ${this._getMostMinutes()[0]}, ${this._getMostMinutes()[1]} times';
  }

  int getSleepingTime() {
    int result = 0;
    this.minutesAsleep = new List();

    DateTime lastAsleep = null;
    for (var entry in this.entries) {
      if (entry.event.indexOf('falls asleep') > -1) {
        lastAsleep = entry.dateTime;
      } else if (entry.event.indexOf('wakes up') > -1 && lastAsleep != null) {
        int duration = entry.dateTime.difference(lastAsleep).inMinutes;
        result += duration;
        this.minutesAsleep.add(_getMinutes(lastAsleep, duration));
      }
    }
    this.sleepingTime = result;
    return result;
  }

  _combineMinutes() {
    if (this.minutesAsleep.length > 0) {
      List<List<int>> tmp = List.from(this.minutesAsleep);
      return tmp.reduce((curr, next) {
        for (int i = 0; i < curr.length; i++) {
          curr[i] += next[i];
        }
        return curr;
      });
    }
    return new List.filled(60, 0);
  }

  _getMostMinutes() {
    int max = 0;
    int maxIndex = 0;

    List<int> mins = _combineMinutes();
    for (int i = 0; i < mins.length; i++) {
      if (mins[i] > max) {
        max = mins[i];
        maxIndex = i;
      }
    }

    return [maxIndex, max];
  }

  _getMinutes(DateTime start, int duration) {
    List<int> minutes = new List.filled(60, 0);
    for (int i = start.minute; i < start.minute + duration; i++) {
      minutes[i] = 1;
    }
    return minutes;
  }

  addEntry(Entry entry) {
    this.entries.add(entry);
  }

  getMostSleptMinute() {}

  @override
  int compareTo(other) {
    return other.getSleepingTime() - this.getSleepingTime();
  }
}
