import 'package:myfirstapp/attack_card_framework.dart';
import 'package:myfirstapp/common_functions.dart';
import 'species.dart';

List<AttackCardInfo> attackCards = [attackTheNest, attackTheNest, attackTheNest];
List<AttackCardInfo> attackCardsDiscard = [];

// =========================================================================================
// Attack the Nest Card

AttackCardInfo attackTheNest = AttackCardInfo(
  name: 'Attack the Nest',
  description: 'Attack the nest and get a quick meal',
  predatorRequirementsString: 'Must be a carnivore',
  preyRequirementsString: 'Must be a carnivore',
  predatorEffectsString: '+2 population',
  preyEffectsString: '+4 population',
  cost: 3,
  predatorEffects: predatorAttackTheNest,
  preyEffects: preyAttackTheNest,
  predatorRequirements: mustBeACarnivore,
);

bool mustBeACarnivore(Species player, info) {
  return (player.diet == 'carnivore') | (player.diet == 'omnivore') & affordable(player, info);
}

void predatorAttackTheNest(Species player) {
  prey.increaseAggression(2);
}

void preyAttackTheNest(Species prey) {
  prey.increasePopulation(-4);
}
