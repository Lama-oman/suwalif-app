import 'package:flutter/material.dart';
import 'tasks_screen.dart';
import 'rewards_screen.dart';
import 'family_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TasksScreen(),
    const RewardsScreen(),
    const FamilyScreen(),
  ];

  final List<String> _titles = [
    'سوالف - المهام',
    'المكافآت',
    'العائلة',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              _titles[_currentIndex],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (_currentIndex == 0)
              const Text(
                'مهام ومكافآت العائلة',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
          ],
        ),
        backgroundColor: const Color(0xFF2D5A7B),
        foregroundColor: Colors.white,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.task_alt),
            label: 'المهام',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard),
            label: 'المكافآت',
          ),
          NavigationDestination(
            icon: Icon(Icons.family_restroom),
            label: 'العائلة',
          ),
        ],
      ),
    );
  }
}