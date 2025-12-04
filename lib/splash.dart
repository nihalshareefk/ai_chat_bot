import 'package:ai_chat_bot/chat.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash  extends StatelessWidget {
  const Splash ({super.key});

  @override
  Widget build(BuildContext context) { Future.delayed(Duration(seconds: 5), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chat(),));
     
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Lottie.asset("assets/chatbot animation.json")),
    );
  }
}