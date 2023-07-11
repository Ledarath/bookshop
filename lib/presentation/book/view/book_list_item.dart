import 'package:bookshop/data/book/model.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatefulWidget {
  final Book book;
  final Function(Book) onAddToCart;

  const BookListItem({Key? key, required this.book, required this.onAddToCart})
      : super(key: key);

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(widget.book.title),
        subtitle: Text("Price : ${widget.book.price.toString()}€"),
        leading: Image.network(widget.book.cover),
      ),
      MaterialButton(
          onPressed: () {
            widget.onAddToCart(widget.book);
          },
          child: const Text("Add to cart"))
    ]);
  }
}
