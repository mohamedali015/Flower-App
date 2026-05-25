sealed class OccasionsEvents {}

class GetOccasionsCategoriesEvent extends OccasionsEvents {}

class GetOccasionProductsEvent extends OccasionsEvents {
  final String occasionId;

  GetOccasionProductsEvent({required this.occasionId});
}

class LoadMoreOccasionProductsEvent extends OccasionsEvents {
  final String occasionId;

  LoadMoreOccasionProductsEvent({required this.occasionId});
}
