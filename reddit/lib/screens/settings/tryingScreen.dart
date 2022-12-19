import 'package:flutter/material.dart';

void main() => runApp(TrialScreen());

class TrialScreen extends StatelessWidget {
  const TrialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Trail());
  }
}

class Trail extends StatefulWidget {
  Trail({super.key});
  List<String> items = List.generate(25, (index) => 'Item $index');

  @override
  State<Trail> createState() => _TrailState();
}

class _TrailState extends State<Trail> {
  @override
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent) fetch();
    });
  }

  Future fetch() async {
    /// we should apply the logic of fetching data from the server here.
    setState(() {
      widget.items.addAll(List.generate(25, (index) => 'Item $index'));
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('infinite scroll')),
      body: ListView.builder(
        controller: controller,
        itemCount: widget.items.length + 1,
        itemBuilder: (context, index) {
          return index < widget.items.length
              ? ListTile(
                  title: Text(widget.items[index]),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
