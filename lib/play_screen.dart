import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myfirstapp/players.dart';
import 'species.dart';
import 'attack_cards.dart';
import 'players.dart';
import 'card_classes.dart';
import 'decks.dart';

void setupGame() {
  List<Species> PlayerList = [
    playerOne,
    playerTwo,
    playerThree,
  ];
  playerOne.hand.add(6);
}

class GameScreen extends StatefulWidget {
  // final Species player;
  // final List<Species> playerList = players();
  GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Widget> screenIndex = [
    const PlayScreen(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 38, 162, 42),
            title: const Text('Survival of the Fittest'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.play_arrow_sharp),
                label: 'Play',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.upgrade),
                label: 'Mutations',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.surround_sound),
                label: 'Opponents',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
          body: screenIndex.elementAt(_selectedIndex)),
    );
  }
}

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

Completer<void>? nextButtonCompleter;

class _PlayScreenState extends State<PlayScreen> {
  Future<void> choosePrey() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OpponentScreen(
          player: playerOne,
          chooseAPlayer: true,
        ),
      ),
    );
    final completer = Completer<void>();
    nextButtonCompleter = completer;
    // This line will wait until onPressed called
    await completer.future;
    // return prey;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selected,
      builder: (context, value, child) {
        return Column(children: [
          Text('Reproduction: ${playerOne.reproduction}'),
          Text('Strength: ${playerOne.strength}'),
          Text('Speed: ${playerOne.speed}'),
          Text('Energy: ${playerOne.energy}'),
          Text('Aggression: ${playerOne.aggression}'),
          Text('Diet: ${playerOne.diet}'),
          Text('Population: ${playerOne.population}'),
          Center(
            child: SizedBox(
              height: 300,
              child: ListView(
                  shrinkWrap: true, scrollDirection: Axis.horizontal, children: cardNumsToCards(playerOne.hand)),
            ),
          ),
          GestureDetector(
            child: ValueListenableBuilder<bool>(
                valueListenable: canPlay,
                builder: (context, value, child) {
                  return TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: (selected.value != 999) & canPlay.value ? Colors.green : Colors.lightGreen,
                          foregroundColor: Colors.white // Text Color
                          ),
                      onPressed: () async {
                        if ((selected.value == 999) | !canPlay.value) return;
                        if (cardTypes[intToCardName[selected.value]] == 'attack') {
                          if (!predatorConditions[intToCardName[selected.value]]?.call(playerOne)) return;
                          await choosePrey();
                          if (!preyConditions[intToCardName[selected.value]]?.call(prey)) return;
                        }
                        setState(
                          () {
                            cardFunctions[intToCardName[selected.value]]?.call(playerOne);
                            playerOne.hand.remove(selected.value);
                            discardNumList.add(selected.value);
                            selected.value = 999;
                          },
                        );
                        print('playerTwo population: ${playerTwo.population}');
                        print('playerThree population: ${playerThree.population}');
                      },
                      child: const Text(
                        'Play',
                        style: TextStyle(fontSize: 25),
                      ));
                }),
          ),
          Center(child: Text("Energy Remaining: ${playerOne.energyToSpend}")),
        ]);
      },
    );
  }
}

class CardZoomed extends StatelessWidget {
  final String imgPath;
  const CardZoomed({required this.imgPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Center(
            child: Text(
              'Survival of the Fittest',
              style: TextStyle(fontSize: 30),
            ),
          ),
          backgroundColor: Colors.green,
        ),
      ),
      body: Image.asset(imgPath),
    );
  }
}
