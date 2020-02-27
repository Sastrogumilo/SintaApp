/*
Class untuk deserialisasi JSON
 */

class AuthorOverview{
  AuthorName name;
  AuthorAfiliation univ;
  AuthorProdi prodi;
  AuthorSubject subject;

  AuthorOverview({
    this.name,
    this.univ,
    this.prodi,
    this.subject,
  });
  factory AuthorOverview.fromJson(Map<String, dynamic> parsedJson){
    return AuthorOverview(
      name: AuthorName.fromJson(parsedJson['author']),
      univ: AuthorAfiliation.fromJson(parsedJson['afiliation']),
      prodi: AuthorProdi.fromJson(parsedJson['prodi']),
      subject: AuthorSubject.fromJson(parsedJson['subject']),
    );
  }

}

class AuthorName{
  String authorName;

  AuthorName({
    this.authorName,
  });

  factory AuthorName.fromJson(Map<String, String> json){
    return AuthorName(authorName: json['name']);
  }
}

class AuthorAfiliation{
  String univName;

  AuthorAfiliation({this.univName});

  factory AuthorAfiliation.fromJson(Map<String, String> json){
    return AuthorAfiliation(univName: json['name']);
  }
}

class AuthorProdi{
  String authorProdi;

  AuthorProdi({this.authorProdi});

  factory AuthorProdi.fromJson(Map<String, String> json){
    return AuthorProdi(authorProdi: json['nama']);
  }
}

class AuthorSubject{
  String authorSubject;

  AuthorSubject({this.authorSubject});

  factory AuthorSubject.fromJson(Map<String, String> json){
    return AuthorSubject(authorSubject: json['subject_name']);
  }
}

