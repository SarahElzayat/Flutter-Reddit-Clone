import 'package:flutter/material.dart';
import 'package:reddit/data/post_model/insights_model.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key, required this.iM});
  final InsightsModel iM;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Insights'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Total Views: '),
            ],
          ),
        ],
      ),
    );
  }
}
