import 'package:bookshop/data/offers/data.dart';
import 'package:bookshop/data/offers/model.dart';

class OfferRepository {
  final OfferApi _offerApi;

  OfferRepository({required OfferApi offerApi}) : _offerApi = offerApi;

  Future<List<Offer>> fetchOffers(List<String> isbn) async {
    return await _offerApi.fetchOffers(isbn);
  }
}
