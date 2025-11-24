import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:ToDo/AI/message.dart';

class DirectAiPage extends StatefulWidget {
  final String? taskName; // Optional taskName parameter

  const DirectAiPage({super.key, required this.taskName});

  @override
  State<DirectAiPage> createState() => _DirectAiPageState();
}

class _DirectAiPageState extends State<DirectAiPage>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _message = [];
  bool _isLoading = false;
  late final GenerativeModel _model;
  late final ChatSession _chat;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Initialize the Gemini model with API Key
    final String? apiKey = "AIzaSyDog6W2RrxYWS_yiPznjlWsA-1Kb8sOzNs";
    if (apiKey == null) {
      print("Error: GEMINI_API_KEY not found in secrets.env file");
      return;
    }

    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
    _chat = _model.startChat();

    // Add welcome message
    setState(() {
      _message.add(
        Message(
          content: "Hello! I am your AI assistant.",
          isUser: false,
          timestamp: DateTime.now(),
          id: _generateId(),
        ),
      );
    });

    // If taskName is provided, send it to Gemini
    if (widget.taskName != null && widget.taskName!.isNotEmpty) {
      _sendTaskMessage(widget.taskName!);
    }
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(1000).toString();
  }

  // Send the taskName to Gemini with the specified prompt
  Future<void> _sendTaskMessage(String taskName) async {
    final prompt = "help me with this task $taskName";
    setState(() {
      _message.add(
        Message(
          content: prompt,
          isUser: true,
          timestamp: DateTime.now(),
          id: _generateId(),
        ),
      );
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final response = await _chat.sendMessage(Content.text(prompt));
      setState(() {
        _message.add(
          Message(
            content: response.text ?? "No Response",
            isUser: false,
            timestamp: DateTime.now(),
            id: _generateId(),
          ),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _message.add(
          Message(
            content:
                "Sorry, I couldn't process your request. Please try again.\nError: $e",
            isUser: false,
            timestamp: DateTime.now(),
            id: _generateId(),
          ),
        );
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  Future<void> _sendMessage() async {
    final userMessage = _messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _message.add(
        Message(
          content: userMessage,
          isUser: true,
          timestamp: DateTime.now(),
          id: _generateId(),
        ),
      );
      _isLoading = true;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      final response = await _chat.sendMessage(Content.text(userMessage));
      setState(() {
        _message.add(
          Message(
            content: response.text ?? "No Response",
            isUser: false,
            timestamp: DateTime.now(),
            id: _generateId(),
          ),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _message.add(
          Message(
            content:
                "Sorry, I couldn't process your request. Please try again.\nError: $e",
            isUser: false,
            timestamp: DateTime.now(),
            id: _generateId(),
          ),
        );
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildAvatar(bool isUser) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: isUser
            ? LinearGradient(colors: [Color(0xFF667EEA), Color(0xFF764BA2)])
            : LinearGradient(colors: [Color(0xFF11998E), Color(0xFF38EF7D)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy_sharp,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha:
                  0.3 +
                  (sin(_animationController.value * 2 * pi + index * 0.5) *
                      0.3),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0A0A), Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF667EEA).withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.smart_toy_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI Assistant",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Ask me anything",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.more_vert, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _message.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _message.length && _isLoading) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            _buildAvatar(false),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildDot(0),
                                  SizedBox(width: 4),
                                  _buildDot(1),
                                  SizedBox(width: 4),
                                  _buildDot(2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return _buildMessageBubble(_message[index]);
                  },
                ),
              ),
              _buildInputArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) _buildAvatar(false),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: message.isUser
                    ? LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      )
                    : LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.1),
                          Colors.white.withValues(alpha: 0.05),
                        ],
                      ),
                borderRadius: BorderRadius.circular(20),
                border: message.isUser
                    ? null
                    : Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                boxShadow: [
                  BoxShadow(
                    color: message.isUser
                        ? Color(0xFF667EEA).withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: message.isUser
                  ? Text(
                      message.content,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  : GptMarkdown(
                      message.content,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
            ),
          ),
          SizedBox(width: 8),
          if (message.isUser) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    if (_isLoading) {
      _animationController.repeat();
    } else {
      _animationController.stop();
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: null,
                onSubmitted: (context) {
                  _sendMessage();
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: _isLoading ? null : _sendMessage,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: _isLoading
                    ? LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      )
                    : LinearGradient(
                        colors: [Color(0xFF38EF7D), Color(0xFF11998E)],
                      ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF667EEA).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.send, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
