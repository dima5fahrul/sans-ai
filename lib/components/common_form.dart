import 'package:flutter/material.dart';

class CommonForm extends StatelessWidget {
  final String title;
  final TextEditingController textController;
  final double? height;
  final EdgeInsets? padding;
  final bool? obscureText;
  final String? labelText;
  final Function(String)? onChanged;
  final bool isCorrect;
  final int? maxLines;
  final TextAlignVertical? align;
  final Color? fillColor;
  final Icon? prefixIcon;
  final Color? borderColor;

  const CommonForm({
    required this.title,
    required this.textController,
    this.height,
    this.obscureText,
    this.padding,
    this.labelText,
    this.onChanged,
    this.isCorrect = false,
    this.maxLines,
    this.align,
    this.fillColor,
    this.prefixIcon,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        maxLines: maxLines ?? 1,
        minLines: 1,
        textAlignVertical: align ?? TextAlignVertical.bottom,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        controller: textController,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            labelText: labelText,
            hintText: title,
            constraints: BoxConstraints(maxHeight: height ?? 48),
            fillColor: fillColor ?? const Color(0xFFFFFFFF),
            labelStyle: const TextStyle(
                color: Color(0xFF72777A),
                fontSize: 16,
                fontWeight: FontWeight.w400),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: borderColor ?? Colors.transparent, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                    color: borderColor ?? Colors.transparent, width: 1))));
  }
}
