import 'package:bookshop/data/book/data.dart';
import 'package:bookshop/data/book/repository.dart';
import 'package:bookshop/data/offers/data.dart';
import 'package:bookshop/data/offers/repository.dart';
import 'package:bookshop/presentation/book/bloc/book_bloc.dart';
import 'package:bookshop/presentation/book/bloc/book_event.dart';
import 'package:bookshop/presentation/book/view/book_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatelessWidget {
  BookPage({super.key});

  final BookRepository bookRepository = BookRepository(bookApi: BookApi());
  final OfferRepository offerRepository = OfferRepository(offerApi: OfferApi());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) => BookBloc(
            bookRepository: bookRepository, offerRepository: offerRepository)
          ..add(BookFetched()),
        child: const BookList(),
      ),
    );
  }
}
