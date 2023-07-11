final class Book {
  String title;
  num price;
  String cover;
  String isbn;
  List<String> synopsis;

  Book({
    required this.title,
    required this.price,
    required this.cover,
    required this.isbn,
    required this.synopsis,
  });

  static Book fromJson(Map<String, dynamic> json) {
    var synopsisApi = json['synopsis'] as List<dynamic>;

    return Book(
      title: json['title'],
      price: json['price'],
      cover: json['cover'],
      isbn: json['isbn'],
      synopsis: synopsisApi.map<String>((json) => json.toString()).toList(),
    );
  }
}
