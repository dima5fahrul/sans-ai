import 'package:flutter/material.dart';

import '../shared/my_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Color? bgColor;
  final bool? boldText;
  final Color? textColor;
  final double width;
  final double height;
  final bool? withBorder;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.borderRadius,
    this.padding,
    this.bgColor,
    this.boldText,
    this.textColor,
    required this.width,
    required this.height,
    this.withBorder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        child: Ink(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: bgColor ?? MyColors.primaryColor,
              borderRadius: borderRadius ?? BorderRadius.circular(10),
              border: withBorder ?? false
                  ? Border.all(color: const Color(0xFFDDDDDD), width: 1)
                  : null),
          child: Center(
            child: Text(text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: textColor ?? Colors.white,
                    fontWeight: boldText ?? false
                        ? FontWeight.bold
                        : FontWeight.normal)),
          ),
        ),
      ),
    );
  }
}
