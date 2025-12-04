import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messagecontroller = TextEditingController();
  List<Map<String, dynamic>> messagelist = [];

  get message => null;
  Future<void> sendmessage(String usermessage) async {
    setState(() {
      messagelist.add({"role": "user", "text": usermessage});
    });
    final Url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyD8cv4ua4yvOZPhDPMCW3AZyZrjt62s6fs",
    );
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": usermessage},
          ],
        },
      ],
    });
    try {
      final response = await http.post(Url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data['candidates'][0]['content']['parts'][0]['text'];
        setState(() {
          messagelist.add({'role': 'bot', 'text': botReply});
        });
      } else {
        setState(() {
          message.add({
            'role': 'bot',
            'text': 'something went wrong,please try again later',
          });
        });
      }
    } catch (e) {
      setState(() {
        messagelist.add({'role': 'bot', 'text': 'Error:$e'});
      });
    } finally {
      setState(() {
        {
          messagecontroller.clear();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(
          child: Text(
            "AI CHAT BOT",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Align(
        alignment: AlignmentGeometry.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messagelist.length,
                  itemBuilder: (context, index) =>
                      messagebox(messagelist.toList()[index]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messagecontroller,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add),
                            ),
                            hintText: "Ask Anything",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(width: 1.3),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed:  () {
                                sendmessage(messagecontroller.text.trim());
                              }
                            ,
                        icon: Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget messagebox(Map<String, dynamic> message) {
    bool Isuser = message["role"] == "user";
    return Align(
      alignment: Isuser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Isuser ? Colors.greenAccent : Colors.white,
        ),
        child: Text(
          message['text'] ?? '',
          style: TextStyle(color: Isuser ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
