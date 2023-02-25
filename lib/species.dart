import 'package:myfirstapp/adaptation_card_framework.dart';
import 'attack_card_framework.dart';

class Species {
  int reproduction;
  int strength;
  int speed;
  int energy;
  int aggression;
  int habitat;
  String diet;
  int population;
  int energyToSpend;
  List<AdaptationCardInfo> adaptationCardHand;
  List<AttackCardInfo> attackCardHand;
  List<Species> opponents;

  Species(
    this.reproduction,
    this.strength,
    this.speed,
    this.energy,
    this.aggression,
    this.habitat,
    this.diet,
    this.population,
    this.energyToSpend,
    this.adaptationCardHand,
    this.attackCardHand,
    this.opponents,
  );

  void drawCards() {
    adaptationCardHand.addAll(drawAdaptationCards(reproduction));
    attackCardHand.addAll(drawAttackCards(reproduction));
  }

  void increaseReproduction(int x) => reproduction = reproduction + x;
  void increaseStrength(int x) => strength = strength + x;
  void increaseSpeed(int x) => speed = speed + x;
  void increaseEnergy(int x) => energy = energy + x;
  void increaseAggression(int x) => aggression = aggression + x;
  void increaseHabitat(int x) => habitat = habitat + x;
  void changeDiet(String x) => diet = x;
  void increasePopulation(int x) => population = population + x;
  void increaseEnergyToSpend(int x) => energyToSpend = energyToSpend + x;
}

List homoSapiens = [
  2, // reproduction
  5, // strength
  5, // speed
  5, // energy
  5, // aggression
  5, // habitat
  'carnivore', // diet
  5, // population
  5, // energyToSpend
];
