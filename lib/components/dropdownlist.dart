import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> dropdownValues;
  final String selectedValue;
  final void Function(String?) onChanged;

  MyDropdown({
    required this.dropdownValues,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          width: 165,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black),
          ),
          child: InkWell(
            onTap: _showDropdownMenu,
            child: Row(
              children: [
                const SizedBox(width: 10.0),
                Text(widget.selectedValue),
                const Expanded(child: SizedBox()),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDropdownMenu() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + 35.0,
        offset.dx + 165.0,
        offset.dy + 35.0,
      ),
      items: widget.dropdownValues.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(value),
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      }).toList(),
    ).then((String? newValue) {
      if (newValue != null) {
        widget.onChanged(newValue);
      }
    });
  }
}
