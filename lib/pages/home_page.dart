import 'package:flutter/material.dart';
import 'package:io_extended_24_demo_app/pages/chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gemini Demo App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "This is a demo app built for presentation at IO Extended, Lafia, 2024",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, color: Theme.of(context).colorScheme.primary),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, ChatPage.route());
            },
            child: Text("Chat With Gemini"),
          ),
        ],
      ),
    );
  }
}
