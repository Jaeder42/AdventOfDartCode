import 'dart:async';
import 'dart:collection';

dayNine() async {
  await solve(100);
}

Future solve(int multiplier) {
  var completer = new Completer();

  try {
    int numberOfPlayers = 446;
    int lastMarbleScore = 71522 * multiplier;
    // int lastMarbleScore = 1104;
    // int numberOfPlayers = 17;

    var marbles = new LinkedList<Element>();
    List<int> players = new List.filled(numberOfPlayers, 0);
    int currentPlayer = 0;
    Element test = new Element(0);
    marbles.add(test);
    var current = test;
    for (int i = 1; i <= lastMarbleScore; i++) {
      if (i % 23 != 0) {
        current = addToCircle(current.next, i);
      } else {
        players[currentPlayer] += i;
        current = current.previous.previous.previous.previous.previous.previous;
        players[currentPlayer] += current.previous.value;
        marbles.remove(current.previous);
      }
      if (currentPlayer + 2 > players.length) {
        currentPlayer = 0;
      } else {
        currentPlayer += 1;
      }
    }
    players.sort();
    print('result: ${players.last}');
    completer.complete();
    return completer.future;
  } catch (err) {
    print(err);
    return completer.future;
  }
}

addToCircle(LinkedListEntry current, turn) {
  current.insertAfter(new Element(turn));
  return current.next;
}

class Element<E> extends LinkedListEntry<Element> {
  final E value;
  Element(this.value);
  @override
  Element get previous {
    if (super.previous == null) {
      return list.last;
    }
    return super.previous;
  }

  @override
  Element get next {
    if (super.next == null) {
      return list.first;
    }
    return super.next;
  }

  @override
  String toString() {
    return '$value';
  }
}
