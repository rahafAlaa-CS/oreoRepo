import 'package:flutter/material.dart';

class CustomSendButton extends StatefulWidget {
  const CustomSendButton({
    super.key,
    required this.title,
    required this.action,
    this.color,
  });
  final title, action, color;
  @override
  State<CustomSendButton> createState() => _CustomSendButtonState();
}

class _CustomSendButtonState extends State<CustomSendButton> {
  String? title;
  Color? color;
  @override
  void initState() {
    super.initState();
    title = widget.title;
    // action = widget.action;
    color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: widget.action,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
        child: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontFamily: "CrimsonText-Regular",
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
