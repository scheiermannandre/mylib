// // ignore_for_file: avoid_print, file_names

// import 'package:mylib/GenericClasses/Book.dart';

// class VolumeJson {
//   final int totalItems;
//   final List<Item> items;

//   VolumeJson({required this.items, required this.totalItems});

//   factory VolumeJson.fromJson(Map<String, dynamic>? parsedJson) {
//     if (parsedJson == null) {
//       print("VolumeJson parsedJson == null");
//     }
//     var list = parsedJson!['items'] as List;

//     List<Item> itemList = list.map((i) => Item.fromJson(i)).toList();
//     print(itemList.length);

//     return VolumeJson(items: itemList, totalItems: parsedJson['totalItems']);
//   }
// }

// class Item {
//   final VolumeInfo volumeinfo;
//   Item({required this.volumeinfo});

//   factory Item.fromJson(Map<String, dynamic>? parsedJson) {
//     if (parsedJson == null) {
//       print("Item parsedJson == null");
//       return throw JsonIsNullException();
//     } else {
//       return Item(volumeinfo: VolumeInfo.fromJson(parsedJson['volumeInfo']));
//     }
//   }
// }

// class VolumeInfo {
//   final String title;
//   final String subTitle;
//   final Author author;
//   final String description;
//   final ImageLinks image;

//   VolumeInfo({
//     required this.title,
//     required this.subTitle,
//     required this.author,
//     required this.description,
//     required this.image,
//   });

//   factory VolumeInfo.fromJson(Map<String, dynamic> parsedJson) {
//     if (parsedJson == null) {
//       print("VolumeInfo parsedJson == null");
//       return throw JsonIsNullException();
//     } else {
//       return VolumeInfo(
//         title: parsedJson['title'],
//         subTitle: parsedJson['subtitle'],
//         author: Author.fromJson(
//           parsedJson['authors'],
//         ),
//         description: parsedJson['description'],
//         image: ImageLinks.fromJson(
//           parsedJson['imageLinks'],
//         ),
//       );
//     }
//   }
// }

// class ImageLinks {
//   final String thumbnail;
//   ImageLinks({this.thumbnail});

//   factory ImageLinks.fromJson(Map<String, dynamic> parsedJson) {
//     if (parsedJson == null) {
//       print("ImageLinks parsedJson == null");
//       return ImageLinks(thumbnail: null);
//     } else {
//       String imgURL = parsedJson['thumbnail'];
//       imgURL = imgURL.replaceRange(0, imgURL.indexOf(':'), "https");
//       return ImageLinks(thumbnail: imgURL);
//     }
//   }
// }

// class Author {
//   final String author;

//   Author({this.author});

//   factory Author.fromJson(List<dynamic> parsedJson) {
//     if (parsedJson == null) {
//       print("Author parsedJson == null");
//       return Author(author: null);
//     } else {
//       //var authorsFromJson = parsedJson;
//       //List<String> authorsList = new List<String>.from(parsedJson);
//       return Author(author: parsedJson[0] as String);
//     }
//   }
// }

// class ISBN {
//   final String iSBN13;
//   final String type;

//   ISBN({this.iSBN13, this.type});

//   factory ISBN.fromJson(Map<String, dynamic> parsedJson) {
//     return ISBN(
//       iSBN13: parsedJson['identifier'],
//       type: parsedJson['type'],
//     );
//   }
// }
