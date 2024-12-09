import 'dart:math';

Stream<int> creaeStream() async* {
  while (true) {
    await Future.delayed(Duration(seconds: 2));
    yield Random().nextInt(100);
  }
}

Future<int?> creaeFuture() async {
  while (true) {
    await Future.delayed(Duration(seconds: 2));
    return Random().nextInt(100);
  }
}
