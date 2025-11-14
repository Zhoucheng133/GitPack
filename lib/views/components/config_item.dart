import 'package:flutter/material.dart';

class ConfigItem extends StatefulWidget {

  final String label;
  final Widget child;
  final double gap;
  final double? height;

  const ConfigItem({super.key, required this.label, required this.child, this.gap=10, this.height=35});

  @override
  State<ConfigItem> createState() => _ConfigItemState();
}

class _ConfigItemState extends State<ConfigItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.label)
            ),
          ),
          SizedBox(width: widget.gap,),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: widget.child
            ),
          ),
        ],
      ),
    );
  }
}