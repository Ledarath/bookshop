import 'package:bookshop/data/book/data.dart';
import 'package:bookshop/data/book/model.dart';

class BookRepository {
  final BookApi _bookApi;

  BookRepository({required BookApi bookApi}) : _bookApi = bookApi;

  Future<List<Book>> fetchBooks() async {
    return await _bookApi.fetchBooks();
  }
}
