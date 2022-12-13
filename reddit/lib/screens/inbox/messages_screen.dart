import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/inbox/message_widget.dart';

class MessagesScreen extends StatefulWidget {
  static const routeName = '/messages_screen';
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<MessageWidget> messages = [
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
    const MessageWidget(
        messageBody:
            'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
        messageTitle: 'The mod Snoosletter is Thankful for you This November',
        subredditName: 'u/ModNewsLetter',
        time: '.1mo'),
  ];

  @override
  void initState() {
    // TODO: here we should send a request to the backend to get the messages
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? Expanded(
            child: SizedBox(
              child: Center(
                child: Image.asset('assets/images/Empty.jpg'),
              ),
            ),
          )
        : ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Card(
                color: ColorManager.black,
                child: messages[index],
              );
            },
          );
  }
}
