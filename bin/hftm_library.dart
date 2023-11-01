import 'dart:core';

import 'package:hftm_library/book.dart';
import 'package:hftm_library/store/library_store.dart';
import 'dart:io';

final String divider = "------------------------------------------";
LibraryStore libraryStore = LibraryStore();

void main(List<String> arguments) async {

  bool exit = false;

  while( !exit ) {
    var selectedOption = showMenu();

    print(divider);

    switch (selectedOption) {
      case 1:
        var book = await addBook();
        print("$book added");
        break;
      case 2:
        var book = await removeBook();
        print("$book removed");
        break;
      case 3:
        print("List of all books: ");

        var books = await getBooks();

        books.forEach((book) => print(book.title));

        break;
      case 4:
        print("Bye!");
        exit = true;
        break;
    }

    print(divider);
  }
}

int showMenu() {

  String? input;

  do {
    print("1. Add book");
    print("2. Remove book");
    print("3. List books");
    print("4. Exit");

    input = stdin.readLineSync()!;

    if( int.tryParse(input) == null )
    {
      print("Invalid option");
      input = null;
    }
  } while (input == null || input.isEmpty);


  return int.parse(input);
}

Future<String> removeBook() async{
  String bookname = setBookAttribute( "Bookname", validateBookDeletion );

  libraryStore.remove(bookname);

  return bookname;
}

bool validateBookDeletion( String bookname ) {
  if( !libraryStore.contains(bookname) )
  {
    print("Book does not exist");
    return false;
  }

  return true;
}

bool validateBookname( String bookname ) {
  if( libraryStore.contains(bookname) )
  {
    print("Book already exists");
    return false;
  }

  return true;
}

bool doNoValidation(String value) {
  return true;
}

String setBookAttribute( String label, [Function(String)? validator] ) {
  String attribute;

  do {
    print( "$label: " );
    attribute = stdin.readLineSync()!;

    if( attribute.isEmpty ) {
      print("$label is required");
    }

  } while(attribute.isEmpty || validator != null && !validator(attribute));

  return attribute;
}

Future<Book> addBook() async {
  bool isValid = false;

  String bookname;
  String subtitle;
  String author;

  do {
    bookname = setBookAttribute( "Bookname", validateBookname );
    subtitle = setBookAttribute( "Subtitle" );
    author = setBookAttribute( "Author" );

    isValid = true;
  } while ( !isValid );

  var book = Book(bookname, subtitle, author);

  await libraryStore.add(book);

  return book;
}

Future<List<Book>> getBooks() async {
  return libraryStore.getBooks();
}
