import 'package:flutter/material.dart';
import 'package:ToDo/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xff252847),

      content: SizedBox(
        height: 200,
        width: 300,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color(0xff2d1b69), Color(0xff1a1b3a)],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(padding: EdgeInsets.all(5.0)),
            //get user input
            TextField(
              //controller to control the input text
              controller: controller,

              //decoration
              decoration: InputDecoration(
                //enabledBorder
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.cyanAccent,
                    width: 0.8, //
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),

                //focusedBorder
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.cyanAccent,
                    width: 2, //
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),

                //hint text and style
                hintText: "Add a new task ......",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,

                  //
                ),
              ),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: 4,
            ),

            const SizedBox(height: 10),
            //button -> save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                //save Button
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 10),

                //Cancel Button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
