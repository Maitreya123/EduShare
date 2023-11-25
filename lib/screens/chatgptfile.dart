import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ChatGPTFile extends StatefulWidget {
  const ChatGPTFile({Key? key}) : super(key: key);

  @override
  State<ChatGPTFile> createState() => _ChatGPTFileState();
}

class _ChatGPTFileState extends State<ChatGPTFile> {
  final TextEditingController promptController = TextEditingController();
  String responseTxt = '';

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  Future<void> fetchResponse() async {
    setState(() {
      responseTxt = 'Loading...';
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['token']}'
        },
        body: convert.jsonEncode(
          {
            "model": "text-davinci-003",
            "prompt": promptController.text,
            "top_p": 1,
            "max_tokens": 250,
            "temperature": 0,
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        final List<dynamic> choices = jsonResponse['choices'];
        setState(() {
          responseTxt = choices.isNotEmpty ? choices[0]['text'] : 'No response';
        });
      } else if (response.statusCode == 429) {
        int retryAfter =
            int.tryParse(response.headers['retry-after'] ?? '30') ?? 30;
        await Future.delayed(Duration(seconds: retryAfter));
        fetchResponse();
      } else {
        setState(() {
          responseTxt = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        responseTxt = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        title: const Text(
          'Flutter and ChatGPT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff343541),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PromptBuilder(responseTxt: responseTxt),
          ),
          TextFormFieldBuilder(
            promptController: promptController,
            onPressed: fetchResponse,
          ),
        ],
      ),
    );
  }
}

class PromptBuilder extends StatelessWidget {
  final String responseTxt;

  const PromptBuilder({
    Key? key,
    required this.responseTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff434654),
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Text(
          responseTxt,
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }
}

class TextFormFieldBuilder extends StatelessWidget {
  final TextEditingController promptController;
  final VoidCallback onPressed;

  const TextFormFieldBuilder({
    Key? key,
    required this.promptController,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              cursorColor: Colors.white,
              controller: promptController,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff444653)),
                  borderRadius: BorderRadius.circular(5.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff444653)),
                ),
                filled: true,
                fillColor: const Color(0xff444653),
                hintText: 'Ask me anything!',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.send, color: Colors.white),
            color: const Color(0xff19bc99),
          ),
        ],
      ),
    );
  }
}
