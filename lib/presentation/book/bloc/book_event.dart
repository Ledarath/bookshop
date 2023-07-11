import 'package:bookshop/data/book/model.dart';

sealed class BookEvent {}

final class BookFetched extends BookEvent {}

final class BookAdded extends BookEvent {
  final Book book;

  BookAdded({required this.book});
}
