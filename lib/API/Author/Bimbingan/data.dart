/*
Class untuk deserialisasi JSON
 */

class ParseData{
  final nidn;
  final bimbingan;

  //final subject;

  ParseData({
    this.nidn,
    this.bimbingan,
    //this.subject,
  });
  factory ParseData.fromJson(Map<String, dynamic> parsedJson){
    return ParseData(
      nidn: parsedJson['author']['nidn'],
      bimbingan: parsedJson['author']['bimbingan']['article']
    );
  }
}

