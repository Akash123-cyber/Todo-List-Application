// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ToDo/AI/ai_page.dart';
import 'package:ToDo/database/database.dart';
import 'package:ToDo/pages/about_page.dart';
import 'package:ToDo/pages/profile_page.dart';
import 'package:ToDo/pages/settings.dart';
import 'package:ToDo/util/dialog_box.dart';
import 'package:ToDo/util/todo_tile.dart';
import 'package:ToDo/util/build_modern_list_tile_forDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // todo  methods
  // mybox database referencer
  final _myBox = Hive.box("mybox");

  // instance of ToDoDatabase
  ToDoDatabase db = ToDoDatabase();

  //we need to do some checks when the app runs so for that we are using initState
  @override
  void initState() {
    // If this is the 1st time ever opening the app then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }
    loadUserPreferences();
    super.initState();
  }

  // text controller : this will give access to whatever we type in textfiel
  final _controller = TextEditingController();

  //checkbox tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller
          .clear(); // it clears the previous input text after adding to the list;
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // Create new Task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: Navigator.of(context).pop,
        );
      },
    );
  }

  //delete task

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void _onAiAction(String taskName) {
    Navigator.pushNamed(
      context,
      '/ai',
      arguments: taskName, // Pass taskName to AiPage
    );
  }

  // -------------------------------------------------------------------------------------------------------------------------------
  // user preference Strings
  String? userName;
  String? userAge;
  String? userOccupation;
  String? userBio;
  String? userLocation;
  String? profileImage;

  // -----------------------------------------------------------------------------------------------------------------------------------------
  // storing user preferences using SharedPreferences
  late SharedPreferences prefs;

  // //to load the userPreferences
  Future<void> loadUserPreferences() async {
    prefs =
        await SharedPreferences.getInstance(); //we wait for the instance of the sharedpreferences

    setState(() {
      userName = prefs.getString('userName') ?? "User";
      profileImage = prefs.getString("profileImage");
      userAge = prefs.getString("userAge");
      userOccupation = prefs.getString("userOccupation");
      userBio = prefs.getString("userBio");
      userLocation = prefs.getString("userLocation");
    });
  }

  //----------------------------------------------------------------------------------------------------------------------------------------------------
  // navigation to profile
  void _navigateToProfile() async {
    // Navigate to ProfilePage and wait for result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(
          userName: userName,
          userAge: userAge,
          userOccupation: userOccupation,
          userBio: userBio,
          userLocation: userLocation,
          profileImage: profileImage,
          prefs: prefs,
        ),
      ),
    );

    // Update state with returned data
    if (result != null) {
      setState(() {
        userName = result['userName'];
        userAge = result['userAge'];
        userOccupation = result['userOccupation'];
        userBio = result['userBio'];
        userLocation = result['userLocation'];
        profileImage = result['profileImage'];
      });
    }
  }

  // -----------------------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          "ToDo",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2d1b69), Color(0xFF1a1b3a)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },

              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 8.0,
                  top: 8.0,
                  bottom: 8.0,
                ),

                child: (profileImage != null)
                    ? CircleAvatar(
                        backgroundImage: FileImage(File(profileImage!)),
                      )
                    : CircleAvatar(
                        child: Icon(Icons.person, color: Colors.white),
                      ),
              ),
            );
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.all_inclusive_sharp, color: Color(0xff4facfe)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],

        actionsPadding: EdgeInsets.only(right: 10),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff4facfe),
        onPressed: createNewTask,
        child: Icon(Icons.add, color: Colors.white),
      ),

      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2d1b69), Color(0xFF1a1b3a)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // Header Section with Profile
              Container(
                height: 280,
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    // Profile Picture with Modern Design
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4facfe).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: (profileImage != null)
                          ? Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF4facfe),
                                  width: 3,
                                ),
                                image: DecorationImage(
                                  image: FileImage(File(profileImage!)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4facfe),
                                    Color(0xFF00f2fe),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: const Color(0xFF4facfe),
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                    ),

                    const SizedBox(height: 16),

                    // User Name with Modern Typography
                    Text(
                      (userName != null) ? userName! : "Welcome User",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Active User",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Divider line 
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      const Color(0xFF4facfe).withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Drawer Items
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Profile 
                      BuildModernListTile(
                        icon: Icons.person_outline,
                        title: "Profile",
                        subtitle: "Manage your account",
                        gradient: const [Color(0xFF667eea), Color(0xFF764ba2)],
                        onTap: () {
                          Navigator.pop(context);
                          _navigateToProfile();
                        },
                      ),

                      const SizedBox(height: 12),

                      // AI Assistant
                      BuildModernListTile(
                        icon: Icons.smart_toy_outlined,
                        title: "AI Assistant",
                        subtitle: "Get smart suggestions",
                        gradient: const [Color(0xFFff9a9e), Color(0xFFfecfef)],
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AiPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      // About Developer
                      BuildModernListTile(
                        icon: Icons.code_outlined,
                        title: "About Developer",
                        subtitle: "Learn more about creator",
                        gradient: const [Color(0xFF667eea), Color(0xFF764ba2)],
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutPage(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      const Spacer(),

                      // Version Info at Bottom
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF252847).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF4facfe).withOpacity(0.2),
                          ),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "Todo App v1.0",
                              style: TextStyle(
                                color: Color(0xFF94a3b8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Stay organized, stay productive",
                              style: TextStyle(
                                color: Color(0xFF94a3b8),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // --------------------------------------------------------------------------------------------------------------------------------------
      body: Container(
        //
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1a1b3a), Color(0xFF252847)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        //ListView
        child: ListView.builder(
          padding: EdgeInsets.only(
            bottom: 120,
          ), //we need this padding inside the ListView.builder or else if we put it inside
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
              onAiAction: _onAiAction,
            );
          },
        ),
      ),
    );
  }
}
