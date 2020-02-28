/*
Class untuk deserialisasi JSON
 */

class ParseData{
  //final subject;
  final nidn;
  final serviceTotal;
  final serviceArticle;

  ParseData({
  
  this.nidn,
  this.serviceArticle,
  this.serviceTotal
    //this.subject,
  });
  factory ParseData.fromJson(Map<String, dynamic> parsedJson){
    return ParseData(
      nidn: parsedJson['author']['nidn'],
      serviceTotal: parsedJson['author']['services']['total'],
      serviceArticle: parsedJson['author']['services']['article']
    );
  }
}

