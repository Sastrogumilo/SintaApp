/*
Class untuk deserialisasi JSON
 */

class ParseData{
  //final subject;
  final nidn;
  final books;
  final bookTotal;

  ParseData({
  this.nidn,
  this.bookTotal,
  this.books,  //this.subject,
  });
  factory ParseData.fromJson(Map<String, dynamic> parsedJson){
    return ParseData(
      nidn: parsedJson['author']['nidn'],
      books: parsedJson['author']['books']['book'],
      bookTotal: parsedJson['author']['books']['total'],
    );
  }
}

