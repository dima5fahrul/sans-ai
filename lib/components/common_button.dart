import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final Function()? onPressed;
  final String text;
  final double? width;
  final Color? color;

  const CommonButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.width,
      this.color});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          foregroundColor: Colors.white,
          backgroundColor: widget.color ?? Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Text(widget.text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
