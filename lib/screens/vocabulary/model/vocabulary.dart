class Vocabulary {
  String id;
  String text;
  String image;
  String spelling;
  String meaning;
  Vocabulary(
      {this.id = '',
      required this.text,
      required this.image,
      required this.spelling,
      required this.meaning});
  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'image': image,
        'spelling': spelling,
        'meaning': meaning,
      };
}
