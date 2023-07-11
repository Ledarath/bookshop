import 'package:bookshop/data/offers/model.dart';
import 'package:dio/dio.dart';

class OfferApi {
  final dio = Dio();
  final String startingUrl = 'https://henri-potier.techx.fr/books/';
  final String endingUrl = '/commercialOffers';

  Future<List<Offer>> fetchOffers(List<String> isbnList) async {
    final response =
        await dio.get(startingUrl + isbnList.join(',') + endingUrl);

    var data = response.data;

    if (data == null) {
      return [];
    }

    var offersApi = data['offers'];
    if (offersApi == null) {
      return [];
    }

    var offers = offersApi.map<Offer>((json) => Offer.fromJson(json)).toList();

    return offers;
  }
}
