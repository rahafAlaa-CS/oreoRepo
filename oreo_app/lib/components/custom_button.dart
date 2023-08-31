import 'package:flutter/material.dart';

// import 'package:qabl_alnawm/res/app_theme.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.action,
    this.color,
  });
  final title, action, color;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
        backgroundColor: MaterialStateProperty.all(Color(0xff007A7B)),
      ),
      onPressed: widget.action,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
        child: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontFamily: "CrimsonText-Regular",
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
