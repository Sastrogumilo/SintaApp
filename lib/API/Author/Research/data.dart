/*
Class untuk deserialisasi JSON
 */

class ParseData{
  //final subject;
  final nidn;
  final researchTotal;
  final researchArticle;

  ParseData({
  
  this.nidn,
  this.researchArticle,
  this.researchTotal
    //this.subject,
  });
  factory ParseData.fromJson(Map<String, dynamic> parsedJson){
    return ParseData(
      nidn: parsedJson['author']['nidn'],
      researchTotal: parsedJson['author']['researchs']['total'],
      researchArticle: parsedJson['author']['researchs']['article']
    );
  }
}

