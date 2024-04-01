import 'dart:math';

class Game {
  final String hiddenCardPath = 'assets/images/cards.png';
  List<String>? gameImg;

  final List<String> card_list = [
    "assets/images/rizal.jpg", //
    "assets/images/bonifacio.png", //
    "assets/images/rizal.jpg", //
    "assets/images/luna.png", //
    "assets/images/bonifacio.png", //
    "assets/images/luna.png", //
    "assets/images/mabini.png", //
    "assets/images/gabriela.png", //
    "assets/images/gabriela.png", //
    "assets/images/aguinaldo.png", //
    "assets/images/aguinaldo.png", //
    "assets/images/mabini.png", //
  ];

  List<Map<int, String>> matchCheck = [];

  final int cardCount = 12;

  void initGame() {
    card_list.shuffle();

    gameImg = List.generate(cardCount, (index) => hiddenCardPath);
  }
}
