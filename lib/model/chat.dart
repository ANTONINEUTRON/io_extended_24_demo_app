
class Chat {
  final Sender sender;
  final String message;

  const Chat({
    required this.sender,
    required this.message,
  });
}

enum Sender { user, gemini }
