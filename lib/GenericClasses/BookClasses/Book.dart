// ignore_for_file: file_names

import 'package:mylib/GenericClasses/BookClasses/Exceptions/EmptyBookParameterException.dart';
import 'package:mylib/GenericClasses/BookClasses/Exceptions/InvalidBookParameterException.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningState.dart';
import 'package:mylib/GenericClasses/StateClasses/OwningState/OwningStateWishlist.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingState.dart';
import 'package:mylib/GenericClasses/StateClasses/ReadingState/ReadingStateNotStarted.dart';

/// Class to represent an instance of a book.
class Book {
  late int id = 0;
  late String title = "";
  late String subTitle = "";
  late String author = "";
  late String description = "";
  late String imageLink = "";
  late ReadingState readingState = ReadingStateNotStarted();
  late OwningState owningState = OwningStateWishlist();

  ///Builder Constructor creates an inctance of Book depending on the [builder]
  ///[InvalidBookParameterException] if Id not greater 0!
  ///[EmptyBookParameterException] if Title is empty!
  Book._builder(BookBuilder builder) {
    if (builder._id <= 0) {
      throw InvalidBookParameterException(
          "Id must be greater 0!", "id", builder._id.toString());
    }
    if (builder._title.isEmpty) {
      throw EmptyBookParameterException(
        "Title must not be empty!",
        "title",
      );
    }
    id = builder._id;
    title = builder._title;
    subTitle = builder._subTitle;
    author = builder._author;
    description = builder._description;
    imageLink = builder._imageLink;
    readingState = builder._readingState;
    owningState = builder._owningState;
  }

  /// Copy-Constructor creating a copied instance of a book.
  Book.fromBook(Book book) {
    id = book.id;
    title = book.title;
    subTitle = book.subTitle;
    author = book.author;
    description = book.description;
    imageLink = book.imageLink;
    readingState = book.readingState;
    owningState = book.owningState;
  }

  Book.fromJsonDB(Map<String, dynamic> bookJson) {
    id = bookJson['Id'];
    title = bookJson['Title'];
    subTitle = bookJson['Subtitle'];
    author = bookJson['Author'];
    description = bookJson['Description'];
    imageLink = bookJson['Imagelink'];
    readingState = bookJson['ReadingState'];
    owningState = bookJson['OwningState'];
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
