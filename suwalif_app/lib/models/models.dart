import 'dart:convert';
import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final int points;
  final String assignedTo;
  final DateTime createdAt;
  final DateTime? dueDate;
  bool isCompleted;
  DateTime? completedAt;

  Task({
    String? id,
    required this.title,
    required this.description,
    required this.points,
    required this.assignedTo,
    DateTime? createdAt,
    this.dueDate,
    this.isCompleted = false,
    this.completedAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'points': points,
    'assignedTo': assignedTo,
    'createdAt': createdAt.toIso8601String(),
    'dueDate': dueDate?.toIso8601String(),
    'isCompleted': isCompleted,
    'completedAt': completedAt?.toIso8601String(),
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    points: json['points'],
    assignedTo: json['assignedTo'],
    createdAt: DateTime.parse(json['createdAt']),
    dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    isCompleted: json['isCompleted'] ?? false,
    completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
  );

  void complete() {
    isCompleted = true;
    completedAt = DateTime.now();
  }
}

class Reward {
  final String id;
  final String title;
  final String description;
  final int pointsCost;
  final String? assignedTo;
  bool isRedeemed;
  DateTime? redeemedAt;

  Reward({
    String? id,
    required this.title,
    required this.description,
    required this.pointsCost,
    this.assignedTo,
    this.isRedeemed = false,
    this.redeemedAt,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'pointsCost': pointsCost,
    'assignedTo': assignedTo,
    'isRedeemed': isRedeemed,
    'redeemedAt': redeemedAt?.toIso8601String(),
  };

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    pointsCost: json['pointsCost'],
    assignedTo: json['assignedTo'],
    isRedeemed: json['isRedeemed'] ?? false,
    redeemedAt: json['redeemedAt'] != null ? DateTime.parse(json['redeemedAt']) : null,
  );

  void redeem() {
    isRedeemed = true;
    redeemedAt = DateTime.now();
  }
}

class Child {
  final String id;
  final String name;
  final String? avatar;
  int totalPoints;
  final DateTime createdAt;

  Child({
    String? id,
    required this.name,
    this.avatar,
    this.totalPoints = 0,
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'totalPoints': totalPoints,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json['id'],
    name: json['name'],
    avatar: json['avatar'],
    totalPoints: json['totalPoints'] ?? 0,
    createdAt: DateTime.parse(json['createdAt']),
  );

  void addPoints(int points) {
    totalPoints += points;
  }

  bool deductPoints(int points) {
    if (totalPoints >= points) {
      totalPoints -= points;
      return true;
    }
    return false;
  }
}