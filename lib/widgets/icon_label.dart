import 'package:flutter/widgets.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({Key? key, required this.icon, required this.label})
      : super(key: key);

  final Icon icon;
  final Text label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        label,
      ],
    );
  }
}
