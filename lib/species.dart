import 'package:myfirstapp/decks.dart';
import 'package:myfirstapp/players.dart';

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
  List<int> hand;
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
    this.hand,
    this.opponents,
  );

  void drawCards() {
    hand.addAll(drawCardNums(reproduction));
    hand.sort();
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
  'herbivore', // diet
  5, // population
  5, // energyToSpend
];
