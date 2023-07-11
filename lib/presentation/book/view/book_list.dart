import 'package:bookshop/data/book/model.dart';
import 'package:bookshop/presentation/book/bloc/book_bloc.dart';
import 'package:bookshop/presentation/book/bloc/book_event.dart';
import 'package:bookshop/presentation/book/bloc/book_state.dart';
import 'package:bookshop/presentation/book/view/book_list_item.dart';
import 'package:bookshop/presentation/book/view/cart_offer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        switch (state.status) {
          case BookStatus.failure:
            return const Center(child: Text('Failed to fetch books'));
          case BookStatus.success:
            if (state.books.isEmpty) {
              return const Center(child: Text('No books'));
            }

            return Column(children: [
              Expanded(
                  child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return BookListItem(
                    book: state.books[index],
                    onAddToCart: (Book book) {
                      context.read<BookBloc>().add(BookAdded(book: book));
                    },
                  );
                },
                itemCount: state.books.length,
              )),
              if (state.bestCommercialOffer != null &&
                  state.bestTotalCart != null) ...[
                CartOffer(
                    bestOffer: state.bestCommercialOffer!,
                    totalPrice: state.bestTotalCart!)
              ]
            ]);
          case BookStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
