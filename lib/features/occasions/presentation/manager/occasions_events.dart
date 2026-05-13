sealed class OccasionsEvents {}

class GetOccasionsCategoriesEvent extends OccasionsEvents {}

class GetOccasionProductsEvent extends OccasionsEvents {
  final String occasionId;

  GetOccasionProductsEvent({required this.occasionId});
}
