class HouseModel {
  final String title;
  final String location;
  final String imageUrl;
  final int price;
  final int bedroom;
  final int bathroom;
  final bool isNearby;
  final bool isRecommended;
  final double? distance;

  HouseModel({
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.bedroom,
    required this.bathroom,
    this.isNearby = false,
    this.isRecommended = false,
    this.distance,
  });
}
