import 'package:bookshop/data/book/model.dart';
import 'package:bookshop/data/book/repository.dart';
import 'package:bookshop/data/offers/model.dart';
import 'package:bookshop/data/offers/repository.dart';
import 'package:bookshop/presentation/book/bloc/book_event.dart';
import 'package:bookshop/presentation/book/bloc/book_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;
  final OfferRepository offerRepository;

  BookBloc({required this.bookRepository, required this.offerRepository})
      : super(const BookState()) {
    on<BookFetched>(_onBookFetched);

    on<BookAdded>(_onBookAdded);
  }

  Future<void> _onBookFetched(
      BookFetched event, Emitter<BookState> emit) async {
    try {
      final books = await bookRepository.fetchBooks();
      emit(state.copyWith(status: BookStatus.success, books: books));
    } on Exception {
      emit(state.copyWith(status: BookStatus.failure));
    }
  }

  Future<void> _onBookAdded(BookAdded event, Emitter<BookState> emit) async {
    List<Book> newSelectedBooks = [];

    newSelectedBooks.addAll(state.selectedBooks);

    newSelectedBooks.add(event.book);

    emit(state.copyWith(selectedBooks: newSelectedBooks));

    await computeNewOffer(newSelectedBooks, emit);
  }

  Future<void> computeNewOffer(
      List<Book> newSelectedBooks, Emitter<BookState> emit) async {
    List<Offer> commercialOffers;

    try {
      commercialOffers = await offerRepository
          .fetchOffers(newSelectedBooks.map((e) => e.isbn).toList());
    } on Exception {
      emit(state.copyWith(status: BookStatus.failure));
      return;
    }

    num totalCart = newSelectedBooks
        .map((e) => e.price)
        .reduce((value, element) => value + element);

    Offer bestOffer = findBestOffer(totalCart, commercialOffers);

    var newTotal = getTotalFromOffer(bestOffer, totalCart);

    emit(state.copyWith(
        bestCommercialOffer: bestOffer, bestTotalCart: newTotal));
  }

  Offer findBestOffer(num totalCart, List<Offer> commercialOffers) {
    var bestOffer = commercialOffers.reduce((firstOffer, secondOffer) {
      var firstOfferTotal = getTotalFromOffer(firstOffer, totalCart);
      var secondOfferTotal = getTotalFromOffer(secondOffer, totalCart);

      return firstOfferTotal < secondOfferTotal ? firstOffer : secondOffer;
    });

    return bestOffer;
  }

  num getTotalFromOffer(Offer offer, num total) {
    switch (offer.type) {
      case OfferType.percentage:
        return total - (total * offer.value / 100);
      case OfferType.minus:
        return total - offer.value;
      case OfferType.slice:
        var sliceValue = offer.sliceValue;
        if (sliceValue == null) {
          return total; // TODO: throw exception and handle it properply
        }

        return total - (offer.value * (total ~/ sliceValue));
      default:
        return total;
    }
  }
}
