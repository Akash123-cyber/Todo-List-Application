import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ToDo/AI/direct_ai_page.dart';

class ToDoTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(String)? onAiAction; // New callback for AI action

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.onAiAction, // Optional callback for AI action
  });

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
      child: GestureDetector(
        onTap: _toggleExpand,
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              // Delete Action
              CustomSlidableAction(
                onPressed: widget.deleteFunction,
                backgroundColor: Colors.redAccent,
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.delete, size: 40, color: Colors.white)],
                ),
              ),
              // AI Action
              CustomSlidableAction(
                onPressed: (context) {
                  // Call the AI action callback or navigate directly
                  
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DirectAiPage(taskName: widget.taskName),
                      ),
                    );
                  },
              
              
                backgroundColor: Colors.blueAccent,
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smart_toy_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
              top: 15,
              right: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.taskCompleted
                    ? [Color(0xff11998e), Color(0xff38ef7d)]
                    : [Color(0xFFff9a56), Color(0xFFff7b54)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.taskCompleted
                      ? Color(0xff38ef7d).withAlpha(95)
                      : Color(0xFFff9a56).withAlpha(95),
                  offset: Offset(0, 3),
                  blurRadius: 7,
                  spreadRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Checkbox(
                      value: widget.taskCompleted,
                      onChanged: widget.onChanged,
                      activeColor: Color(0xFF4facfe),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 13)),
                        Text(
                          widget.taskName,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: widget.taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          overflow: _isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          maxLines: _isExpanded ? null : 2,
                        ),
                        const SizedBox(height: 4),
                        (widget.taskName.length < 83)
                            ? SizedBox.shrink()
                            : Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  _isExpanded
                                      ? "Tap to collapse ▲"
                                      : "Tap to expand ▼",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
