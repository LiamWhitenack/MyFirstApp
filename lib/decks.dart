import 'card_classes.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> selected = ValueNotifier(999);
ValueNotifier<String> selectedType = ValueNotifier('');
ValueNotifier<bool> canPlay = ValueNotifier(false);

List<AdaptationCardInfo> adaptationCards = [longLegs, longLegs, longLegs, sharpTeeth, sharpTeeth, sharpTeeth];
List<AdaptationCardInfo> adaptationCardsDiscard = [];

List<AttackCardInfo> attackCards = [attackTheNest, attackTheNest, attackTheNest];
List<AttackCardInfo> attackCardsDiscard = [];

AdaptationCardInfo longLegs = AdaptationCardInfo(
  effectsString: '+1 Speed, +1 Aggression',
  name: 'Longer Legs',
  description: 'Move faster',
  requirementsString: '',
  cost: 1,
);

AdaptationCardInfo sharpTeeth = AdaptationCardInfo(
  effectsString: '+1 Strength, +1 Aggression',
  name: 'Sharp Teeth',
  description: 'Fight better',
  requirementsString: '',
  cost: 1,
);

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

List<Widget> attackCardWidgets(
    List<AttackCardInfo> attackCards, ValueNotifier<int> selected, ValueNotifier<bool> canPlay) {
  List<Widget> hand = [];
  for (var i = 0; i < attackCards.length; i++) {
    hand.add(AttackCard(
        info: attackCards.elementAt(i), selected: selected, selectedType: selectedType, canPlay: canPlay, cardNum: i));
  }
  return hand;
}

List<AdaptationCardInfo> drawAdaptationCards(int numCards) {
  adaptationCards.shuffle();
  if (adaptationCards.length < numCards) {
    adaptationCardsDiscard.shuffle();
    adaptationCards.addAll(adaptationCardsDiscard);
    adaptationCardsDiscard = [];
  }
  List<AdaptationCardInfo> drawn = [];
  for (var i = 0; i < numCards; i++) {
    drawn.add(adaptationCards.first);
    adaptationCards.remove(adaptationCards.first);
  }
  return drawn;
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
