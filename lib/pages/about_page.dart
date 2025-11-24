import 'dart:io';

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1a1b3a), Color(0xFF252847)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "About ~ Developer",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.deepPurple,
              size: 25,
            ),
          ),
        ),
      
        body: InteractiveViewer(
          panEnabled: true,
          scaleEnabled: true,
      
          minScale: 0.8,
          maxScale: 3.0,
      
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'lib/assets/images/profilePic.jpg',
                    ),
                    radius: 100,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Developer : Akash Kumar Malik",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 18,
                          color: Colors.purpleAccent,
                          offset: Offset(0, 0),
                        ),
                        Shadow(
                          blurRadius: 38,
                          color: Colors.purple,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
      
                // Section: About the Developer
                const Text(
                  "👨‍💻 About the Developer :",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Alias: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "DevEnthusiast",
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white, height: 1.5),
                    children: [
                      TextSpan(
                        text: "• A passionate beginner Flutter developer.\n\n",
                      ),
                      TextSpan(
                        text:
                            "• Recently completed this To-Do app — my first fully functional Flutter project.\n\n",
                      ),
                      TextSpan(
                        text:
                            "• Enjoys learning by building practical, real-world apps.\n\n",
                      ),
                      TextSpan(
                        text:
                            "• Believes in writing clean UI, keeping things simple, and improving one line at a time.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
      
                // Section: Tech Stack
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.6,
                    ),
                    children: [
                      TextSpan(
                        text: "🔧 Tech Stack Used :\n\n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: "    • Framework: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "Flutter\n\n"),
      
                      TextSpan(
                        text: "    • Database: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "Hive And SharedPreferences\n\n"),
      
                      TextSpan(
                        text: "    • Language: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "Dart\n\n"),
      
                      TextSpan(
                        text: "    • Tools:\n\n",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: "        • VS Code\n\n"),
                      TextSpan(text: "        • Android Emulator\n\n"),
                      TextSpan(text: "        • Flutter DevTools"),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Bottom padding space
              ],
            ),
          ),
        ),
      ),
    );
  }
}
