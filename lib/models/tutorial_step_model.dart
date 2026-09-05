import 'game_models.dart';

enum TutorialTargetType {
  startNode,
  adjacentNode,
  ramGauge,
  firewallGauge,
  coreNode,
  firewallNode,
  portNode,
  droneNode,
  terminalLog,
}

class TutorialStep {
  final TutorialTargetType targetType;
  final String title;
  final String description;
  final HexCoords? targetCoords;

  const TutorialStep({
    required this.targetType,
    required this.title,
    required this.description,
    this.targetCoords,
  });
}
