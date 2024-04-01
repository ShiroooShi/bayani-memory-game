import 'dart:async';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:madmtr/utils/medium_game_logic.dart';
import 'package:madmtr/widgets/score_board.dart';

class MediumPage extends StatefulWidget {
  final Function(int, String) updateBestTime;
  final int? bestTime;
  const MediumPage({Key? key, required this.updateBestTime, this.bestTime})
      : super(key: key);

  @override
  State<MediumPage> createState() => _MediumPageState();
}

class _MediumPageState extends State<MediumPage> {
  final Game _game = Game();
  int tries = 0;
  int score = 0;
  int _timerSeconds = 60;
  int? MbestTime;
  late Timer _timer;
  late AssetsAudioPlayer _assetsAudioPlayer;

  @override
  void initState() {
    super.initState();
    _game.initGame();
    _startTimer();
    MbestTime = widget.bestTime;
    _assetsAudioPlayer = AssetsAudioPlayer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _timer.cancel();
          _handleGameOver();
        }
      });
    });
  }

  void resetGame() {
    setState(() {
      tries = 0;
      score = 0;
      _game.initGame();
      _timerSeconds = 60;
      _startTimer();
    });
  }

  void _checkWinCondition() {
    Set<String> revealedImages = Set.from(_game.gameImg!);
    revealedImages.remove(_game.hiddenCardPath);
    int uniqueImagesCount = revealedImages.length;
    int pairsCount = _game.card_list.length ~/ 2;

    if (uniqueImagesCount == pairsCount) {
      _timer.cancel();
      if (MbestTime == null || _timerSeconds >= MbestTime!) {
        MbestTime = _timerSeconds;
        widget.updateBestTime(MbestTime!, 'medium');
      }

      _assetsAudioPlayer.open(
        Audio('assets/audio/Win.wav'),
        showNotification: false,
      );

      String message =
          'You win! Time: $_timerSeconds s\nBest Time: ${MbestTime ?? "N/A"} s';
      if (MbestTime == _timerSeconds) {
        message += " (New Best Time!)";
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Congratulations!'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _handleCardTap(int index) {
    setState(() {
      tries++;
      _game.gameImg![index] = _game.card_list[index];
      _game.matchCheck.add({index: _game.card_list[index]});
    });

    if (_game.matchCheck.length == 2) {
      String firstCard = _game.matchCheck[0].values.first;
      String secondCard = _game.matchCheck[1].values.first;

      if (firstCard == secondCard) {
        score += 100;
        _timerSeconds += 3;
        _game.matchCheck.clear();
        _checkWinCondition();

        _assetsAudioPlayer.open(
          Audio('assets/audio/succesfulflip.wav'),
          showNotification: false,
        );

        Map<String, String> nameMap = {
          "assets/images/rizal.jpg": "Jose Rizal",
          "assets/images/mabini.png": "Apolinario Mabini",
          "assets/images/luna.png": "Antonio Luna",
          "assets/images/bonifacio.png": "Andrés Bonifacio",
          "assets/images/aguinaldo.png" : "Emilio Aguinaldo",
          "assets/images/gabriela.png" : "Gabriela Silang",
        };

        String bayaniName = nameMap[firstCard] ?? "Unknown";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$bayaniName'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        Future.delayed(const Duration(milliseconds: 190), () {
          setState(() {
            _game.gameImg![_game.matchCheck[0].keys.first] =
                _game.hiddenCardPath;
            _game.gameImg![_game.matchCheck[1].keys.first] =
                _game.hiddenCardPath;
            _game.matchCheck.clear();
          });
        });
      }
    } else if (_game.matchCheck.length > 2) {
      _game.matchCheck.clear();
      _game.gameImg![index] = _game.hiddenCardPath;
    }
  }

  void _handleGameOver() {
    _assetsAudioPlayer.open(
      Audio('assets/audio/lose.wav'),
      showNotification: false,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('You lose!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: const Text('Bayani Memory Game'),
        actions: [
          Text('Time: $_timerSeconds s'),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetGame,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              scoreBoard('Tries', '$tries'),
              scoreBoard('Score', '$score'),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 36.0,
                ),
                itemCount: _game.gameImg!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (_game.gameImg![index] == _game.hiddenCardPath) {
                        _handleCardTap(index);
                      }
                    },
                    child: Container(
                      height: 200,
                      width: 100,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: AssetImage(_game.gameImg![index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
