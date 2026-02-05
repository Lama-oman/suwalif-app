import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_data_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pointsController = TextEditingController(text: '10');
  String? _selectedChildId;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(
      builder: (context, provider, child) {
        final children = provider.children;

        return Scaffold(
          appBar: AppBar(
            title: const Text('إضافة مهمة جديدة'),
            backgroundColor: const Color(0xFF2D5A7B),
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'اسم المهمة',
                    hintText: 'مثال: إنهاء الواجبات المدرسية',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.task_alt),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'وصف المهمة',
                    hintText: 'وصف تفصيلي للمهمة',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _pointsController,
                  decoration: InputDecoration(
                    labelText: 'النقاط المكافئة',
                    hintText: 'مثال: 10',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.star),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                if (children.isNotEmpty) ...[
                  const Text(
                    'تعيين لـ:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: children.map((child) {
                      final isSelected = _selectedChildId == child.id;
                      return ChoiceChip(
                        label: Text(child.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedChildId = selected ? child.id : null;
                          });
                        },
                        selectedColor: const Color(0xFF2D5A7B),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ] else
                  Card(
                    color: Colors.orange.withOpacity(0.1),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'لا يوجد أطفال مضافين. أضف طفلاً أولاً من صفحة العائلة.',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: children.isEmpty || _selectedChildId == null
                        ? null
                        : () {
                            if (_titleController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('الرجاء إدخال اسم المهمة'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            final task = Task(
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              points: int.tryParse(_pointsController.text) ?? 10,
                              assignedTo: _selectedChildId!,
                            );

                            provider.addTask(task);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم إضافة المهمة بنجاح!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'حفظ المهمة',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D5A7B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _pointsController.dispose();
    super.dispose();
  }
}