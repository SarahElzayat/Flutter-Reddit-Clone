// ///@author Sarah Elzayat

// import 'package:flutter/material.dart';
// import 'package:reddit/components/home_app_bar.dart';
// import 'package:reddit/widgets/posts/post_widget.dart';

// class HistoryScreenForWeb extends StatelessWidget {
//   const HistoryScreenForWeb({super.key});

  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: homeAppBar(context, 0),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Row(
//             children: [
//               MaterialButton(
//                 onPressed: () {
                  
//                 },
//                 child: Text('History'),
//               ),
//               MaterialButton(
//                 onPressed: () {
                  
//                 },
//                 child: Text('Upvoted'),
//               ),
//               MaterialButton(
//                 onPressed: () {
                  
//                 },
//                 child: Text('Downvoted'),
//               ),
//               MaterialButton(
//                 onPressed: () {
                  
//                 },
//                 child: Text('Hiddden'),
//               ),

//               ListView.builder(itemBuilder: (context, index) => PostWidget(post: post),)
//             ],
//           )
//         ]),
//       ),
//     );
//   }
// }
