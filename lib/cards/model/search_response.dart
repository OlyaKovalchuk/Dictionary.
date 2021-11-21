class SearchResponse {
  late String word;
  late List<Phonetics>? phonetics;
  late List<Meanings> meanings;

  SearchResponse(
      {required this.word, required this.phonetics, required this.meanings});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    if (json['phonetics'] != null) {
      phonetics = <Phonetics>[];
      json['phonetics'].forEach((v) {
        phonetics?.add(new Phonetics.fromJson(v));
      });
    }
    if (json['meanings'] != null) {
      meanings = <Meanings>[];
      json['meanings'].forEach((v) {
        meanings.add(new Meanings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['phonetics'] = this.phonetics?.map((v) => v.toJson()).toList();
    data['meanings'] = this.meanings.map((v) => v.toJson()).toList();
    return data;
  }
}

class Phonetics {
  late String? text;
  late String? audio;

  Phonetics({required this.text, required this.audio});

  Phonetics.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['audio'] = this.audio;
    return data;
  }
}

class Meanings {
  late String partOfSpeech;
  late List<Definitions> definitions;

  Meanings({required this.partOfSpeech, required this.definitions});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    if (json['definitions'] != null) {
      definitions = <Definitions>[];
      json['definitions'].forEach((v) {
        definitions.add(new Definitions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partOfSpeech'] = this.partOfSpeech;
    data['definitions'] = this.definitions.map((v) => v.toJson()).toList();
    return data;
  }
}

class Definitions {
  late String definition;
  String? example;
  List<String>? synonyms;

  Definitions({required this.definition, this.example, this.synonyms});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    example = json['example'];
    if (json['synonyms'] != null) {
      synonyms = json['synonyms'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['definition'] = this.definition;
    data['example'] = this.example;
    data['synonyms'] = this.synonyms;
    return data;
  }
}
