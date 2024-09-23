import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

//dart run build_runner build --delete-conflicting-outputs

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted, 
  });

  /// ID
  @HiveField(0)
  final String id;

  /// TITLE
  @HiveField(1)
  String title;

  /// SUBTITLE
  @HiveField(2)
  String subtitle;

  /// CREATED AT TIME
  @HiveField(3)
  DateTime createdAtTime;

  /// CREATED AT DATE
  @HiveField(4)
  DateTime createdAtDate;

  /// IS COMPLETED
  @HiveField(5)
  bool isCompleted;

  factory Task.create({
    required String title,
    required String subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title,
        subtitle: subtitle,
        createdAtTime: createdAtTime ?? DateTime.now(),
        createdAtDate: createdAtDate ?? DateTime.now(),
        isCompleted: false,
      );

  Task toggleCompleted() {
    return Task(
      id: id, 
      title: title,
      isCompleted: !isCompleted, 
      subtitle: '', 
      createdAtTime: createdAtTime ?? DateTime.now(), 
      createdAtDate: createdAtTime ?? DateTime.now());
  }
}
