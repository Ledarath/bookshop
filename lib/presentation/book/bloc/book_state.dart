import 'package:bookshop/data/book/model.dart';
import 'package:bookshop/data/offers/model.dart';

enum BookStatus { initial, success, failure }

final class BookState {
  const BookState(
      {this.status = BookStatus.initial,
      this.books = const <Book>[],
      this.selectedBooks = const <Book>[],
      this.bestCommercialOffer,
      this.bestTotalCart});

  final BookStatus status;
  final List<Book> books;
  final List<Book> selectedBooks;
  final Offer? bestCommercialOffer;
  final num? bestTotalCart;

  BookState copyWith(
      {BookStatus? status,
      List<Book>? books,
      List<Book>? selectedBooks,
      Offer? bestCommercialOffer,
      num? bestTotalCart}) {
    return BookState(
        status: status ?? this.status,
        books: books ?? this.books,
        selectedBooks: selectedBooks ?? this.selectedBooks,
        bestCommercialOffer: bestCommercialOffer ?? this.bestCommercialOffer,
        bestTotalCart: bestTotalCart ?? this.bestTotalCart);
  }

  List<Object> get props => [status, books, selectedBooks];
}
