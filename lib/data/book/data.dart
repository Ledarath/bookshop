import 'package:bookshop/data/book/model.dart';
import 'package:dio/dio.dart';

class BookApi {
  final dio = Dio();
  final String bookUrl = 'https://henri-potier.techx.fr/books';

  Future<List<Book>> fetchBooks() async {
    final response = await dio.get(bookUrl);

    var books = response.data.map<Book>((json) => Book.fromJson(json)).toList();

    return books;
  }
}
