import 'package:myfirstapp/adaptation_card_framework.dart';
import 'attack_cards.dart';
import 'package:flutter/material.dart';
import 'common_functions.dart';
import 'players.dart';
import 'species.dart';
import 'play_screen.dart';

Species activePlayer = playerOne;
Species prey = playerOne;

class AttackCardInfo {
  final String name;
  final String description;
  final String predatorRequirementsString;
  final String preyRequirementsString;
  final String predatorEffectsString;
  final String preyEffectsString;
  final int cost;
  final Function predatorRequirements;
  final Function preyRequirements;
  final Function predatorEffects;
  final Function preyEffects;

  AttackCardInfo({
    required this.predatorEffectsString,
    required this.preyEffectsString,
    required this.name,
    required this.description,
    required this.cost,
    this.predatorEffects = doNothing,
    this.preyEffects = doNothing,
    this.predatorRequirements = affordable,
    this.preyRequirements = preyAttackTheNest,
    this.predatorRequirementsString = '',
    this.preyRequirementsString = '',
  });
}

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

// ignore: must_be_immutable
class AttackCard extends StatelessWidget {
  final AttackCardInfo info;
  final ValueNotifier<int> selected;
  final ValueNotifier<String> selectedType;
  final ValueNotifier<bool> canPlay;
  final int cardNum;
  AttackCard({
    super.key,
    required this.info,
    required this.selected,
    required this.selectedType,
    required this.canPlay,
    required this.cardNum,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selected,
      builder: (context, value, child) {
        return GestureDetector(
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: (cardNum == selected.value) & (selectedType.value == 'attack')
                ? (info.predatorRequirements.call(playerOne, info) ? Colors.red : Colors.pink)
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: InkWell(
              splashColor: Colors.redAccent,
              onTap: () {
                selectedType.value = 'attack';
                selected.value = cardNum;
                canPlay.value = info.predatorRequirements.call(playerOne, info);
              },
              child: SizedBox(
                width: 180,
                height: 300,
                child: Column(
                  children: [
                    Text(info.name),
                    Text(info.description),
                    Text(info.predatorEffectsString),
                    Text(info.preyEffectsString),
                    Text(info.cost.toString()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<AttackCardInfo> drawAttackCards(int numCards) {
  attackCards.shuffle();
  if (attackCards.length < numCards) {
    attackCardsDiscard.shuffle();
    attackCards.addAll(attackCardsDiscard);
    attackCardsDiscard = [];
  }
  List<AttackCardInfo> drawn = [];
  for (var i = 0; i < numCards; i++) {
    drawn.add(attackCards.first);
    attackCards.remove(attackCards.first);
  }
  return drawn;
}
