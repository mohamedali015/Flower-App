sealed class OccasionsEvents {}

class GetOccasionsEvent extends OccasionsEvents {}

class GetOccasionProductsEvent extends OccasionsEvents {
  final String occasionId;

  GetOccasionProductsEvent({required this.occasionId});
}
