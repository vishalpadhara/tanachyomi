import 'package:flutter/material.dart';
import 'package:tanachyomi/utils/appcolor.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({
    Key? key,
    this.width = 24.0,
    this.height = 24.0,
    this.color,
    this.iconSize,
    this.onChanged,
    this.checkColor,
    this.isChecked,
  }) : super(key: key);

  bool? isChecked;
  final double width;
  final double height;
  final Color? color;
  final double? iconSize;
  final Color? checkColor;
  final Function(bool?)? onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => widget.isChecked = !widget.isChecked!);
        widget.onChanged?.call(widget.isChecked!);
      },
      child: Container(
        child: widget.isChecked!
            ? Icon(
                Icons.check_circle,
                size: widget.iconSize,
                color: AppColor.appColorSecondaryValue,
              )
            : Icon(
                Icons.check_circle_outline,
                size: widget.iconSize,
                color: AppColor.appColorSecondaryValue,
              ),
      ),
    );
  }
}
