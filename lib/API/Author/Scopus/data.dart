/*
Class untuk deserialisasi JSON
 */

class ParseData{
  //final subject;
  final nidn;
  final scopusTotal;
  final scopusArticle;

  ParseData({
  
  this.nidn,
  this.scopusArticle,
  this.scopusTotal
    //this.subject,
  });
  factory ParseData.fromJson(Map<String, dynamic> parsedJson){
    return ParseData(
      nidn: parsedJson['author']['nidn'],
      scopusTotal: parsedJson['author']['scopus']['total'],
      scopusArticle: parsedJson['author']['scopus']['article']
    );
  }
}

