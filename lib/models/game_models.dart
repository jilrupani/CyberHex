import 'dart:math';

enum NodeType {
  start,
  empty,
  core,     // Data packets to collect
  firewall, // Damage nodes
  drone,    // Active patrol nodes (moving threats)
  port      // Escape portal
}

class HexCoords {
  final int q;
  final int r;

  const HexCoords(this.q, this.r);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HexCoords && runtimeType == other.runtimeType && q == other.q && r == other.r;

  @override
  int get hashCode => q.hashCode ^ r.hashCode;

  int distanceTo(HexCoords other) {
    return ((q - other.q).abs() + (r - other.r).abs() + (q + r - other.q - other.r).abs()) ~/ 2;
  }

  List<HexCoords> get neighbors {
    return [
      HexCoords(q + 1, r),
      HexCoords(q - 1, r),
      HexCoords(q, r + 1),
      HexCoords(q, r - 1),
      HexCoords(q + 1, r - 1),
      HexCoords(q - 1, r + 1),
    ];
  }

  @override
  String toString() => '($q,$r)';
}

class NodeModel {
  final HexCoords coords;
  NodeType type;
  bool isRevealed;
  bool isHacked;
  int coreValue; // Amount of bits/data cores on node

  NodeModel({
    required this.coords,
    required this.type,
    this.isRevealed = false,
    this.isHacked = false,
    this.coreValue = 0,
  });

  NodeModel copy() {
    return NodeModel(
      coords: coords,
      type: type,
      isRevealed: isRevealed,
      isHacked: isHacked,
      coreValue: coreValue,
    );
  }
}

class UpgradeItem {
  final String id;
  final String name;
  final String description;
  final int baseCost;
  int level;
  final int maxLevel;

  UpgradeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.baseCost,
    this.level = 0,
    this.maxLevel = 5,
  });

  int get currentCost => baseCost * (level + 1);

  UpgradeItem copy() {
    return UpgradeItem(
      id: id,
      name: name,
      description: description,
      baseCost: baseCost,
      level: level,
      maxLevel: maxLevel,
    );
  }
}

class LevelModel {
  final int id;
  final String name;
  final String codeName;
  final int maxRam;
  final double baseFirewallSpeed; // Firewall alert growth percentage per move
  final List<NodeModel> nodes;
  final HexCoords startCoords;
  final HexCoords portCoords;
  final List<HexCoords> dronePatrolPath;

  LevelModel({
    required this.id,
    required this.name,
    required this.codeName,
    required this.maxRam,
    required this.baseFirewallSpeed,
    required this.nodes,
    required this.startCoords,
    required this.portCoords,
    this.dronePatrolPath = const [],
  });
}
