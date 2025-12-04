import 'package:ai_chat_bot/chat.dart';
import 'package:ai_chat_bot/splash.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,
      home:Splash(),
    );
  }
}
