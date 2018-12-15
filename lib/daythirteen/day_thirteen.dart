import 'dart:io';
import 'dart:convert';

dayThirteen() async {
  await partOne();
}

partOne() async {
  Directory current = Directory.current;
  var config = File('${current.path}/lib/daythirteen/daythirteen.txt');
  Stream<List<int>> inputStream = config.openRead();

  List<List<Space>> spaces = new List();
  List<Cart> carts = new List();
  var lines = inputStream.transform(utf8.decoder).transform(LineSplitter());
  try {
    int y = 0;
    await for (var line in lines) {
      List<Space> row = new List();
      List<String> lineArray = line.split('');
      int x = 0;
      for (String string in lineArray) {
        if (string == '<' || string == '>') {
          Cart cart = new Cart(string, x, y);
          carts.add(cart);
          Space space = new Space(x, y, '-', true);
          space.avatar = string;
          row.add(space);
        } else if (string == '^' || string == 'v') {
          Cart cart = new Cart(string, x, y);
          carts.add(cart);
          Space space = new Space(x, y, '|', true);
          space.avatar = string;
          row.add(space);
        } else {
          Space space = new Space(x, y, string, false);
          row.add(space);
        }
        x++;
      }
      spaces.add(row);
      y++;
    }
    bool run = true;
    int runs = 0;
    while (run) {
      if (carts.length < 2) {
        run = false;
        break;
      }
      runs++;
      List<Cart> toRemoves = new List();
      for (var cart in carts) {
        cart.advance(spaces);
        List<Cart> otherCarts = carts
            .where((other) => other.x == cart.x && other.y == cart.y)
            .toList();
        if (otherCarts.length > 1) {
          cart.crashed = true;
          spaces[cart.y][cart.x].avatar = cart.avatar();

          for (var x in otherCarts) {
            toRemoves.add(x);
          }
        }
        spaces[cart.y][cart.x].occupied = true;
        spaces[cart.y][cart.x].avatar = cart.avatar();
      }
      for (var toRemove in toRemoves) {
        carts.remove(toRemove);
      }
      carts.sort();

      if (run) {
        for (var row in spaces) {
          for (var space in row) {
            space.clear();
          }
        }
      }
    }
    print('Runs: $runs');
    print(carts);
  } catch (e) {
    print(e);
  }
}

class Cart extends Comparable {
  int direction; // 0: left, 1: up, 2: right, 3: down
  int x;
  int y;
  int lastTurn = 0;
  String currSpaceType;
  bool crashed = false;
  Cart(String direction, this.x, this.y) {
    switch (direction) {
      case '<':
        this.direction = 0;
        break;
      case '^':
        this.direction = 1;
        break;
      case '>':
        this.direction = 2;
        break;
      case 'v':
        this.direction = 3;
        break;
    }
    switch (this.direction) {
      case 0:
      case 2:
        currSpaceType = '-';
        break;
      default:
        currSpaceType = '|';
    }
  }

  advance(List<List<Space>> spaces) {
    switch (this.direction) {
      case 0:
        this.x -= 1;
        break;
      case 1:
        this.y -= 1;
        break;
      case 2:
        this.x += 1;
        break;
      case 3:
        this.y += 1;
        break;
    }
    this.setSpace(spaces[this.y][this.x]);
  }

  avatar() {
    if (crashed) {
      return 'X';
    }
    switch (this.direction) {
      case 0:
        return '<';
      case 1:
        return '^';
      case 2:
        return '>';
      case 3:
        return 'v';
    }
  }

  toString() {
    if (this.crashed) {
      return 'Crashed at $x, $y';
    }
    return '[$x, $y]';
  }

  setSpace(Space space) {
    if (space.occupied) {
      this.crashed = true;
    } else {
      this._setCurrSpaceType(space.type);
      this._updateDirection();
    }
  }

  _updateDirection() {
    // 0: left, 1: up, 2: right, 3: down

    switch (this.currSpaceType) {
      case '\\':
        if (this.direction == 1) {
          this.direction = 0;
        } else if (this.direction == 3) {
          this.direction = 2;
        } else {
          this.direction += 1;
        }
        break;
      case '/':
        if (this.direction == 3) {
          this.direction = 0;
        } else if (this.direction == 1) {
          this.direction = 2;
        } else {
          this.direction -= 1;
        }
        break;
      case '+':
        switch (lastTurn) {
          case 2:
            direction += 1;
            lastTurn = 0;
            break;
          case 1:
            lastTurn = 2;
            break;
          case 0:
            direction -= 1;
            lastTurn = 1;
            break;
        }
        break;
      case ' ':
        print('fuck');
        break;
      default:
        break;
    }
    if (this.direction > 3) {
      this.direction = 0;
    }
    if (this.direction < 0) {
      this.direction = 3;
    }
  }

  _setCurrSpaceType(String type) {
    this.currSpaceType = type;
  }

  @override
  int compareTo(other) {
    if (y - other.y == 0) {
      return x - other.x;
    }
    return y - other.y;
  }
}

class Space {
  final int x;
  final int y;
  final String type;
  String avatar;
  bool occupied;
  Space(this.x, this.y, this.type, this.occupied);
  clear() {
    this.occupied = false;
  }

  toString() {
    if (occupied) {
      return '$avatar';
    }
    return '$type';
  }
}
