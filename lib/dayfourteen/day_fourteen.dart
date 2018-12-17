import 'dart:collection';

dayFourteen() {
  try {
    String input = '607331';

    LinkedList recipes = new LinkedList<Element>();
    Element first = new Element<int>(3);
    recipes.add(first);
    Element second = new Element(7);
    first.insertAfter(second);
    for (int i = 0; i < 50000000; i++) {
      int newValue = first.value + second.value;
      List<String> array = newValue.toString().split('');
      for (String value in array) {
        recipes.last.insertAfter(new Element(int.parse(value)));
      }
      Element newFirst = first;
      for (int i = 0; i <= first.value; i++) {
        newFirst = newFirst.next;
      }
      first = newFirst;
      Element newSecond = second;
      for (int i = 0; i <= second.value; i++) {
        newSecond = newSecond.next;
      }
      second = newSecond;
    }
    print('NUmber of recipes before: ${recipes.join().indexOf(input)}');
  } catch (err) {
    print(err);
  }
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
