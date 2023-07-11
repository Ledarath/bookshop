# Bookshop

This is a simple implemation of "Bookshop" exercice.

## Choices

- Clean architecture (kinda)
- State Manager : flutter_bloc
- HttpClient : dio

## Logic

Cart is computed dynamically when you select a book.

## Improvements

- Only single page. Need to create a Cart page to properly handle cart (remove, details ...). And add a router package (like GoRouter). BlocProvider should be created once before the routing layer.
- Cart logic was implemented inside the book_bloc because of time constraint. Another dedicated bloc should be created for that.
- Styling need improvement focus was on functionality.
- Errors cases should be handled properly.
- Unit test & integration test can be added.
- Book list: Should display the number of occurency of a book inside the cart for better UX.
