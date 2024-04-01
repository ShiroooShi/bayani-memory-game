import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:madmtr/screens/easy.dart';
import 'package:madmtr/screens/hard.dart';
import 'package:madmtr/screens/medium.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? bestTimeEasy;
  int? bestTimeMedium;
  int? bestTimeHard;
  int? EbestTime;
  int? MbestTime;
  int? HbestTime;

  @override
  void initState() {
    super.initState();
    bestTimeEasy = null;
    bestTimeMedium = null;
    bestTimeHard = null;
    EbestTime = null;
    MbestTime = null;
    HbestTime = null;
  }

  void updateBestTime(int time, String difficulty) {
    setState(() {
      switch (difficulty) {
        case 'easy':
          if (bestTimeEasy == null || time < bestTimeEasy!) {
            bestTimeEasy = time;
            EbestTime = time;
          } else if (EbestTime == bestTimeEasy) {
            EbestTime = time;
          }
          break;
        case 'medium':
          if (bestTimeMedium == null || time < bestTimeMedium!) {
            bestTimeMedium = time;
            MbestTime = time;
          } else if (MbestTime == bestTimeMedium) {
            MbestTime = time;
          }
          break;
        case 'hard':
          if (bestTimeHard == null || time < bestTimeHard!) {
            bestTimeHard = time;
            HbestTime = time;
          } else if (HbestTime == bestTimeHard) {
            HbestTime = time;
          }
          break;
      }
    });
  }

  void openScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => screen),
    );
  }

  void openHighScoresDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Best in Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text('Best Easy Time: ${EbestTime ?? "No Record"} sec'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Medium: ${MbestTime ?? "No Record"} sec'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Hard: ${HbestTime ?? "No Record"} sec'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Bayani Memory Game',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to Bayani Memory Game! In this game, you\'ll test your memory skills while learning about Filipino heroes, also known as "Bayani."',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Objective:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'The objective of the game is to match pairs of Bayani character cards by clicking on them. Each card has a unique Bayani character illustration.',
                ),
                const SizedBox(height: 10),
                const Text(
                  'Difficulty Levels:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  '- Easy: 8 pairs of cards\n- Medium: 12 pairs of cards\n- Hard: 20 pairs of cards',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    'assets/images/bayani.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showNextTutorialDialog(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Row(
                      children: [
                        Text('Go to Tutorial',
                            style: TextStyle(
                                fontSize: 16, color: Colors.white60)),
                        SizedBox(width: 10),
                        Icon(Icons.double_arrow, color: Colors.white60),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showNextTutorialDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'How to Play:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Text(
                  '1. Choose Difficulty:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Select a difficulty level (Easy, Medium, or Hard) to start the game.',
                ),
                const SizedBox(height: 5),
                Image.asset('assets/images/step1.png'),
                const SizedBox(height: 10),
                const Text(
                  '2. Match Pairs:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Click on two cards to reveal their characters. If the characters match, the cards stay face-up. If not, they flip back over. Try to remember the locations of the cards to make successful matches.',
                ),
                const SizedBox(height: 5),
                Image.asset('assets/images/step2.png'),
                const SizedBox(height: 10),
                const Text(
                  '3. Winning the Game:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Continue matching pairs until all pairs are matched. The game ends when all pairs are successfully matched.',
                ),
                const SizedBox(height: 5),
                Image.asset('assets/images/step3.png'),
                const SizedBox(height: 10),
                const Text(
                  '4. Recording Your Time:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Try to complete the game in the shortest time possible. Your best time for each difficulty level will be recorded.',
                ),
                const SizedBox(height: 5),
                Image.asset('assets/images/step4.png'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void openEasyPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
          builder: (_) => EasyPage(
              updateBestTime: updateBestTime, bestTime: EbestTime)),
    );
  }

  void openMediumPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
          builder: (_) => MediumPage(
              updateBestTime: updateBestTime,
              bestTime: MbestTime,
              )),
    );
  }

  void openHardPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => HardPage(
        updateBestTime: updateBestTime,
        bestTime: HbestTime,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 180, 123, 123),
      appBar: AppBar(
        backgroundColor:
            Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.leaderboard, color: Colors.white),
          onPressed: () => openHighScoresDrawer(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => showCustomDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.01,
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 350,
                  width: 350,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 190),
                height: 400,
                width: 400,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40, top: 20),
                      child: Text(
                        'ᜊᜌᜈᜒ ᜋᜒᜋ᜔oᜍ᜔ᜌ᜔ ᜄᜋᜒ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(5),
                    Container(
                      margin: const EdgeInsets.only(left: 100),
                      child: const Text(
                        'Bayani Memory Game',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
                      ),
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () => openEasyPage(context),
                      child: const Text('Easy'),
                    ),
                    const Gap(12),
                    ElevatedButton(
                      onPressed: () => openMediumPage(context),
                      child: Text('Medium'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                    ),
                    const Gap(12),
                   ElevatedButton(
                      onPressed: () => openHardPage(context),
                      child: Text('Hard'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
