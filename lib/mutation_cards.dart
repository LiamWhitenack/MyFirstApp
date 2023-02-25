import 'package:myfirstapp/attack_cards.dart';
import 'package:myfirstapp/players.dart';

import 'species.dart';

List<MutationCardInfo> mutationCards = [multipleStomachs, multipleStomachs];

MutationCardInfo multipleStomachs = MutationCardInfo(
    name: 'Multiple Stomachs',
    description: 'Now that you can safely consume practically anything, you will never go hungry',
    requirementsString: 'Strength > 4, Terrain must be plains',
    effectsString: 'Start every turn with 3 energy',
    cost: 3);

class MutationCardInfo {
  final String name;
  final String description;
  final String requirementsString;
  final String effectsString;
  final int cost;
  final Function requirements;
  final Function beforePreyEffects;
  final Function afterPreyEffects;
  final Function startOfTurnEffects;
  final Function endOfTurnEffects;
  final Function endOfRoundEffects;

  MutationCardInfo({
    required this.name,
    required this.description,
    required this.requirementsString,
    required this.effectsString,
    required this.cost,
    this.requirements = affordable,
    this.beforePreyEffects = doNothing,
    this.afterPreyEffects = doNothing,
    this.startOfTurnEffects = doNothing,
    this.endOfTurnEffects = doNothing,
    this.endOfRoundEffects = doNothing,
  });
}

void doNothing(Species player) {
  return;
}

bool affordable(Species player, info) {
  return player.energyToSpend >= info.cost;
}
