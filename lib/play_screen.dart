import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myfirstapp/adaptation_card_framework.dart';
import 'ViewOpponentScreen.dart';
import 'package:myfirstapp/players.dart';
import 'adaptation_cards.dart';
import 'attack_cards.dart';
import 'mutation_card_framework.dart';
import 'species.dart';
import 'attack_card_framework.dart';

ValueNotifier<int> selected = ValueNotifier(999);
ValueNotifier<String> selectedType = ValueNotifier('');
ValueNotifier<bool> canPlay = ValueNotifier(false);

void setupGame() {
  List<Species> playerList = [
    playerOne,
    playerTwo,
    playerThree,
  ];
}

class GameScreen extends StatefulWidget {
  // final Species player;
  // final List<Species> playerList = players();
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Widget> screenIndex = [
    const PlayScreen(),
    const MutationScreen(),
    ViewOpponentScreen(player: playerOne),
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
  Future<void> choosePrey(AttackCardInfo info) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseOpponentScreen(
          player: playerOne,
          info: info,
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
        List handOfInfo = [...playerOne.adaptationCardHand, ...playerOne.attackCardHand];
        List<Widget> handOfWidgets = evolutionCardWidgets(handOfInfo, selected, canPlay);
        int numAdaptationCards = handOfInfo
            .map((element) => element is AdaptationCardInfo ? 1 : 0)
            .reduce((value, element) => value + element);
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
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: handOfWidgets,
              ),
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
                        if ((handOfInfo.elementAt(selected.value) is AdaptationCardInfo)) {
                          AdaptationCardInfo adaptationCardPlayed = handOfInfo.elementAt(selected.value);
                          setState(
                            () {
                              adaptationCardPlayed.effects.call(playerOne);
                              playerOne.adaptationCardHand.remove(adaptationCardPlayed);
                              adaptationCardsDiscard.add(adaptationCardPlayed);
                              selected.value = 999;
                            },
                          );
                        } else if (handOfInfo.elementAt(selected.value) is AttackCardInfo) {
                          AttackCardInfo attackCardPlayed = handOfInfo.elementAt(selected.value);
                          if (!attackCardPlayed.predatorRequirements.call(playerOne, attackCardPlayed)) return;
                          await choosePrey(attackCardPlayed);
                          if (!attackCardPlayed.preyRequirements.call(prey)) return;
                          setState(
                            () {
                              attackCardPlayed.predatorEffects.call(playerOne);
                              attackCardPlayed.preyEffects.call(prey);
                              playerOne.attackCardHand.remove(attackCardPlayed);
                              attackCardsDiscard.add(attackCardPlayed);
                              selected.value = 999;
                            },
                          );
                        }
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

// class CardZoomed extends StatelessWidget {
//   final String imgPath;
//   const CardZoomed({required this.imgPath, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60.0),
//         child: AppBar(
//           title: const Center(
//             child: Text(
//               'Survival of the Fittest',
//               style: TextStyle(fontSize: 30),
//             ),
//           ),
//           backgroundColor: Colors.green,
//         ),
//       ),
//       body: Image.asset(imgPath),
//     );
//   }
// }

List<Widget> evolutionCardWidgets(
  evolutionCards,
  ValueNotifier<int> selected,
  ValueNotifier<bool> canPlay,
) {
  List<Widget> hand = [];
  for (var i = 0; i < evolutionCards.length; i++) {
    if (evolutionCards.elementAt(i) is AdaptationCardInfo) {
      hand.add(AdaptationCard(
          info: evolutionCards.elementAt(i),
          selected: selected,
          selectedType: selectedType,
          canPlay: canPlay,
          cardNum: i));
    } else if (evolutionCards.elementAt(i) is AttackCardInfo) {
      hand.add(AttackCard(
          info: evolutionCards.elementAt(i),
          selected: selected,
          selectedType: selectedType,
          canPlay: canPlay,
          cardNum: i));
    }
  }
  return hand;
}
