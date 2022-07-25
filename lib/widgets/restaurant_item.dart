import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/local/restaurant.dart';
import 'package:restaurant_app/widgets/icon_label.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({
    Key? key,
    required this.restaurant,
    required this.onTap,
  }) : super(key: key);

  final RestaurantLocal restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(restaurant.pictureId),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 8),
                IconLabel(
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  label: Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 8),
                IconLabel(
                  icon: const Icon(Icons.star),
                  label: Text(
                    restaurant.rating.toString(),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
