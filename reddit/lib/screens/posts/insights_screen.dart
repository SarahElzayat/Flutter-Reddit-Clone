import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import '../../data/post_model/insights_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _singlevRow('Total Views', 'Views', iM.totalViews!),
            _singlevRow('Total Shares', 'Shares', iM.totalShares!),
            _singlevRow('Upvote Rate', 'Upvotes', iM.upvoteRate!),
            _singlevRow('Community Karma', 'Karma', iM.communityKarma!),
          ],
        ),
      ),
    );
  }

  _singlevRow(String label, String text, int count) {
    return Card(
        color: ColorManager.darkGrey,
        child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Text(text),
                SizedBox(
                  width: 10.w,
                ),
                Text(count.toString(),
                    style: const TextStyle(
                        fontSize: 20, color: ColorManager.eggshellWhite)),
              ],
            )));
  }
}
