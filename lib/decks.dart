import 'card_classes.dart';
import 'package:flutter/material.dart';
import 'attack_cards.dart';

ValueNotifier<int> selected = ValueNotifier(999);
ValueNotifier<bool> canPlay = ValueNotifier(false);
List<int> cardNumList = returnCardNumList();
List<int> discardNumList = [];

Map<int, String> intToCardName = {
  0: 'Long_Legs-01',
  1: 'Long_Legs-02',
  2: 'Long_Legs-03',
  3: 'Sharp_Teeth-01',
  4: 'Sharp_Teeth-02',
  5: 'Sharp_Teeth-03',
  6: 'Attack_the_Nest-01',
};

Map<String, Widget> adaptationCards = {
  'Long_Legs-01': EvolutionCard(
    imgPath: "images/Adaptation_Cards/Long_Legs-01.png",
    valueNotifier: selected,
    canPlay: canPlay,
    cardnum: 0,
  ),
  'Long_Legs-02': EvolutionCard(
    imgPath: "images/Adaptation_Cards/Long_Legs-02.png",
    valueNotifier: selected,
    canPlay: canPlay,
    cardnum: 1,
  ),
  'Long_Legs-03': EvolutionCard(
    imgPath: "images/Adaptation_Cards/Long_Legs-03.png",
    valueNotifier: selected,
    canPlay: canPlay,
    cardnum: 2,
  ),
  'Sharp_Teeth-01': EvolutionCard(
    imgPath: "images/Adaptation_Cards/Sharp_Teeth-01.png",
    valueNotifier: selected,
    canPlay: canPlay,
    cardnum: 3,
  ),
  'Sharp_Teeth-02': EvolutionCard(
    imgPath: "images/Adaptation_Cards/Sharp_Teeth-02.png",
    valueNotifier: selected,
    canPlay: canPlay,
    cardnum: 4,
  ),
  'Sharp_Teeth-03': EvolutionCard(
    imgPath: "images/Adaptation_Cards/Sharp_Teeth-03.png",
    valueNotifier: selected,
    canPlay: canPlay,
    cardnum: 5,
  ),
  'Attack_the_Nest-01': EvolutionCard(
    imgPath: "images/Attack_Cards/Attack_the_Nest-01.png",
    valueNotifier: selected,
    canPlay: canPlay,
    cardnum: 6,
  ),
};

Map<String, int> cardCosts = {
  'Long_Legs-01': 1,
  'Long_Legs-02': 1,
  'Long_Legs-03': 1,
  'Sharp_Teeth-01': 1,
  'Sharp_Teeth-02': 1,
  'Sharp_Teeth-03': 1,
  'Attack_the_Nest-01': 2,
};

Map<String, String> cardTypes = {
  'Long_Legs-01': 'adaptation',
  'Long_Legs-02': 'adaptation',
  'Long_Legs-03': 'adaptation',
  'Sharp_Teeth-01': 'adaptation',
  'Sharp_Teeth-02': 'adaptation',
  'Sharp_Teeth-03': 'adaptation',
  'Attack_the_Nest-01': 'attack',
};

Map<String, Function> cardFunctions = {
  'Long_Legs-01': playLongLegs,
  'Long_Legs-02': playLongLegs,
  'Long_Legs-03': playLongLegs,
  'Sharp_Teeth-01': playSharpTeeth,
  'Sharp_Teeth-02': playSharpTeeth,
  'Sharp_Teeth-03': playSharpTeeth,
  'Attack_the_Nest-01': playAttackTheNest,
};

List<Widget> cardNumsToCards(List<int> cards) {
  List<Widget> hand = [];
  for (var cardNum in cards) {
    hand.add(adaptationCards[intToCardName[cardNum]]!);
  }
  return hand;
}

List<int> returnCardNumList() {
  List<int> res = [];
  for (var i = 0; i < intToCardName.length; i++) {
    res.add(i);
  }
  res.shuffle();
  return res;
}

List<int> drawCardNums(int numCards) {
  if (cardNumList.length < numCards) {
    discardNumList.shuffle();
    cardNumList.addAll(discardNumList);
    discardNumList = [];
  }
  List<int> drawn = [];
  for (var i = 0; i < numCards; i++) {
    drawn.add(cardNumList.first);
    cardNumList.remove(cardNumList.first);
  }
  drawn.sort();
  return drawn;
}
