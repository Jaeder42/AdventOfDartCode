dayNine() {
  partOne();
}

partOne() {
  // int numberOfPlayers = 446;
  // int lastMarbleScore = 71522;
  int numberOfPlayers = 9;
  int lastMarbleScore = 25;

  List<int> marbles = new List();
  marbles.add(0);
  marbles.add(1);
  marbles.add(2);
  marbles.insert(1, 3);
  print(marbles);
}
