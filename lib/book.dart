class Book {
  String _title;
  String _subtitle;
  String _author;

  Book(this._title, this._subtitle, this._author);

  String get author => _author;

  String get subtitle => _subtitle;

  String get title => _title;
}