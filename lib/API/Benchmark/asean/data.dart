/*
Class untuk deserialisasi JSON
1 */

class ParseDataBenchmark{
  final data;


  ParseDataBenchmark({
    this.data,

  });
  factory ParseDataBenchmark.fromJson(Map<String, dynamic> parsedJson){
    return ParseDataBenchmark(
      data: parsedJson['data'],
    );
  }
}

