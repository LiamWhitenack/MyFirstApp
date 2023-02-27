// ignore_for_file: prefer_const_constructors

import 'package:myfirstapp/common_functions.dart';

import 'adaptation_card_framework.dart';
import 'species.dart';

List<AdaptationCardInfo> adaptationCards = [longLegs, longLegs, longLegs, sharpTeeth, sharpTeeth, sharpTeeth];
List<AdaptationCardInfo> adaptationCardsDiscard = [];

// ================================================================================================================
// Long Legs Card

AdaptationCardInfo longLegs = AdaptationCardInfo(
  effectsString: '+1 Speed, +1 Aggression',
  name: 'Longer Legs',
  description: 'Move faster',
  requirementsString: '',
  cost: 1,
  requirements: affordable,
  effects: playSharpTeeth,
);

void playLongLegs(Species player) {
  player.increaseAggression(1);
  player.increaseSpeed(1);
  player.increaseEnergyToSpend(-1);
}

// ================================================================================================================
// Sharp Teeth Card

AdaptationCardInfo sharpTeeth = AdaptationCardInfo(
  effectsString: '+1 Strength, +1 Aggression',
  name: 'Sharp Teeth',
  description: 'Fight better',
  requirementsString: '',
  cost: 1,
  requirements: affordable,
  effects: playSharpTeeth,
);

void playSharpTeeth(Species player) {
  player.increaseAggression(1);
  player.increaseStrength(1);
  player.increaseEnergyToSpend(-1);
}
