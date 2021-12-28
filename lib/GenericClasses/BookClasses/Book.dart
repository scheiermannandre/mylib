// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:mylib/GenericClasses/BookClasses/BookDTO.dart';
import 'package:mylib/GenericClasses/BookClasses/Exceptions/EmptyBookParameterException.dart';
import 'package:mylib/GenericClasses/BookClasses/Exceptions/InvalidBookParameterException.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningState.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingState.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';
import 'package:mylib/GenericClasses/StaticMethodsClass.dart';

/// Class to represent an instance of a book.
class Book {
  late int id = 0;
  late String title = "";
  late String? subTitle = "";
  late String? author = "";
  late String? description = "";
  late String? imageLink = "";
  late ReadingState readingState = ReadingStateNotStarted();
  late OwningState owningState = OwningStateWishlist();

  ///Builder Constructor creates an inctance of Book depending on the [builder].
  ///Throws [InvalidBookParameterException] if Id not greater 0!
  ///Throws [EmptyBookParameterException] if Title is empty!
  Book._builder(BookBuilder builder) {
    id = builder._id;
    title = builder._title;
    subTitle = builder._subTitle;
    author = builder._author;
    description = builder._description;
    imageLink = builder._imageLink;
    readingState = builder._readingState;
    owningState = builder._owningState;
    ValidateParameter();
  }

  /// Copy-Constructor creating a copied instance of a [book].
  Book.fromBook(Book book) {
    id = book.id;
    title = book.title;
    subTitle = book.subTitle;
    author = book.author;
    description = book.description;
    imageLink = book.imageLink;
    readingState = book.readingState;
    owningState = book.owningState;
    ValidateParameter();
  }

  /// Constructor for creating a Book instance based on the Json fetched from the DB!
  Book.fromJsonDB(Map<String, dynamic> bookJson) {
    int? tmpId = bookJson['Id'];
    String? tmpTitle = bookJson['Title'];
    String? tmpReadingState = bookJson['ReadingState'];
    String? tmpOwningState = bookJson['OwningState'];
    id = StaticMethods.IsNull(tmpId)
        ? throw InvalidBookParameterException(
            "Fetched book-Json from DB doesn't contain a Id", "Id", "NULL")
        : tmpId!.toInt();
    title = StaticMethods.IsNull(tmpTitle)
        ? throw InvalidBookParameterException(
            "Fetched book-Json from DB doesn't contain a title",
            "Title",
            "NULL")
        : tmpTitle.toString();
    subTitle = bookJson['SubTitle'];
    author = bookJson['Author'];
    description = bookJson['Description'];
    imageLink = bookJson['ImageLink'];
    readingState = StaticMethods.IsNull(tmpReadingState)
        ? readingState
        : ReadingState.SetReadingStateFromString(tmpReadingState.toString());
    owningState = StaticMethods.IsNull(tmpOwningState)
        ? owningState
        : OwningState.SetOwningStateFromString(tmpOwningState.toString());
    ValidateParameter();
  }

  BookDTO ExtractBookDTO() {
    BookDTO bookDTO = BookDTO();
    bookDTO.id = id;
    bookDTO.title = title;
    bookDTO.subTitle = subTitle;
    bookDTO.author = author;
    bookDTO.description = description;
    bookDTO.imageLink = imageLink;
    bookDTO.readingState = readingState.toString();
    bookDTO.owningState = owningState.toString();

    return bookDTO;
  }

  void ValidateParameter() {
    if (id <= 0) {
      throw InvalidBookParameterException(
          "Id must be greater 0!", "id", id.toString());
    }
    if (title.isEmpty) {
      throw EmptyBookParameterException(
        "Title must not be empty!",
        "title",
      );
    }
  }

  void SetOwningStateLibrary() {
    owningState.AddToLibrary(this);
  }

  void SetOwningStateWishlist() {
    owningState.AddToWishlist(this);
  }

  void SetReadingStateNotStarted() {
    readingState.ChangeState(this);
  }

  void SetReadingStateReading() {
    readingState.ChangeState(this);
  }

  void SetReadingStateFinished() {
    readingState.ChangeState(this);
  }
}

class BookBuilder {
  late int _id;
  late String _title = "";
  late String _subTitle = "";
  late String _author = "";
  late String _description = "";
  late String _imageLink = "";
  late ReadingState _readingState = ReadingStateNotStarted();
  late OwningState _owningState = OwningStateWishlist();

  BookBuilder();

  BookBuilder setId(int id) {
    _id = id;
    return this;
  }

  BookBuilder setTitle(String title) {
    _title = title;
    return this;
  }

  BookBuilder setSubTitle(String subTitle) {
    _subTitle = subTitle;
    return this;
  }

  BookBuilder setAuthor(String author) {
    _author = author;
    return this;
  }

  BookBuilder setDescription(String description) {
    _description = description;
    return this;
  }

  BookBuilder setImageLink(String imageLink) {
    _imageLink = imageLink;
    return this;
  }

  BookBuilder setReadingState(ReadingState readingState) {
    _readingState = readingState;
    return this;
  }

  BookBuilder setOwningState(OwningState owningState) {
    _owningState = owningState;
    return this;
  }

  Book buildBook() {
    return Book._builder(this);
  }
}
  //
  //  // Book.outOfJSON(VolumeInfo info, this.readingState, this.owningState) {
  //   title = info.title;
  //   subTitle = info.subTitle;
  //   author = info.author.author;
  //   description = info.description;
  //   imageLink = info.image.thumbnail;
  //   //image = image.replaceRange(0, image.indexOf(':'), "https");
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'title': title,
  //     'subTitle': subTitle,
  //     'author': author,
  //     'description': description,
  //     'image': imageLink,
  //     'readingState': readingState.toString(),
  //     'wishLib': owningState.toString(),
  //   };
  // }

  // factory Book.fromJsonAPI(Map<String, dynamic>? parsedJson) {
  //   if (parsedJson != null) {
  //     String? title = parsedJson['title'];
  //     title = title ?? "";
  //     String? subTitle = parsedJson['subtitle'];
  //     subTitle = subTitle ?? "";
  //     String author = "";
  //     List<dynamic>? authors = parsedJson['authors'];
  //     if (authors != null) {
  //       if (authors.isNotEmpty) {
  //         author = authors[0];
  //       }
  //     }
  //     String? description = parsedJson['description'];
  //     description = description ?? "";
  //     Map<String, dynamic>? imageLinks = parsedJson['imageLinks'];
  //     String? imageLink = "";
  //     if (imageLinks != null) {
  //       imageLink = imageLinks['thumbnail'];
  //       imageLink = imageLink!.replaceRange(0, imageLink.indexOf(':'), "https");
  //     }
  //     return Book(title, subTitle, author, description, imageLink,
  //         Status.notStarted, WishLib.none);
  //   } else {
  //     return throw JsonIsNullException();
  //   }
  // }
//}

// class JsonIsNullException {}

// class BookCollection {
//   Map<int, Book> libraryNew = <int, Book>{};
//   List<Book> library = [];
//   List<Book> wishlist = [];

//   void addToLibrary(Item book) {
//     library.add(
//         Book.outOfJSON(book.volumeinfo, Status.notStarted, WishLib.library));
//   }

//   void addToWishlist(Item book) {
//     wishlist.add(
//         Book.outOfJSON(book.volumeinfo, Status.notStarted, WishLib.wishList));
//   }

//   void clear() {
//     library.clear();
//     wishlist.clear();
//   }

//   List<Book> currentlyReadingBooks() {
//     List<Book> currentlyReadingBooks = [];
//     for (Book b in library) {
//       if (b.readingState == Status.reading) {
//         currentlyReadingBooks.add(b);
//       }
//     }
//     return currentlyReadingBooks;
//   }

//   BookCollection();
//   BookCollection.loadJson(List<dynamic> jsonList) {
//     for (Map i in jsonList) {
//       Book book = Book.fromJsonDB(i);
//       if (book.wishLib == WishLib.library) {
//         library.add(book);
//       } else {
//         wishlist.add(book);
//       }
//     }
//   }
// }
