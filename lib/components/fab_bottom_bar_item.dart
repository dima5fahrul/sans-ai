import 'package:flutter/material.dart';

class FABBottomBarItem {
  String icon;
  String title;

  FABBottomBarItem({required this.icon, required this.title});
}

class FABBottomBar extends StatefulWidget {
  FABBottomBar({
    super.key,
    required this.items,
    this.centerItemText,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    required this.onTabSelected,
  }) {
    assert(items.length == 2 || items.length == 4);
  }

  final List<FABBottomBarItem> items;
  final String? centerItemText;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final ValueChanged<int> onTabSelected;

  @override
  State<FABBottomBar> createState() => _FABBottomBarState();
}

class _FABBottomBarState extends State<FABBottomBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(
        widget.items.length,
        (int index) => _buildTabItem(
            item: widget.items[index], index: index, onPressed: _updateIndex));

    return BottomAppBar(
        height: 78,
        elevation: 10,
        shadowColor: Colors.black,
        surfaceTintColor: widget.backgroundColor,
        color: widget.backgroundColor,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items));
  }

  Widget _buildTabItem({
    required FABBottomBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: GestureDetector(
            onTap: () => onPressed(index),
            child: Column(
              children: [
                Image.asset(item.icon,
                    height: 22,
                    color: _selectedIndex == index
                        ? widget.selectedColor
                        : widget.color),
                const SizedBox(height: 4),
                Text(item.title,
                    style: _selectedIndex == index
                        ? Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: widget.selectedColor)
                        : Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: widget.color))
              ],
            )),
      ),
    );
  }
}
