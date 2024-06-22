import 'package:flutter/material.dart';

class CommonDropdown extends StatelessWidget {
  final String hintText;
  final String value;
  final ValueChanged onChanged;
  final List<String> items;
  final Color? textColor;

  const CommonDropdown(
      {required this.hintText,
      required this.value,
      required this.onChanged,
      required this.items,
      this.textColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600, color: textColor ?? Colors.black)),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.all(12),
              fillColor: Colors.white,
              labelStyle: const TextStyle(
                  color: Color(0xFF72777A),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Color(0xFFE3E5E5), width: 1)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: Color(0xFFE3E5E5), width: 1))),
          value: value,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
