import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlatformWidgetBuilder extends StatelessWidget {
  const PlatformWidgetBuilder({
    Key? key,
    required this.androidBuilder,
    required this.iOSBuilder,
  }) : super(key: key);

  final Widget androidBuilder;
  final Widget iOSBuilder;

  @override
  Widget build(BuildContext context) {
    return (defaultTargetPlatform == TargetPlatform.iOS)
        ? iOSBuilder
        : androidBuilder;
  }
}
