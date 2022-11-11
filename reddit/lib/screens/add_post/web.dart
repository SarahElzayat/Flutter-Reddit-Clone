// import 'package:flutter/material.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.grey,
//         primaryColor: Colors.black,
//         brightness: Brightness.dark,
//         backgroundColor: const Color(0xFF212121),
//         dividerColor: Colors.black12,
//       ),
//       home: const WebPage(),
//     );
//   }
// }

// class WebPage extends StatefulWidget {
//   const WebPage({Key? key}) : super(key: key);

//   @override
//   State<WebPage> createState() => _WebPageState();
// }

// class _WebPageState extends State<WebPage> {
//   HtmlEditorController controller = HtmlEditorController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(),
//       body: Column(
//         children: [
//           HtmlEditor(
//             htmlToolbarOptions: HtmlToolbarOptions(defaultToolbarButtons: [
//               const FontSettingButtons(),
//               const FontButtons(clearAll: false),
//               const ListButtons(listStyles: false),
//               const InsertButtons(
//                   video: true,
//                   audio: false,
//                   table: true,
//                   hr: false,
//                   otherFile: false),
//               const OtherButtons(
//                 fullscreen: false,
//                 codeview: true,
//                 undo: false,
//                 redo: false,
//                 help: false,
//                 copy: false,
//                 paste: false,
//               )
//             ], customToolbarInsertionIndices: [
//               0,
//             ], customToolbarButtons: [
//               MaterialButton(
//                 onPressed: (() {}),
//                 child: const Text('TestWidget'),
//               ),
//             ]),
//             controller: controller, //required
//             htmlEditorOptions: const HtmlEditorOptions(
//               hint: 'Your text here...',
//             ),
//             otherOptions: const OtherOptions(
//               height: 400,
//             ),
//           ),
//           MaterialButton(
//             onPressed: (() async {
//               controller.getText();
//             }),
//             child: const Text('Print Text'),
//           )
//         ],
//       ),
//     );
//   }
// }
