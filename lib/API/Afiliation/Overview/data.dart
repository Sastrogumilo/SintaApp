/*
Class untuk deserialisasi JSON
 */

class ParseDataAffiliation{

  final fullname;
  final kodePT;
  final name;
  final website;
  final deskripsi;
  final img;
  final sintaScore;
  final sintaScoreV2;
  final sintaScoreV23y;
  final scopusDoc;
  final scopusCitation;
  final googleDoc;
  final googleCitation;
  final scopusJournal;
  final scopusBookChapter;
  final scopusConference;
  final rank;
  final q1;
  final q2;
  final q3;
  final q4;
  final qUnidentified;
  final akreditasi;
  final academicGrade;
  final topScopus;
  final scopusPerYear;
  final scopusPerProdi;
  final sintaScore3;

  ParseDataAffiliation({
    this.name,
    this.sintaScore3,
    this.academicGrade,
    this.akreditasi,
    this.deskripsi,
    this.fullname,
    this.googleCitation,
    this.googleDoc,
    this.img,
    this.kodePT,
    this.q1,
    this.q2,
    this.q3,
    this.q4,
    this.qUnidentified,
    this.rank,
    this.scopusBookChapter,
    this.scopusCitation,
    this.scopusConference,
    this.scopusDoc,
    this.scopusJournal,
    this.scopusPerProdi,
    this.scopusPerYear,
    this.sintaScore,
    this.sintaScoreV2,
    this.sintaScoreV23y,
    this.topScopus,
    this.website,

  });
  factory ParseDataAffiliation.fromJson(Map<String, dynamic> parsedJson){
    return ParseDataAffiliation(
      name: parsedJson['afiliasi']['afiliasi_abbrev'],
      fullname: parsedJson['afiliasi']['afiliasi_name'],
      kodePT: parsedJson['afiliasi']['kode_pt'],
      website: parsedJson['afiliasi']['afiliasi_website'],
      deskripsi: parsedJson['afiliasi']['afiliasi_deskripsi'],
      img: parsedJson['afiliasi']['img'],
      sintaScore: parsedJson['afiliasi']['sinta_score'],
      sintaScore3: parsedJson['afiliasi']['sinta_score_3'],
      sintaScoreV2: parsedJson['afiliasi']['sinta_score_v2_all'],
      sintaScoreV23y: parsedJson['afiliasi']['sinta_score_v2_3y'],
      scopusDoc: parsedJson['afiliasi']['scopus_doc'],
      scopusCitation: parsedJson['afiliasi']['scopus_citation'],
      googleDoc: parsedJson['afiliasi']['gs_doc'],
      googleCitation: parsedJson['afiliasi']['gs_citation'],
      scopusJournal: parsedJson['afiliasi']['scopus_journal'],
      scopusBookChapter: parsedJson['afiliasi']['scopus_bookchap'],
      scopusConference: parsedJson['afiliasi']['scopus_conference'],
      rank: parsedJson['afiliasi']['rank'],
      q1: parsedJson['afiliasi']['quartile']['1'],
      q2: parsedJson['afiliasi']['quartile']['2'],
      q3: parsedJson['afiliasi']['quartile']['3'],
      q4: parsedJson['afiliasi']['quartile']['4'],
      qUnidentified: parsedJson['afiliasi']['quartile']['undefined'],
      akreditasi: parsedJson['afiliasi']['akreditasi'],
      academicGrade: parsedJson['afiliasi']['academic_grade'],
      topScopus: parsedJson['afiliasi']['top_scopus_per_year'],
      scopusPerYear: parsedJson['afiliasi']['scopus_per_year'],
      scopusPerProdi: parsedJson['afiliasi']['scopus_per_prodi'],

    );
  }
}

