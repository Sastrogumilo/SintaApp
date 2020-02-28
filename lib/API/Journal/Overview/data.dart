/*
Class untuk deserialisasi JSON
 */

class ParseDataJournal{
  final journalId;
  final eissn;
  final pissn;
  final journalName;
  final journalInstitusi;
  final sintaScore;
  final impact3;
  final scopusStatus;
  final garudaId;
  final googleId;
  final googleHindex5;
  final googleCitation5;
  final googleHindex;
  final googleCitation;
  final akreditasiJournal;


  ParseDataJournal({
    this.akreditasiJournal,
    this.sintaScore,
    this.eissn,
    this.garudaId,
    this.googleCitation,
    this.googleCitation5,
    this.googleHindex,
    this.googleHindex5,
    this.googleId,
    this.impact3,
    this.journalId,
    this.journalInstitusi,
    this.journalName,
    this.pissn,
    this.scopusStatus,

  });
  factory ParseDataJournal.fromJson(Map<String, dynamic> parsedJson){
    return ParseDataJournal(
      journalId: parsedJson['journal']['id'],
      eissn: parsedJson['journal']['EISSN'],
      pissn: parsedJson['journal']['PISSN'],
      journalName: parsedJson['journal']['name'],
      journalInstitusi: parsedJson['journal']['institusi'],
      sintaScore: parsedJson['journal']['sinta_score'],
      impact3: parsedJson['journal']['impact_3'],
      scopusStatus: parsedJson['journal']['scopus'],
      garudaId: parsedJson['journal']['garuda_id'],
      googleId: parsedJson['journal']['google_id'],
      googleHindex5: parsedJson['journal']['google_hindex5'],
      googleCitation5: parsedJson['journal']['google_citations5'],
      googleHindex: parsedJson['journal']['google_hindex'],
      googleCitation: parsedJson['journal']['google_citations'],
      akreditasiJournal: parsedJson['journal']['akreditasi'],

    );
  }
}

