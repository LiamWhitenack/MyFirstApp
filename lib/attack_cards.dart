import 'dart:async';
import 'package:myfirstapp/card_classes.dart';

import 'mutation_cards.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'players.dart';
import 'species.dart';
import 'play_screen.dart';
import 'decks.dart';

Species activePlayer = playerOne;
bool pause = false;
Species prey = playerOne;

List<Widget> opponentCards(Species predator, ValueNotifier listener,
    {Function preyConditions = alwaysTrue, bool attack = false}) {
  List<Species> opponentList = opponents(predator);
  List<Widget> output = [];
  List<bool> viableTargetList = [];
  for (var i = 0; i < opponentList.length; i++) {
    viableTargetList.add(preyConditions.call(opponentList.elementAt(i)));
    output.add(
      Card(
        child: InkWell(
          onTap: () {
            if (viableTargetList.elementAt(i)) listener.value = i;
          },
          child: Container(
            height: 112,
            color: viableTargetList.elementAt(i)
                ? (listener.value == i ? (attack ? Colors.blue : Colors.white) : Colors.white)
                : Colors.grey,
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

bool preyAttackTheNest(Species prey) {
  return (prey.reproduction > 0);
}

bool alwaysTrue(Species player) {
  return true;
}

class ChooseOpponentScreen extends StatelessWidget {
  final Species player;
  final AttackCardInfo info;
  final ValueNotifier<int> selected = ValueNotifier(999);

  ChooseOpponentScreen({required this.info, required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  children: opponentCards(player, selected, preyConditions: info.preyRequirements, attack: true),
                ),
                TextButton(
                    onPressed: () {
                      prey = opponents(player).elementAt(selected.value);
                      Navigator.pop(context);
                      nextButtonCompleter?.complete();
                      nextButtonCompleter = null;
                    },
                    child: const Text('Choose'))
              ],
            );
          },
        ),
      ),
    );
  }
}
