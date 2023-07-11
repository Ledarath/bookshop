enum OfferType { percentage, minus, slice }

final class Offer {
  OfferType type;
  num value;
  num? sliceValue;

  Offer({
    required this.type,
    required this.value,
    required this.sliceValue,
  });

  static OfferType getTypeFromString(String typeStr) {
    switch (typeStr) {
      case 'percentage':
        return OfferType.percentage;
      case 'minus':
        return OfferType.minus;
      case 'slice':
        return OfferType.slice;
      default:
        return OfferType.percentage;
    }
  }

  static Offer fromJson(Map<String, dynamic> json) {
    return Offer(
      type: Offer.getTypeFromString(json['type']),
      value: json['value'],
      sliceValue: json['sliceValue'],
    );
  }
}
