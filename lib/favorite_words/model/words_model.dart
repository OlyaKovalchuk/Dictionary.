import 'dart:convert';

class WordData {
  final String word;
  final String? audio;

  WordData({
    required this.word,
    required this.audio,
  });

  WordData copyWith({String? word, String? audio}) {
    return WordData(word: word ?? this.word, audio: audio ?? this.audio);
  }

  Map<String, String?> toMap() {
    return {'word': word, 'audio': audio};
  }

  Map<String, String?> onlyTextMap() {
    return {'word': word, 'audio': audio};
  }

  factory WordData.fromMap(Map<String, dynamic> map) {
    return WordData(word: map['word'], audio: map['audio'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory WordData.fromJson(String source) =>
      WordData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WordData(word: $word, audio: $audio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WordData && other.word == word && other.audio == audio;
  }

  @override
  int get hashCode {
    return word.hashCode ^ audio.hashCode;
  }
}
