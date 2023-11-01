import '../book.dart';

class LibraryStore {
  static final LibraryStore _singleton = LibraryStore._internal();

  factory LibraryStore() {
    return _singleton;
  }

  LibraryStore._internal();

  final List<Book> _library = [];

  Future<List<Book>> getBooks() async {
    return Future.delayed(Duration(seconds: 2), () => _library);
    // return _library;
  }

  bool contains( String book ) {
    return _library.any((element) => book == element.title);
  }

  Future<void> add(Book book) async {
    return Future.delayed(Duration(seconds: 3), () => _library.add(book));
  }

  void remove(String bookParam) async {
    Future.delayed(Duration(seconds: 1), () => _library.removeWhere((book) => book.title == bookParam) );
  }
}