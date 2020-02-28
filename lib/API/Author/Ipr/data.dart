/*
Class untuk deserialisasi JSON
 */

class ParseData{
  final nidn;
  final hkiTotal;
  final hkiArticle;
  //final subject;

  ParseData({
    this.nidn,
    this.hkiArticle,
    this.hkiTotal
    //this.subject,
  });
  factory ParseData.fromJson(Map<String, dynamic> parsedJson){
    return ParseData(
      nidn: parsedJson['author']['nidn'],
      hkiTotal: parsedJson['author']['hki']['total'],
      hkiArticle: parsedJson['author']['hki']['hki']
    );
  }
}

