import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/platforms/platform_widget_builder.dart';

class Description extends StatefulWidget {
  const Description({Key? key, required this.description}) : super(key: key);

  final String description;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  static const int minLengthToShowEllipsis = 100;

  bool isCollapsed = true;

  void onToggle() {
    setState(() {
      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: (widget.description.length > minLengthToShowEllipsis &&
                    isCollapsed)
                ? 4
                : 50,
          ),
          if (widget.description.length > minLengthToShowEllipsis)
            const SizedBox(height: 8),
          if (widget.description.length > minLengthToShowEllipsis)
            PlatformWidgetBuilder(
              androidBuilder: InkWell(
                onTap: onToggle,
                child: _buildDescriptionToggle(context, isCollapsed),
              ),
              iOSBuilder: GestureDetector(
                onTap: onToggle,
                child: _buildDescriptionToggle(context, isCollapsed),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildDescriptionToggle(BuildContext context, bool isCollapsed) {
    return Text(
      isCollapsed ? "View More" : "View Less",
      textAlign: TextAlign.justify,
      style:
          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.green),
    );
  }
}
