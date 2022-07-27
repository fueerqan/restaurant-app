import 'package:equatable/equatable.dart';

class RestaurantMenuUiModel extends Equatable {
  const RestaurantMenuUiModel({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  final String name;
  final String imageUrl;
  final String price;

  @override
  List<Object?> get props => [name, imageUrl, price];
}
