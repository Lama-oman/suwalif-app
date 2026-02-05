import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_data_provider.dart';

class AddRewardScreen extends StatefulWidget {
  const AddRewardScreen({super.key});

  @override
  State<AddRewardScreen> createState() => _AddRewardScreenState();
}

class _AddRewardScreenState extends State<AddRewardScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pointsController = TextEditingController(text: '20');

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('إضافة مكافأة جديدة'),
            backgroundColor: const Color(0xFF2D5A7B),
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Points Presets
                const Text(
                  'اختر عدد النقاط السريع:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [10, 20, 30, 50, 100].map((points) {
                    return ActionChip(
                      avatar: const Icon(Icons.star, color: Colors.amber, size: 18),
                      label: Text('$points'),
                      onPressed: () {
                        setState(() {
                          _pointsController.text = points.toString();
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'اسم المكافأة',
                    hintText: 'مثال: ساعة إضافية من الألعاب',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.card_giftcard),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'وصف المكافأة',
                    hintText: 'وصف تفصيلي للمكافأة',
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
                    labelText: 'التكلفة بالنقاط',
                    hintText: 'مثال: 20',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.star),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                
                // Quick Reward Ideas
                const Text(
                  'أفكار للمكافآت:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildIdeaChip('ساعة إضافية من الألعاب', '20'),
                    _buildIdeaChip('خروجة إلى الحديقة', '50'),
                    _buildIdeaChip('اختيار فيلم للعائلة', '30'),
                    _buildIdeaChip('آيس كريم', '15'),
                    _buildIdeaChip('يوم بدون واجبات', '40'),
                    _buildIdeaChip('لعبة جديدة', '100'),
                    _buildIdeaChip('زيارة الأجداد', '25'),
                    _buildIdeaChip('ساعة إضافية نوم متأخر', '35'),
                  ],
                ),
                
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_titleController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('الرجاء إدخال اسم المكافأة'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final reward = Reward(
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        pointsCost: int.tryParse(_pointsController.text) ?? 20,
                      );

                      provider.addReward(reward);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إضافة المكافأة بنجاح!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'حفظ المكافأة',
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

  Widget _buildIdeaChip(String title, String points) {
    return ActionChip(
      label: Text(title),
      avatar: CircleAvatar(
        backgroundColor: Colors.amber,
        radius: 10,
        child: Text(
          points,
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
      onPressed: () {
        setState(() {
          _titleController.text = title;
          _pointsController.text = points;
        });
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