/*
Class untuk deserialisasi JSON
 */

class ParseData{
  //final subject;
  final nidn;
  final googleTotal;
  final googleArticle;

  ParseData({
  this.nidn,
  this.googleTotal,
  this.googleArticle  //this.subject,
  });
  factory ParseData.fromJson(Map<String, dynamic> parsedJson){
    return ParseData(
      nidn: parsedJson['author']['nidn'],
      googleTotal: parsedJson['author']['g_scholar']['total'],
      googleArticle: parsedJson['author']['g_scholar']['article'],
    );
  }
}

