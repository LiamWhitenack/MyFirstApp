import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'players.dart';
import 'species.dart';
import 'play_screen.dart';
import 'decks.dart';

Species activePlayer = playerOne;
bool pause = false;
Species prey = playerOne;

List<Widget> opponentCards(Species predator, ValueNotifier listener) {
  List<Species> opponentList = opponents(predator);
  List<Widget> output = [];
  List<int> cardNums = [];
  for (var i = 0; i < opponentList.length; i++) {
    output.add(
      Card(
        child: InkWell(
          onTap: () {
            listener.value = i;
          },
          child: Container(
            height: 112,
            color: listener.value == i ? Colors.blue : Colors.grey,
            child: Column(children: [
              Text('Reproduction: ${opponentList.elementAt(i).reproduction}'),
              Text('Strength: ${opponentList.elementAt(i).strength}'),
              Text('Speed: ${opponentList.elementAt(i).speed}'),
              Text('Energy: ${opponentList.elementAt(i).energy}'),
              Text('Aggression: ${opponentList.elementAt(i).aggression}'),
              Text('Diet: ${opponentList.elementAt(i).diet}'),
              Text('Population: ${opponentList.elementAt(i).population}'),
            ]),
          ),
        ),
      ),
    );
  }
  return output;
}

void playAttackTheNest(Species predator) {
  predator.increasePopulation(2);
  predator.increaseEnergyToSpend(-2);
  prey.increasePopulation(-4);
}

bool predatorAttackTheNest(Species player) {
  return (player.diet == 'carnivore') | (player.diet == 'omnivore');
}

bool alwaysTrue(Species player) {
  return true;
}

Map<String, Function> predatorConditions = {'Attack_the_Nest-01': predatorAttackTheNest};

Map<String, Function> preyConditions = {'Attack_the_Nest-01': alwaysTrue};

class OpponentScreen extends StatelessWidget {
  final Species player;
  final bool chooseAPlayer;
  final ValueNotifier<int> selected = ValueNotifier(999);

  OpponentScreen({required this.player, required this.chooseAPlayer, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !chooseAPlayer
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 38, 162, 42),
              title: const Text('Survival of the Fittest'),
            )
          : AppBar(
              backgroundColor: const Color.fromARGB(255, 38, 162, 42),
              title: const Text('Survival of the Fittest'),
              automaticallyImplyLeading: false,
            ),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: selected,
          builder: (context, value, child) {
            return Column(
              children: [
                Column(
                  children: opponentCards(player, selected),
                ),
                chooseAPlayer
                    ? TextButton(
                        onPressed: () {
                          prey = opponents(player).elementAt(selected.value);
                          Navigator.pop(context);
                          nextButtonCompleter?.complete();
                          nextButtonCompleter = null;
                        },
                        child: const Text('Choose'))
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
