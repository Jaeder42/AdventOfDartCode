import 'dart:io';

ovewriteLine(dynamic line) {
  stdout.write('\r');
  stdout.write('\x1b[2K');
  stdout.write(line);
}
