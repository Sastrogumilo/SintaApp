/*
Class untuk deserialisasi JSON
 */

class AuthorOverview{
  final name;
  final univ;
  final prodi;
  //final subject;

  AuthorOverview({
    this.name,
    this.univ,
    this.prodi,
    //this.subject,
  });
  factory AuthorOverview.fromJson(Map<String, dynamic> parsedJson){
    return AuthorOverview(
      name: parsedJson['author']['name'],
      univ: parsedJson['author']['afiliation']['name'],
      prodi: parsedJson['author']['prodi']['nama'],
      //subject: parsedJson['author']['subjects']
    );
  }
}

