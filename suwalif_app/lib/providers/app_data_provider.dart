import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

class AppDataProvider extends ChangeNotifier {
  List<Child> _children = [];
  List<Task> _tasks = [];
  List<Reward> _rewards = [];
  bool _isLoaded = false;

  List<Child> get children => List.unmodifiable(_children);
  List<Task> get tasks => List.unmodifiable(_tasks);
  List<Reward> get rewards => List.unmodifiable(_rewards);
  bool get isLoaded => _isLoaded;

  List<Task> get pendingTasks => _tasks.where((t) => !t.isCompleted).toList();
  List<Task> get completedTasks => _tasks.where((t) => t.isCompleted).toList();
  List<Reward> get availableRewards => _rewards.where((r) => !r.isRedeemed).toList();

  // Initialize with sample data if empty
  Future<void> init() async {
    if (_isLoaded) return;
    
    await _loadData();
    
    // Add sample data if empty (for demo purposes)
    if (_children.isEmpty) {
      _addSampleData();
    }
    
    _isLoaded = true;
    notifyListeners();
  }

  void _addSampleData() {
    // Sample children
    final child1 = Child(name: 'أحمد', totalPoints: 45);
    final child2 = Child(name: 'فاطمة', totalPoints: 30);
    _children.addAll([child1, child2]);

    // Sample tasks
    _tasks.addAll([
      Task(
        title: 'إنهاء الواجبات المدرسية',
        description: 'إكمال واجبات اليوم',
        points: 10,
        assignedTo: child1.id,
      ),
      Task(
        title: 'تنظيف الغرفة',
        description: 'ترتيب السرير وتنظيف الألعاب',
        points: 15,
        assignedTo: child2.id,
      ),
      Task(
        title: 'قراءة القرآن',
        description: 'قراءة 10 صفحات يومياً',
        points: 20,
        assignedTo: child1.id,
      ),
      Task(
        title: 'مساعدة الأم',
        description: 'المساعدة في تجهيز العشاء',
        points: 10,
        assignedTo: child2.id,
        isCompleted: true,
        completedAt: DateTime.now(),
      ),
    ]);

    // Sample rewards
    _rewards.addAll([
      Reward(
        title: 'ساعة إضافية من الألعاب',
        description: 'اللعب لمدة ساعة إضافية',
        pointsCost: 20,
      ),
      Reward(
        title: 'خروجة إلى الحديقة',
        description: 'زيارة الحديقة العامة',
        pointsCost: 50,
      ),
      Reward(
        title: 'اختيار وجبة العشاء',
        description: 'اختيار ما يحب من الطعام',
        pointsCost: 30,
      ),
    ]);

    _saveData();
  }

  // Child methods
  void addChild(Child child) {
    _children.add(child);
    _saveData();
    notifyListeners();
  }

  void removeChild(String id) {
    _children.removeWhere((c) => c.id == id);
    _saveData();
    notifyListeners();
  }

  Child? getChildById(String id) {
    try {
      return _children.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  // Task methods
  void addTask(Task task) {
    _tasks.add(task);
    _saveData();
    notifyListeners();
  }

  void completeTask(String taskId) {
    final taskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].complete();
      
      // Add points to child
      final child = getChildById(_tasks[taskIndex].assignedTo);
      if (child != null) {
        child.addPoints(_tasks[taskIndex].points);
      }
      
      _saveData();
      notifyListeners();
    }
  }

  void removeTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    _saveData();
    notifyListeners();
  }

  List<Task> getTasksForChild(String childId) {
    return _tasks.where((t) => t.assignedTo == childId).toList();
  }

  // Reward methods
  void addReward(Reward reward) {
    _rewards.add(reward);
    _saveData();
    notifyListeners();
  }

  bool redeemReward(String rewardId, String childId) {
    final rewardIndex = _rewards.indexWhere((r) => r.id == rewardId);
    if (rewardIndex == -1) return false;

    final child = getChildById(childId);
    if (child == null) return false;

    final reward = _rewards[rewardIndex];
    if (child.totalPoints >= reward.pointsCost) {
      child.deductPoints(reward.pointsCost);
      reward.redeem();
      _saveData();
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeReward(String id) {
    _rewards.removeWhere((r) => r.id == id);
    _saveData();
    notifyListeners();
  }

  // Persistence
  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final childrenJson = prefs.getString('children');
      if (childrenJson != null) {
        final List<dynamic> decoded = jsonDecode(childrenJson);
        _children = decoded.map((j) => Child.fromJson(j)).toList();
      }

      final tasksJson = prefs.getString('tasks');
      if (tasksJson != null) {
        final List<dynamic> decoded = jsonDecode(tasksJson);
        _tasks = decoded.map((j) => Task.fromJson(j)).toList();
      }

      final rewardsJson = prefs.getString('rewards');
      if (rewardsJson != null) {
        final List<dynamic> decoded = jsonDecode(rewardsJson);
        _rewards = decoded.map((j) => Reward.fromJson(j)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading data: $e');
      }
    }
  }

  Future<void> _saveData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString('children', jsonEncode(_children.map((c) => c.toJson()).toList()));
      await prefs.setString('tasks', jsonEncode(_tasks.map((t) => t.toJson()).toList()));
      await prefs.setString('rewards', jsonEncode(_rewards.map((r) => r.toJson()).toList()));
    } catch (e) {
      if (kDebugMode) {
        print('Error saving data: $e');
      }
    }
  }

  // Get points for a specific child
  int getChildPoints(String childId) {
    final child = getChildById(childId);
    return child?.totalPoints ?? 0;
  }
}