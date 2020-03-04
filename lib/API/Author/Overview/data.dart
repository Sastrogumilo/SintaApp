/*
Class untuk deserialisasi JSON
 */

class ParseData{
  final name;
  final univ;
  final prodi;
  final sintaScore;
  final sintaScore3;
  final sintaScorev2;
  final sintaScorev23y;
  final scopusCitation;
  final scopusHindex;
  final scopusGindex;
  final scopusI10;
  final scopusArticle;
  final googleCitations;
  final googleHindex;
  final googleGindex;
  final googleI10;
  final googleArticle;
  final nationalRank;
  final afilRank;
  final nationalRank3;
  final afilRank3;
  final scopusQ2;
  final scopusQ3;
  final scopusQ4;
  //final subject;

  ParseData({
    this.name,
    this.univ,
    this.prodi,
    this.afilRank,
    this.afilRank3,
    this.scopusArticle,
    this.googleArticle,
    this.googleCitations,
    this.googleGindex,
    this.googleHindex,
    this.googleI10,
    this.scopusI10,
    this.nationalRank,
    this.nationalRank3,
    this.scopusCitation,
    this.scopusGindex,
    this.scopusHindex,
    this.scopusQ2,
    this.scopusQ3,
    this.scopusQ4,
    this.sintaScore,
    this.sintaScore3,
    this.sintaScorev2,
    this.sintaScorev23y,
    //this.subject,
  });
  factory ParseData.fromJson(Map<String, dynamic> parsedJson){
    return ParseData(
      name: parsedJson['author']['name'],
      univ: parsedJson['author']['afiliation']['name'],
      prodi: parsedJson['author']['prodi']['nama'],
      afilRank: parsedJson['author']['rank']['affil_rank'],
      afilRank3: parsedJson['author']['rank']['affil_rank_3'],
      scopusArticle: parsedJson['author']['scopus_article'],
      googleArticle: parsedJson['author']['google_article'],
      googleCitations: parsedJson['author']['google_citations'],
      scopusCitation: parsedJson['author']['scopus_citation'],
      googleGindex: parsedJson['author']['google_gindex'],
      googleHindex: parsedJson['author']['google_hindex'],
      googleI10: parsedJson['author']['google_i10'],
      scopusGindex: parsedJson['author']['scopus_gindex'],
      scopusHindex: parsedJson['author']['scopus_hindex'],
      sintaScore3: parsedJson['author']['sinta_score_3'],
      sintaScore: parsedJson['author']['sinta_score'],
      sintaScorev2: parsedJson['author']['sinta_score_v2'],
      sintaScorev23y: parsedJson['author']['sinta_score_v2_3y'],
      scopusQ2: parsedJson['author']['scopus_quartile']['2'],
      scopusQ3: parsedJson['author']['scopus_quartile']['3'],
      scopusQ4: parsedJson['author']['scopus_quartile']['4'],
      scopusI10: parsedJson['author']['scopus_i10'],
      nationalRank: parsedJson['author']['rank']['national_rank'],
      nationalRank3: parsedJson['author']['rank']['national_rank_3'],
    );
  }
}

