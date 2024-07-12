import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:io_extended_24_demo_app/model/chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  // Static method to create a route for this page
  static route() => MaterialPageRoute(
        builder: (context) => const ChatPage(),
      );

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _geminiAPIKey = ""; // API key for the Gemini model (should be set to your actual key) - This is not recommended, Actual Apps should use Envied Package
  late GenerativeModel model; // Instance of the GenerativeModel

  final TextEditingController _controller = TextEditingController(); // Controller for the text field
  bool _isLoading = false; // State to show if a message is being sent
  List<Chat> listOfChats = []; // List to store chat messages

  @override
  void initState() {
    super.initState();

    // Initialize the GenerativeModel with the specified model and API key
    model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: _geminiAPIKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Gemini'), // App bar title
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // List view to display chat messages
              children: listOfChats.map((chat) {
                return ListTile(
                  title: Text(chat.message),
                  tileColor: chat.sender == Sender.user ? Colors.purple.shade100 : Colors.white70,
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // Show loading indicator if a message is being sent, otherwise show the send button
                _isLoading
                    ? const CircularProgressIndicator()
                    : FloatingActionButton(
                        onPressed: _sendMessage,
                        child: const Icon(Icons.send),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to handle sending a message
  void _sendMessage() async {
    // These 2 lines ensure nothing happens if the user submit without typing
    final String text = _controller.text;
    if (text.isEmpty) {
      return;
    }

    // Refresh UI to show message and processing state
    setState(() {
      _isLoading = true;

      listOfChats.add(Chat(
        sender: Sender.user,
        message: text,
      ));
    });

    // Send the message to the Gemini model and get the response
    final content = [Content.text(text)];
    final response = await model.generateContent(content);

    // Refresh UI to show Gemini response and stop processing state
    setState(() {
      listOfChats.add(Chat(
        sender: Sender.gemini,
        message: response.text.toString(),
      ));

      _isLoading = false;
      _controller.clear(); // Clear the text field after sending the message
    });
  }
}
